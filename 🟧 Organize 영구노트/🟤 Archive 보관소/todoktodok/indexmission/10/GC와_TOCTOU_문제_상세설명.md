# GC(Garbage Collection)와 TOCTOU 문제 상세 설명

## 핵심 질문: GC로 인해 요청 처리 중인 스레드가 중지될 수 있는가?

**답: 네, 맞습니다!** GC로 인해 요청을 처리 중인 스레드가 일시 중지될 수 있습니다.

## GC와 Stop-The-World (STW)

### GC(Garbage Collection)란?

Java는 자동 메모리 관리를 제공합니다. 개발자가 명시적으로 메모리를 해제하지 않아도, JVM이 더 이상 사용하지 않는 객체를 자동으로 찾아서 메모리를 회수합니다. 이것이 **Garbage Collection**입니다.

### Stop-The-World(STW)란?

GC가 실행될 때, **모든 애플리케이션 스레드를 일시 중지**시키는 현상을 **Stop-The-World (STW)**라고 합니다.

- 모든 사용자 요청 처리 중지
- 모든 비즈니스 로직 실행 중지
- 오직 GC 스레드만 실행

## 왜 스레드를 중지시킬까?

### 메모리 일관성 문제

```
메모리 상황:
┌─────────────────────────────────────┐
│ 객체A → 객체B → 객체C               │
│   ↓                                 │
│ 객체D → 객체E                       │
└─────────────────────────────────────┘

GC가 "객체E는 더 이상 안 쓰이네, 삭제하자!"라고 판단하는 순간...

만약 애플리케이션 스레드가 계속 실행되면?

스레드: "아! 나 지금 객체E 쓸 거였는데!"
GC: "어? 이미 삭제했는데..."
💥 크래시! (NullPointerException 또는 더 심각한 메모리 오류)
```

**메모리 일관성(Memory Consistency)을 유지하기 위해 모든 스레드를 멈춰야 합니다.**

### 객체 참조 추적의 필요성

GC는 다음을 수행합니다:
1. 어떤 객체가 사용 중인지 추적 (Marking)
2. 사용하지 않는 객체 식별
3. 메모리 회수 및 압축 (Compaction)

이 과정에서 객체들의 참조 관계가 변하면 안 되므로, 모든 스레드를 중지시켜야 합니다.

## 시나리오 2: GC로 인한 TOCTOU 문제 상세 설명

### 전체 타임라인

```
발급 종료 시간: 2025-10-31 23:59:59

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
23:59:59.800 │ HTTP 요청 도착
             │ 쿠폰 발급 API 호출
             │ @Transactional 시작
             │
23:59:59.820 │ Member 조회 완료
             │
23:59:59.840 │ Coupon 조회 완료 (with Lock)
             │
23:59:59.850 │ 발급 가능 시간 검증
             │ LocalDateTime.now() → 23:59:59.850
             │ if (issueEndedAt.isBefore(now)) { ... }
             │ 23:59:59.000 < 23:59:59.850 ✓ 검증 통과!
             │
23:59:59.860 │ 발급 가능 상태 검증 통과
             │ 발급 수량 체크 통과
             │ issueCount++ 실행
             │
23:59:59.900 │ ⚠️ JVM 내부 판단:
             │    "Young Generation 90% 사용, Eden 공간 부족"
             │    "Full GC 트리거!"
             │
             │ ═══════════════════════════════════════════════
             │ ⏸️  Stop-The-World 시작
             │ ═══════════════════════════════════════════════
             │
             │ 모든 애플리케이션 스레드 중지:
             │ - 쿠폰 발급 스레드 A: 😴 중지
             │ - 다른 API 요청 스레드들: 😴 모두 중지
             │ - Scheduler 스레드: 😴 중지
             │ - DB 커넥션 관리 스레드: 😴 중지
             │
             │ 🔄 GC 스레드만 실행:
23:59:59.950 │    - Young Generation 스캔 중...
00:00:00.100 │    - Old Generation 스캔 중...
00:00:00.250 │    - 사용하지 않는 객체 식별 완료
00:00:00.350 │    - 메모리 회수 및 압축 중...
             │
00:00:00.400 │ 🔄 GC 완료 (총 500ms 소요)
             │
             │ ═══════════════════════════════════════════════
             │ ▶️  Stop-The-World 종료
             │ ═══════════════════════════════════════════════
             │
             │ 쿠폰 발급 스레드 A 재개 😊
             │
00:00:00.410 │ MemberCoupon.issue() 실행
             │ LocalDateTime.now() → 00:00:00.410
             │ memberCoupon.issuedAt = 00:00:00.410
             │ ❌ 발급 종료 시간(23:59:59) 초과!
             │
00:00:00.430 │ memberCouponRepository.save()
             │ DB INSERT 실행
             │
00:00:00.450 │ @Transactional 커밋
             │ HTTP 응답 반환
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

결과: 발급 종료 시간이 지났는데도 쿠폰이 발급됨!
      DB에는 issued_at = '2025-10-31 00:00:00.410'으로 기록
```

### 코드로 보는 상세 흐름

```java
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    log.info("쿠폰 발급 요청: couponId={}, memberId={}", couponId, memberId);

    // 23:59:59.800 - 스레드 A가 여기까지 실행
    Member member = memberService.getMember(memberId);
    Coupon coupon = couponService.getCouponWithLock(couponId);

    // 23:59:59.850 - coupon.issue() 내부 검증
    coupon.issue(); // ← 여기서 시간 검증

    // Coupon.java 내부:
    // if (this.issueEndedAt.isBefore(LocalDateTime.now())) {
    //     throw new IllegalArgumentException("쿠폰을 발급할 수 없는 시간입니다.");
    // }
    // LocalDateTime.now() = 23:59:59.850
    // issueEndedAt = 23:59:59.000
    // 23:59:59.000 < 23:59:59.850 → FALSE
    // 검증 통과! ✓

    // 23:59:59.860 - issueCount++ 실행 완료

    // 23:59:59.900 - ⚠️ 이 순간 JVM이 판단
    // "메모리가 부족하네, Full GC 해야겠다!"

    // ⚠️ Stop-The-World 발생!
    // ═══════════════════════════════════════
    // 모든 애플리케이션 스레드 일시 중지
    // - 쿠폰 발급 스레드 A: 중지 😴
    // - 다른 API 요청 스레드들: 모두 중지 😴
    // - 오직 GC 스레드만 실행 🔄
    // ═══════════════════════════════════════

    // --- 500ms 동안 GC 실행 중 ---
    // GC가 하는 일:
    // 1. Root 객체부터 참조 추적 (Marking)
    // 2. 사용하지 않는 객체 찾기
    // 3. 메모리 회수 (Sweep)
    // 4. 메모리 압축 (Compaction)
    // --- 시간은 계속 흐름 ⏰ ---

    // 00:00:00.400 - GC 완료, 스레드 재개 😊

    MemberCoupon memberCoupon = MemberCoupon.issue(memberId, coupon);

    // MemberCoupon.java 내부:
    // memberCoupon.issuedAt = LocalDateTime.now();
    // LocalDateTime.now() = 00:00:00.410
    // ❌ 발급 종료 시간(23:59:59.000) 초과!

    memberCouponRepository.save(memberCoupon);

    log.info("쿠폰 발급 완료: memberCouponId={}", memberCoupon.getId());

    return memberCoupon;
}
```

## GC 종류와 중지 시간

### 1. Minor GC (Young Generation GC)

**대상**: Young Generation (Eden + Survivor 영역)

```
Heap Memory 구조:
┌──────────────────────────────────────────────────────────┐
│ Young Generation              │ Old Generation          │
│ ┌────────┬─────┬─────┐       │                         │
│ │  Eden  │ S0  │ S1  │       │   장기 생존 객체        │
│ │ (새 객체)              │       │                         │
│ └────────┴─────┴─────┘       │                         │
└──────────────────────────────────────────────────────────┘
         ↑ Minor GC 대상
```

**특징**:
- 발생 빈도: 매우 자주 (수 초 ~ 수십 초마다)
- 중지 시간: 매우 짧음 (수 ms ~ 수십 ms)
- 영향: 보통은 눈치채기 어려움
- 이유: 대부분의 객체는 금방 사라짐 (Weak Generational Hypothesis)

**예시**:
```
[GC pause (G1 Evacuation Pause) (young) 1024M->512M(4096M), 0.0234567 secs]
                                                              ↑
                                                          23ms STW
```

### 2. Full GC (Major GC / Old Generation GC)

**대상**: 전체 Heap (Young + Old Generation)

```
Heap Memory 구조:
┌──────────────────────────────────────────────────────────┐
│ Young Generation              │ Old Generation          │
│ ┌────────┬─────┬─────┐       │                         │
│ │  Eden  │ S0  │ S1  │       │   장기 생존 객체        │
│ │                      │       │                         │
│ └────────┴─────┴─────┘       │                         │
└──────────────────────────────────────────────────────────┘
         ↑ Full GC: 전체 영역 정리
```

**특징**:
- 발생 빈도: 가끔 (수 분 ~ 수십 분마다, 또는 더 드물게)
- 중지 시간: 길 수 있음 (수백 ms ~ 수 초)
- 영향: 모든 요청이 눈에 띄게 지연
- 이유: Old Generation 공간 부족, 시스템 전체 정리 필요

**예시**:
```
[Full GC (Allocation Failure) 3800M->2100M(4096M), 0.5432109 secs]
                                                      ↑
                                                  543ms STW!
```

### GC 알고리즘별 비교

| GC 알고리즘 | STW 시간 목표 | 특징 |
|------------|--------------|------|
| **Serial GC** | 제어 안 됨 | 단일 스레드, 오래된 방식 |
| **Parallel GC** | 제어 안 됨 | 멀티 스레드로 속도 개선 |
| **CMS GC** | 짧게 유지 | Concurrent, 하지만 Deprecated |
| **G1 GC** | ~200ms | 현재 기본값, 균형잡힌 성능 |
| **ZGC** | <10ms | Ultra-low latency, JDK 11+ |
| **Shenandoah** | <10ms | Ultra-low latency, OpenJDK |

## 실제 서버 로그 예시

### Full GC 발생 로그

```
2025-10-31 23:59:59.850 INFO  [http-nio-8080-exec-1] CouponIssuer - 쿠폰 발급 요청: couponId=1, memberId=100
2025-10-31 23:59:59.870 DEBUG [http-nio-8080-exec-1] CouponService - 쿠폰 조회 및 락 획득: couponId=1
2025-10-31 23:59:59.890 DEBUG [http-nio-8080-exec-1] Coupon - 발급 시간 검증 통과: now=23:59:59.890
2025-10-31 23:59:59.900 WARN  [GC Thread] GC - Full GC 시작 (Allocation Failure)
2025-10-31 23:59:59.900 WARN  [GC Thread] GC - 모든 애플리케이션 스레드 중지 (Stop-The-World)
2025-10-31 23:59:59.950 INFO  [GC Thread] GC - Young Generation 정리 완료: 1024M->512M
2025-10-31 00:00:00.200 INFO  [GC Thread] GC - Old Generation 정리 중: 2800M->1400M
2025-10-31 00:00:00.350 INFO  [GC Thread] GC - Compaction 완료
2025-10-31 00:00:00.400 WARN  [GC Thread] GC - 애플리케이션 스레드 재개
2025-10-31 00:00:00.400 INFO  [GC Thread] GC - Full GC 완료 (500ms 소요, 3800M->1900M)
2025-10-31 00:00:00.420 DEBUG [http-nio-8080-exec-1] MemberCoupon - 쿠폰 발급 기록: issuedAt=00:00:00.420
2025-10-31 00:00:00.450 INFO  [http-nio-8080-exec-1] CouponIssuer - 쿠폰 발급 완료: memberCouponId=12345

⚠️ 주목: 발급 요청(23:59:59.850)과 발급 기록(00:00:00.420) 사이에 500ms 이상 차이
⚠️ 발급 종료 시간(23:59:59) 이후에 쿠폰이 기록됨!
```

### GC 모니터링 도구 출력

```bash
# jstat -gcutil <pid> 1000
 S0     S1     E      O      M     CCS    YGC     YGCT    FGC    FGCT     GCT
  0.00  95.23  78.45  65.12  94.56  92.34    245    2.456     3   1.543   3.999
  0.00  95.23  82.34  65.12  94.56  92.34    245    2.456     3   1.543   3.999
 15.67   0.00  12.45  68.90  94.56  92.34    246    2.478     3   1.543   4.021
 15.67   0.00  45.67  68.90  94.56  92.34    246    2.478     3   1.543   4.021
 15.67   0.00  78.90  68.90  94.56  92.34    246    2.478     3   1.543   4.021
  0.00   0.00   0.00  35.12  94.56  92.34    246    2.478     4   2.086   4.564
                                                                   ↑ Full GC 1회 증가
                                                                   543ms 소요
```

## 사용자 관점에서의 경험

### 정상적인 요청 (GC 없음)

```
사용자: "쿠폰 발급" 버튼 클릭 (23:59:58.000)
        ↓
        [   50ms   ]
        ↓
서버:   응답 도착 (23:59:58.050)
사용자: "빠르네! 쿠폰 받았다!"
```

### GC로 인한 지연 발생

```
사용자: "쿠폰 발급" 버튼 클릭 (23:59:59.800)
        ↓
        [   50ms   ] ← 정상 처리
        ↓
        [  500ms   ] ← GC로 인한 중지 😴
        ↓
        [   50ms   ] ← 처리 재개 후 완료
        ↓
서버:   응답 도착 (00:00:00.400)
사용자: "어? 왜 이렇게 느리지?"
        "그리고 이벤트 끝났는데 쿠폰이 발급됐네?"
        "다른 사람들은 못 받았다는데 나만 받았어!"
```

## 왜 이게 문제가 될까?

### 1. 타이밍의 예측 불가능성

```
일반적인 요청 처리 시간: 50-100ms
GC 중지 시간: 0-500ms (완전히 예측 불가능)

발급 종료 직전 요청 시나리오:
┌─────────────────────────────────────────┐
│ 23:59:59.800  요청 시작                 │
│ 23:59:59.850  검증 (OK) ✓               │
│ 23:59:59.900  GC 시작 ⚠️                │
│ --- 500ms 동안 모든 것이 멈춤 ---       │
│ 00:00:00.400  GC 종료, 처리 재개        │
│ 00:00:00.400  발급 기록 ← 종료 시간 초과! │
└─────────────────────────────────────────┘
```

### 2. GC는 개발자가 제어할 수 없음

```java
// ❌ 이런 식으로 제어할 수 없습니다:
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    // GC를 미리 실행해서 발급 중에는 안 일어나게 하자!
    System.gc(); // ❌ 이것도 '힌트'일 뿐, JVM이 무시할 수 있음

    if (now.isCloseTo(issueEndedAt)) {
        preventGC(); // ❌ 이런 메서드는 없음
    }

    // GC는 JVM이 알아서 결정:
    // - 메모리 사용량
    // - 객체 생성 속도
    // - GC 알고리즘 설정
    // - 시스템 부하
}
```

### 3. 트래픽이 많을수록 발생 확률 증가

```
쿠폰 이벤트 종료 직전 (23:59:00 ~ 24:00:00):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 트래픽: 평소의 100배
📈 초당 요청: 10 → 1,000건
📈 메모리 사용량: 30% → 85%
📈 객체 생성 속도: 급증
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
         ↓
⚠️ Full GC 발생 확률 ⬆️⬆️⬆️
⚠️ TOCTOU 문제 발생 확률 ⬆️⬆️⬆️
```

## 실제 운영 환경 예시

### 시나리오: 선착순 1000명 쿠폰 이벤트

```
이벤트 설정:
- 발급 기간: 2025-10-31 00:00:00 ~ 23:59:59
- 선착순: 1000명
- 예상 트래픽: 종료 1분 전 폭주

실제 상황:
23:58:00 ~ 23:59:00
├─ 950명 발급 완료
├─ 메모리 사용량 75%
└─ Minor GC 빈번 발생 (문제없음)

23:59:00 ~ 23:59:59 (마지막 1분)
├─ 초당 100건 요청 폭주
├─ 메모리 사용량 90% 도달
├─ 990명 발급 완료
├─ 남은 수량: 10개
└─ 23:59:59.500 쿠폰 매진!

23:59:59.800
⚠️ Full GC 트리거 (메모리 압박)
⚠️ 500ms STW 발생

00:00:00.300
✓ GC 완료, 요청 처리 재개
❌ 23:59:59.850에 검증 통과한 요청 50개가 이제야 발급됨
❌ 실제 발급 수: 1,050개 (50개 초과!)
❌ 모든 발급 시간: 00:00:00.xxx (이벤트 종료 후)

고객 불만:
- "저는 23:59:58에 클릭했는데 안 됐어요!"
- "00:00:00 지나서 발급된 사람들은 뭔가요?"
- "선착순 1000명인데 1050명이 받았네요?"
```

## GC 튜닝을 해도 완벽하지 않음

### G1 GC 튜닝 예시

```bash
# G1 GC 사용 (JDK 9+ 기본값)
java -XX:+UseG1GC \
     -XX:MaxGCPauseMillis=200 \     # 목표: 200ms 이하
     -XX:G1HeapRegionSize=16m \
     -XX:InitiatingHeapOccupancyPercent=45 \
     -Xms4g -Xmx4g \
     -jar coupon-service.jar

목표: GC 중지 시간 200ms 이하
현실:
- 평균: 50-150ms ✓
- 95 percentile: 180ms ✓
- 99 percentile: 300ms ⚠️
- 최악의 경우: 600ms 💥

→ 보장되지 않음!
```

### ZGC 사용 (최신 Low-latency GC)

```bash
# ZGC 사용 (JDK 15+ Stable)
java -XX:+UseZGC \
     -XX:ZCollectionInterval=120 \
     -Xms4g -Xmx4g \
     -jar coupon-service.jar

목표: 10ms 이하 STW
현실:
- 평균: 2-5ms ✓✓
- 99 percentile: 8ms ✓
- 최악의 경우: 15ms ⚠️

훨씬 낫지만, 여전히 완벽하지 않음!
그리고 ZGC도 Concurrent 단계 외에 STW 단계가 있음
```

## 해결 방법

### ❌ 잘못된 접근

```java
// 방법 1: GC 힌트 (작동 안 함)
System.gc(); // JVM이 무시할 수 있음

// 방법 2: GC 비활성화 (불가능하고 위험)
-XX:+DisableExplicitGC // System.gc()만 막음, 자동 GC는 계속 발생
// 자동 GC까지 막으면 OutOfMemoryError!

// 방법 3: GC를 예측하려는 시도 (불가능)
if (memoryUsage > 80%) {
    // GC 곧 발생할 것 같으니까...
    // 하지만 정확히 언제인지 모름!
}
```

### ✅ 올바른 접근 1: 시간 캡처 (권장)

```java
@Transactional
public MemberCoupon issueCoupon(Long couponId, Long memberId) {
    // 트랜잭션 시작 시점에 시간을 한 번만 캡처
    LocalDateTime now = LocalDateTime.now();

    Member member = memberService.getMember(memberId);
    Coupon coupon = couponService.getCouponWithLock(couponId);

    // GC가 중간에 500ms 발생해도...
    // 이미 캡처한 now 값을 사용하므로 문제없음!

    coupon.issue(now);  // 동일한 now로 검증
    MemberCoupon memberCoupon = MemberCoupon.issue(memberId, coupon, now);  // 동일한 now로 기록

    memberCouponRepository.save(memberCoupon);

    return memberCoupon;
}
```

**장점**:
- GC가 발생해도 검증 시간과 기록 시간이 일치
- 트랜잭션 일관성 보장
- 코드 변경 최소화
- 성능 영향 없음

### ✅ 올바른 접근 2: 저지연 GC 사용

```bash
# ZGC 사용 (sub-10ms STW)
java -XX:+UseZGC -Xms4g -Xmx4g -jar app.jar

# 또는 Shenandoah GC
java -XX:+UseShenandoahGC -Xms4g -Xmx4g -jar app.jar
```

**장점**:
- STW 시간을 10ms 이하로 대폭 감소
- TOCTOU 문제 발생 확률 감소

**단점**:
- 여전히 완벽하지 않음 (완전히 0ms는 불가능)
- 약간의 CPU 오버헤드
- 근본적 해결책은 아님

### ✅ 올바른 접근 3: DB 제약 조건 (방어적)

```sql
-- member_coupon 테이블에 CHECK 제약 조건
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
```

**장점**:
- 데이터베이스 레벨에서 강제 보장
- 애플리케이션 버그가 있어도 방어 가능
- 최종 방어선

## 모니터링 방법

### 1. GC 로그 활성화

```bash
java -Xlog:gc*:file=gc.log:time,uptime,level,tags \
     -XX:+UseG1GC \
     -jar app.jar
```

### 2. GC 메트릭 수집

```java
// Micrometer + Prometheus
@Bean
MeterRegistryCustomizer<MeterRegistry> metricsCommonTags() {
    return registry -> {
        registry.config().commonTags("application", "coupon-service");
    };
}

// JVM 메트릭 자동 수집:
// - jvm.gc.pause (GC 중지 시간)
// - jvm.gc.memory.allocated
// - jvm.gc.memory.promoted
```

### 3. 알람 설정

```yaml
# Prometheus Alert Rule
groups:
- name: gc_alerts
  rules:
  - alert: HighGCPauseTime
    expr: rate(jvm_gc_pause_seconds_sum[5m]) > 0.1
    for: 2m
    annotations:
      summary: "GC pause time > 10% of total time"

  - alert: FrequentFullGC
    expr: rate(jvm_gc_pause_seconds_count{action="end of major GC"}[5m]) > 0.05
    for: 1m
    annotations:
      summary: "Full GC occurring more than 3 times per minute"
```

## 요약

### 핵심 포인트

1. **GC는 필수적**: Java의 자동 메모리 관리, 피할 수 없음
2. **STW는 불가피**: 메모리 일관성 유지를 위해 모든 스레드 중지 필요
3. **예측 불가능**: 언제 발생할지, 얼마나 걸릴지 정확히 알 수 없음
4. **시간에 민감한 로직 위험**: 검증-실행 사이에 GC가 끼어들 수 있음
5. **해결책**: 시간을 한 번만 캡처하여 일관성 유지

### GC로 인한 TOCTOU 문제 흐름

```
1. 검증 시점에 LocalDateTime.now() 호출 → 23:59:59.850 ✓
2. 검증 통과
3. ⚠️ GC 발생으로 500ms STW
4. 발급 시점에 LocalDateTime.now() 다시 호출 → 00:00:00.400 ❌
5. 종료 시간 지났는데도 발급됨
```

### 올바른 해결 방법

```java
// 시간을 한 번만 캡처
LocalDateTime now = LocalDateTime.now();

// 검증과 발급에 동일한 시간 사용
coupon.issue(now);
memberCoupon.issuedAt = now;

// GC가 중간에 발생해도 문제없음!
```

GC는 Java 애플리케이션의 기본 동작이므로, 코드 레벨에서 이를 고려한 설계가 필요합니다!

## 참고 자료

- [Oracle Java GC Tuning Guide](https://docs.oracle.com/en/java/javase/17/gctuning/)
- [ZGC Documentation](https://wiki.openjdk.org/display/zgc)
- [Understanding G1 GC](https://www.oracle.com/technical-resources/articles/java/g1gc.html)
- [JVM GC Algorithms](https://www.baeldung.com/jvm-garbage-collectors)
- [Garbage Collection in Java](https://docs.oracle.com/javase/8/docs/technotes/guides/vm/gctuning/)

---

작성일: 2025-10-31
관련 문서: 쿠폰_발급시간제한_문제분석.md
