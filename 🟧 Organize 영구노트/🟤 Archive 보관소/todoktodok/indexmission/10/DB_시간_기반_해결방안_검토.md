# DB 시간 기반 해결방안 검토

## 제안된 해결 방안

### 핵심 아이디어
> 시각 기준 불일치로 경계 판단이 오판된다.

### 개선 포인트
1. 쿠폰 엔티티에서 `validateIssuable(now)` 메서드로 기간 검증 수행
2. DB 타임존과 애플리케이션 타임존을 통일(UTC 권장)
3. DB의 CURRENT_TIMESTAMP 기반 기록 일원화
4. 배포 환경별 NTP 동기화 주기를 명확히 설정
5. 시각 비교는 DB 기준 NOW()로 수행

## 각 방안에 대한 상세 검토

### 1. `validateIssuable(now)` 메서드 ✅ (탁월함)

```java
// 현재 코드 (문제 있음)
public void issue() {
    if (this.issueEndedAt.isBefore(LocalDateTime.now())) {
        throw new IllegalArgumentException("쿠폰을 발급할 수 없는 시간입니다.");
    }
    // ...
}

// 제안: 시간을 파라미터로 받기
public void validateIssuable(LocalDateTime now) {
    if (this.issueStartedAt.isAfter(now) || this.issueEndedAt.isBefore(now)) {
        throw new IllegalArgumentException(
            String.format("쿠폰 발급 기간이 아닙니다. (현재: %s, 종료: %s)",
                now, this.issueEndedAt)
        );
    }
    // 상태 검증...
    // 수량 검증...
}
```

#### 평가: ✅ 탁월함

**장점**:
- 시간을 외부에서 주입받아 일관성 보장
- 검증 시점과 기록 시점에 동일한 시간 사용 가능
- TOCTOU 문제의 핵심 해결책
- 테스트 용이성 증가 (시간을 mocking 가능)

**이것은 제가 권장한 "방안 1: 시간 캡처"와 정확히 동일한 접근입니다.**

#### 구현 예시

```java
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    // 1. 트랜잭션 시작 시점에 시간 캡처
    LocalDateTime now = LocalDateTime.now();

    // 2. 모든 검증과 기록에 동일한 시간 사용
    Member member = memberService.getMember(memberId);
    Coupon coupon = couponService.getCouponWithLock(couponId);

    coupon.validateIssuable(now);  // 동일한 now

    MemberCoupon memberCoupon = MemberCoupon.issue(memberId, coupon, now);  // 동일한 now
    memberCouponRepository.save(memberCoupon);

    return memberCoupon;
}
```

### 2. DB 타임존과 애플리케이션 타임존 통일 ⚠️ (좋지만 별개 문제)

```yaml
# application.yml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/coupon?serverTimezone=UTC
  jpa:
    properties:
      hibernate:
        jdbc:
          time_zone: UTC

# Java 애플리케이션
java -Duser.timezone=UTC -jar app.jar
```

#### 평가: ⚠️ 좋은 실천 방법이지만, TOCTOU 문제와는 별개

#### 타임존 통일이 해결하는 문제

```
문제 상황: 타임존 불일치

서버 A (KST): 2025-11-01 00:00:00 (자정)
서버 B (UTC): 2025-10-31 15:00:00 (오후 3시)
DB (UTC):     2025-10-31 15:00:00

쿠폰 발급 종료: 2025-10-31 23:59:59
→ 어느 타임존 기준? KST? UTC? 혼란!

예시:
사용자가 KST 23:50에 요청
→ 서버 A는 KST로 해석: 발급 가능 ✓
→ 서버 B는 UTC로 해석: 이미 종료 ❌
→ 같은 요청인데 결과가 다름!
```

✅ **타임존 통일로 해결되는 것**:
- 서버/DB 간 시각 해석 불일치
- 다중 리전 배포 시 일관성
- 서머타임(DST) 문제

❌ **타임존 통일로 해결 안 되는 것**: TOCTOU

```java
// UTC로 통일해도 TOCTOU는 여전히 발생
서버 (UTC): 23:59:59.850 검증 ✓
[GC 500ms]
서버 (UTC): 00:00:00.400 기록 ❌

// 타임존과 상관없이 시간이 경과하는 게 문제!
```

#### 권장사항

```java
// ✅ 타임존 명시적 지정
LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);

// 또는 ZonedDateTime 사용
ZonedDateTime now = ZonedDateTime.now(ZoneOffset.UTC);
```

### 3. DB의 CURRENT_TIMESTAMP 기반 기록 일원화 ❌ (문제 있음!)

```sql
-- 제안: DB에서 자동으로 시간 기록
CREATE TABLE member_coupon (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    coupon_id BIGINT NOT NULL,
    issued_at DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6),  -- DB가 자동 설정
    modified_at DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    ...
);
```

#### 평가: ❌ 이것은 오히려 TOCTOU 문제를 악화시킵니다!

#### 문제 시나리오

```java
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    LocalDateTime now = LocalDateTime.now(); // 23:59:59.850

    // 애플리케이션에서 검증
    Coupon coupon = couponRepository.findById(couponId);
    if (coupon.getIssueEndedAt().isBefore(now)) {
        throw new IllegalArgumentException("발급 불가");
    }
    // 검증 통과 ✓ (23:59:59.850 기준)

    // --- GC 발생... 500ms ---

    // DB에 INSERT
    MemberCoupon memberCoupon = new MemberCoupon();
    memberCoupon.setMemberId(memberId);
    memberCoupon.setCoupon(coupon);
    // issued_at은 설정하지 않음 (DB DEFAULT 사용)

    memberCouponRepository.save(memberCoupon);
    // ↓
}
```

**실제 실행되는 SQL**:
```sql
-- 00:00:00.400에 실행됨 (GC 이후)
INSERT INTO member_coupon (member_id, coupon_id, issued_at)
VALUES (100, 1, CURRENT_TIMESTAMP(6));
--                ↑ DB 서버의 현재 시간 사용
-- 결과: issued_at = 2025-10-31 00:00:00.400000 ❌
```

**문제점**:

| 단계 | 시간 | 결과 |
|------|------|------|
| 애플리케이션 검증 | 23:59:59.850 | ✓ 통과 |
| GC 발생 | 500ms 경과 | - |
| DB INSERT | 00:00:00.400 | ❌ 종료 시간 초과 기록 |

#### 더 큰 문제: 검증 시점을 추적할 수 없음

```sql
-- 감사(Audit) 조회 시
SELECT * FROM member_coupon
WHERE issued_at > '2025-10-31 23:59:59'
ORDER BY issued_at;

-- 결과
| id    | issued_at               | member_id | coupon_id |
|-------|-------------------------|-----------|-----------|
| 12345 | 2025-10-31 00:00:00.100 | 100       | 1         |
| 12346 | 2025-10-31 00:00:00.150 | 101       | 1         |
| 12347 | 2025-10-31 00:00:00.400 | 102       | 1         |

문제:
- 이 쿠폰들이 부정하게 발급된 건가?
- 아니면 검증은 23:59:59에 통과했고, 기록만 늦어진 건가?
- 검증 시점 정보가 없어서 판단 불가능!
```

#### 올바른 접근

```java
// ❌ 잘못된 방법: DB에서 시간 결정
memberCoupon.setIssuedAt(null);  // DB DEFAULT 사용
save(memberCoupon);

// ✅ 올바른 방법: 애플리케이션에서 검증 시점의 시간 기록
LocalDateTime validationTime = LocalDateTime.now();
coupon.validateIssuable(validationTime);
memberCoupon.setIssuedAt(validationTime);  // 검증 시점과 동일
save(memberCoupon);
```

### 4. DB NOW()로 검증 수행 ❌ (불충분함)

#### 제안된 방식

```java
// DB 쿼리에서 시간 검증
@Query("SELECT c FROM Coupon c WHERE c.id = :id " +
       "AND c.issueStartedAt <= CURRENT_TIMESTAMP " +
       "AND c.issueEndedAt >= CURRENT_TIMESTAMP")
Coupon findIssuableCoupon(@Param("id") Long id);
```

#### 평가: ❌ 이것도 TOCTOU 문제를 해결하지 못합니다!

#### 문제 시나리오

```java
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    // 23:59:59.850 - DB에서 검증
    Coupon coupon = couponRepository.findIssuableCoupon(couponId);

    // 실행된 SQL:
    // SELECT * FROM coupon
    // WHERE id = 1
    //   AND issue_started_at <= CURRENT_TIMESTAMP  -- 23:59:59.850
    //   AND issue_ended_at >= CURRENT_TIMESTAMP    -- 23:59:59.850
    // 결과: 1 row (검증 통과 ✓)

    if (coupon == null) {
        throw new IllegalArgumentException("발급 불가");
    }

    // --- GC 발생... 500ms ---

    // 00:00:00.400 - MemberCoupon 생성
    MemberCoupon memberCoupon = new MemberCoupon();
    memberCoupon.setMemberId(memberId);
    memberCoupon.setCoupon(coupon);
    memberCoupon.setIssuedAt(LocalDateTime.now());  // 00:00:00.400

    // 00:00:00.420 - DB INSERT
    memberCouponRepository.save(memberCoupon);

    // 실행된 SQL:
    // INSERT INTO member_coupon (issued_at, ...)
    // VALUES ('2025-10-31 00:00:00.400000', ...)
    // ❌ 여전히 종료 시간 이후에 기록됨!
}
```

**문제**:
- SELECT 시점의 CURRENT_TIMESTAMP: 23:59:59.850 ✓
- INSERT 시점의 LocalDateTime.now(): 00:00:00.400 ❌
- 두 시점이 다름!

#### DB NOW()를 일관되게 사용해도 문제

```java
// 개선 시도: DB NOW()를 일관되게 사용
@Query(value =
    "INSERT INTO member_coupon (member_id, coupon_id, issued_at) " +
    "VALUES (:memberId, :couponId, CURRENT_TIMESTAMP)",
    nativeQuery = true)
void insertWithDbTime(@Param("memberId") Long memberId,
                      @Param("couponId") Long couponId);

// 사용
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    // 23:59:59.850 - SELECT with CURRENT_TIMESTAMP
    Coupon coupon = couponRepository.findIssuableCoupon(couponId);

    // --- GC 500ms ---

    // 00:00:00.400 - INSERT with CURRENT_TIMESTAMP
    memberCouponRepository.insertWithDbTime(memberId, couponId);
    // ❌ SELECT의 CURRENT_TIMESTAMP와 INSERT의 CURRENT_TIMESTAMP가 다름!
}
```

### 5. NTP 동기화 설정 ⚠️ (좋지만 별개 문제)

```bash
# chronyd 설치 및 활성화
sudo apt-get install chrony

# /etc/chrony/chrony.conf 설정
server 0.kr.pool.ntp.org iburst
server 1.kr.pool.ntp.org iburst
server 2.kr.pool.ntp.org iburst
server 3.kr.pool.ntp.org iburst

# 서비스 시작
sudo systemctl enable chronyd
sudo systemctl start chronyd

# 동기화 상태 확인
chronyc tracking
```

#### 평가: ⚠️ 좋은 인프라 설정이지만, TOCTOU와는 별개

#### NTP가 해결하는 문제

```
문제 상황: 서버 간 시각 불일치

서버 A 시각: 2025-10-31 23:59:55
서버 B 시각: 2025-10-31 00:00:05  (10초 차이!)
서버 C 시각: 2025-10-31 23:59:58
DB 서버:     2025-10-31 23:59:58

쿠폰 발급 종료: 2025-10-31 23:59:59

결과:
- 서버 A: 발급 가능 (23:59:55 < 23:59:59) ✓
- 서버 B: 발급 불가 (00:00:05 > 23:59:59) ❌
- 서버 C: 발급 가능 (23:59:58 < 23:59:59) ✓

→ 같은 시점의 요청인데 어느 서버에 걸리느냐에 따라 결과가 다름!
→ 로드밸런서 뒤에 여러 서버가 있으면 심각한 문제
```

✅ **NTP 동기화로 해결되는 것**:
- 서버 간 시각 동기화 (보통 ±1ms 이내)
- 분산 시스템의 일관성
- 로그 타임스탬프 정확성

❌ **NTP 동기화로 해결 안 되는 것**: 단일 서버 내 TOCTOU

```java
// NTP로 완벽히 동기화된 서버에서도...
23:59:59.850 검증 (정확한 시간)
[GC 500ms]
00:00:00.400 기록 (여전히 정확한 시간, 하지만 경과함)
```

#### NTP 동기화 모니터링

```bash
# 동기화 품질 확인
chronyc tracking

# 출력 예시:
Reference ID    : C0A80001 (192.168.0.1)
Stratum         : 3
Ref time (UTC)  : Fri Oct 31 14:23:45 2025
System time     : 0.000000123 seconds slow of NTP time
Last offset     : +0.000000456 seconds
RMS offset      : 0.000001234 seconds
Frequency       : 5.678 ppm slow
Residual freq   : +0.001 ppm
Skew            : 0.123 ppm
Root delay      : 0.012345678 seconds
Root dispersion : 0.000987654 seconds
Update interval : 64.5 seconds
Leap status     : Normal

→ System time: 123 나노초 차이 (무시 가능한 수준)
```

## 통합 비교표

| 해결 방안 | TOCTOU 해결 | 해결하는 실제 문제 | 권장도 |
|----------|-------------|-------------------|--------|
| `validateIssuable(now)` | ✅ 완전 해결 | 검증-기록 시간 불일치 | ⭐⭐⭐⭐⭐ |
| 타임존 통일 (UTC) | ❌ 별개 | 타임존 해석 불일치 | ⭐⭐⭐⭐ |
| DB CURRENT_TIMESTAMP | ❌ 악화 가능 | 없음 (오히려 역효과) | ⭐ |
| DB NOW()로 검증 | ❌ 불충분 | 부분적 개선 | ⭐⭐ |
| NTP 동기화 | ❌ 별개 | 서버 간 시각 동기화 | ⭐⭐⭐⭐ |

## 올바른 종합 해결 방안

### 핵심: 애플리케이션 레벨에서 시간 일관성 보장

```java
@Service
public class CouponIssuer {

    private final CouponService couponService;
    private final MemberService memberService;
    private final MemberCouponRepository memberCouponRepository;

    @Transactional
    public MemberCoupon issueCoupon(Long couponId, Long memberId) {
        // ✅ 1. 트랜잭션 시작 시점에 시간 캡처 (UTC 권장)
        LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);

        log.info("쿠폰 발급 요청: couponId={}, memberId={}, validationTime={}",
                 couponId, memberId, now);

        Member member = memberService.getMember(memberId);
        Coupon coupon = couponService.getCouponWithLock(couponId);

        // ✅ 2. 캡처한 시간으로 검증
        coupon.validateIssuable(now);

        // ✅ 3. 동일한 시간으로 발급 기록
        MemberCoupon memberCoupon = issueMemberCoupon(member, coupon, now);

        log.info("쿠폰 발급 완료: memberCouponId={}, issuedAt={}",
                 memberCoupon.getId(), memberCoupon.getIssuedAt());

        return memberCoupon;
    }

    private MemberCoupon issueMemberCoupon(Member member, Coupon coupon, LocalDateTime now) {
        MemberCoupon memberCoupon = MemberCoupon.issue(member.getId(), coupon, now);
        memberCouponRepository.save(memberCoupon);
        return memberCoupon;
    }
}
```

### Coupon 엔티티

```java
@Entity
@Table(name = "coupon")
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "issue_started_at", columnDefinition = "DATETIME(6)")
    private LocalDateTime issueStartedAt;

    @Column(name = "issue_ended_at", columnDefinition = "DATETIME(6)")
    private LocalDateTime issueEndedAt;

    @Column(name = "issue_count")
    private Long issueCount;

    @Column(name = "issue_limit")
    private Long issueLimit;

    // ✅ 제안된 validateIssuable 메서드
    public void validateIssuable(LocalDateTime now) {
        // 시간 검증
        if (this.issueStartedAt.isAfter(now)) {
            throw new IllegalArgumentException(
                String.format("쿠폰 발급이 시작되지 않았습니다. (시작: %s, 현재: %s)",
                    this.issueStartedAt, now)
            );
        }

        if (this.issueEndedAt.isBefore(now)) {
            throw new IllegalArgumentException(
                String.format("쿠폰 발급이 종료되었습니다. (종료: %s, 현재: %s)",
                    this.issueEndedAt, now)
            );
        }

        // 상태 검증
        if (this.couponStatus.isNotIssuable() || !this.issuable) {
            throw new IllegalArgumentException("쿠폰을 발급할 수 없는 상태입니다.");
        }

        // 수량 검증
        if (this.limitType.isNotIssueCountLimit()) {
            return;
        }

        if (this.issueLimit <= this.issueCount) {
            throw new IllegalArgumentException(
                String.format("쿠폰 발급 한도에 도달했습니다. (한도: %d, 발급: %d)",
                    this.issueLimit, this.issueCount)
            );
        }

        this.issueCount++;
    }
}
```

### MemberCoupon 엔티티

```java
@Entity
@Table(name = "member_coupon")
public class MemberCoupon {

    private static final int COUPON_USABLE_DAYS = 7;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "member_id")
    private Long memberId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "coupon_id")
    private Coupon coupon;

    @Column(name = "issued_at", columnDefinition = "DATETIME(6)")
    private LocalDateTime issuedAt;

    @Column(name = "use_ended_at", columnDefinition = "DATETIME(6)")
    private LocalDateTime useEndedAt;

    @Column(name = "used", columnDefinition = "BOOLEAN")
    private boolean used;

    @Column(name = "used_at", columnDefinition = "DATETIME(6)")
    private LocalDateTime usedAt;

    @Column(name = "modified_at", columnDefinition = "DATETIME(6)")
    private LocalDateTime modifiedAt;

    // ✅ 시간을 파라미터로 받아 일관성 보장
    public static MemberCoupon issue(Long memberId, Coupon coupon, LocalDateTime issuedAt) {
        // validateIssuable은 이미 CouponIssuer에서 호출됨

        MemberCoupon memberCoupon = new MemberCoupon();
        memberCoupon.memberId = memberId;
        memberCoupon.coupon = coupon;
        memberCoupon.issuedAt = issuedAt;  // 검증 시점과 동일한 시간
        memberCoupon.useEndedAt = issuedAt.plusDays(COUPON_USABLE_DAYS);
        memberCoupon.modifiedAt = issuedAt;
        memberCoupon.used = false;

        return memberCoupon;
    }

    public void use(LocalDateTime usedAt) {
        if (this.used) {
            throw new IllegalStateException("이미 사용한 쿠폰입니다.");
        }

        if (this.useEndedAt.isBefore(usedAt)) {
            throw new IllegalStateException(
                String.format("쿠폰 사용 기한이 만료되었습니다. (만료: %s, 현재: %s)",
                    this.useEndedAt, usedAt)
            );
        }

        this.coupon.use();
        this.used = true;
        this.usedAt = usedAt;
        this.modifiedAt = usedAt;
    }
}
```

### 보완: 타임존 설정

```yaml
# application.yml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/coupon?serverTimezone=UTC
  jpa:
    properties:
      hibernate:
        jdbc:
          time_zone: UTC
        show_sql: true
        format_sql: true

# JVM 시작 옵션
# -Duser.timezone=UTC
```

### 보완: DB 제약 조건 (방어선)

```sql
-- 발급 시간이 유효 기간 내에 있는지 DB에서 최종 검증
ALTER TABLE member_coupon
ADD CONSTRAINT chk_issue_time_valid
CHECK (
    issued_at >= (
        SELECT issue_started_at
        FROM coupon
        WHERE coupon.id = member_coupon.coupon_id
    )
    AND
    issued_at <= (
        SELECT issue_ended_at
        FROM coupon
        WHERE coupon.id = member_coupon.coupon_id
    )
);

-- 사용 시간이 사용 가능 기간 내에 있는지 검증
ALTER TABLE member_coupon
ADD CONSTRAINT chk_use_time_valid
CHECK (
    used_at IS NULL
    OR
    (used_at >= issued_at AND used_at <= use_ended_at)
);
```

### 보완: NTP 동기화 (인프라)

```bash
# Docker Compose 환경
version: '3.8'
services:
  app:
    image: coupon-service:latest
    environment:
      TZ: UTC
      JAVA_OPTS: "-Duser.timezone=UTC"
    volumes:
      - /etc/localtime:/etc/localtime:ro  # 호스트 시간 동기화

  mysql:
    image: mysql:8.0
    environment:
      TZ: UTC
      MYSQL_ROOT_PASSWORD: password
    command:
      - --default-time-zone=+00:00
    volumes:
      - /etc/localtime:/etc/localtime:ro

# 호스트 서버의 NTP 설정
# /etc/chrony/chrony.conf
server time.google.com iburst
server time.cloudflare.com iburst
makestep 1.0 3
```

## 테스트 케이스

### 시간 일관성 테스트

```java
@Test
void 검증시점과_기록시점이_동일해야_한다() {
    // given
    LocalDateTime now = LocalDateTime.of(2025, 10, 31, 23, 59, 59);
    Coupon coupon = createCoupon(
        now.minusDays(1),  // 발급 시작: 10/30 23:59:59
        now                 // 발급 종료: 10/31 23:59:59
    );

    // when
    coupon.validateIssuable(now);  // 검증 통과
    MemberCoupon memberCoupon = MemberCoupon.issue(1L, coupon, now);

    // then
    assertThat(memberCoupon.getIssuedAt()).isEqualTo(now);
    assertThat(memberCoupon.getIssuedAt()).isEqualTo(now);  // 동일한 시간!
}

@Test
void 발급종료_1나노초_후_발급_실패() {
    // given
    LocalDateTime endTime = LocalDateTime.of(2025, 10, 31, 23, 59, 59);
    LocalDateTime afterEnd = endTime.plusNanos(1);
    Coupon coupon = createCoupon(endTime.minusDays(1), endTime);

    // when & then
    assertThatThrownBy(() -> coupon.validateIssuable(afterEnd))
        .isInstanceOf(IllegalArgumentException.class)
        .hasMessageContaining("쿠폰 발급이 종료되었습니다");
}

@Test
void 시간_모킹하여_경계값_테스트() {
    // given
    Clock fixedClock = Clock.fixed(
        Instant.parse("2025-10-31T23:59:59.000Z"),
        ZoneOffset.UTC
    );
    LocalDateTime now = LocalDateTime.now(fixedClock);

    Coupon coupon = createCoupon(
        now.minusDays(1),
        now  // 정확히 종료 시간
    );

    // when & then
    assertDoesNotThrow(() -> coupon.validateIssuable(now));

    // 1나노초 후
    LocalDateTime afterNano = now.plusNanos(1);
    assertThatThrownBy(() -> coupon.validateIssuable(afterNano))
        .isInstanceOf(IllegalArgumentException.class);
}
```

### 통합 테스트

```java
@SpringBootTest
@Transactional
class CouponIssuerIntegrationTest {

    @Autowired
    private CouponIssuer couponIssuer;

    @Autowired
    private CouponRepository couponRepository;

    @Autowired
    private MemberCouponRepository memberCouponRepository;

    @Test
    void 발급_검증시간과_기록시간이_일치한다() {
        // given
        LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);
        Coupon coupon = createAndSaveCoupon(now.minusDays(1), now.plusHours(1));

        // when
        MemberCoupon issued = couponIssuer.issueCoupon(coupon.getId(), 1L);

        // then
        MemberCoupon saved = memberCouponRepository.findById(issued.getId()).orElseThrow();

        // 발급 시간이 현재 시간과 거의 동일해야 함 (오차 1초 이내)
        Duration diff = Duration.between(now, saved.getIssuedAt());
        assertThat(diff.abs().toMillis()).isLessThan(1000);

        // 사용 종료 시간도 정확히 7일 후여야 함
        assertThat(saved.getUseEndedAt())
            .isEqualTo(saved.getIssuedAt().plusDays(7));
    }
}
```

## 결론

### ✅ 채택할 방안

1. **`validateIssuable(now)` 패턴** (핵심)
   - 트랜잭션 시작 시점에 시간 캡처
   - 검증과 기록에 동일한 시간 사용
   - TOCTOU 완전 해결

2. **타임존 통일 (UTC)** (보완)
   - 애플리케이션, DB 모두 UTC 사용
   - 다중 리전 대비

3. **DB 제약 조건** (방어선)
   - CHECK 제약으로 데이터 무결성 최종 보장
   - 애플리케이션 버그 방어

4. **NTP 동기화** (인프라)
   - 서버 간 시각 동기화
   - 분산 시스템 일관성

### ❌ 피해야 할 방안

1. **DB CURRENT_TIMESTAMP 의존**
   - 검증-기록 시간 불일치 발생
   - 감사 추적 불가능

2. **DB NOW()로만 검증**
   - 여전히 TOCTOU 발생 가능
   - 불완전한 해결책

### 핵심 원칙

```java
// ✅ 시간을 한 번만 캡처하고, 모든 곳에서 동일하게 사용
LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);
coupon.validateIssuable(now);
memberCoupon.setIssuedAt(now);
```

이것이 TOCTOU 문제의 근본적 해결책입니다!

---

작성일: 2025-10-31
관련 문서:
- 쿠폰_발급시간제한_문제분석.md
- GC와_TOCTOU_문제_상세설명.md
