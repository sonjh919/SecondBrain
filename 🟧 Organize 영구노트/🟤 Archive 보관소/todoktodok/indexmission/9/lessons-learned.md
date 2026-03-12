# 배운 점과 교훈

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|개요로 돌아가기]] | ← [[technical-details|기술적 세부사항 보기]]

## 핵심 교훈

### 1. @Transactional만으로는 충분하지 않다

```java
@Transactional  // ← 이것만으로는 동시성 제어가 안 됨!
public void useCoupon(...) {
    memberCoupon.use();
}
```

**왜?**
- `@Transactional`은 트랜잭션 경계만 관리
- 락을 명시하지 않으면 여러 트랜잭션이 동시에 같은 데이터를 읽고 수정 가능
- **동시성 제어 ≠ 트랜잭션 관리**

### 2. 연관 엔티티도 락이 필요하다

```java
// ❌ 부족함
MemberCoupon mc = repository.findByIdWithLock(id);  // MemberCoupon만 락

// ✅ 올바름
MemberCoupon mc = repository.findByIdWithLock(id);  // MemberCoupon 락
entityManager.lock(mc.getCoupon(), PESSIMISTIC_WRITE);  // Coupon도 락!
```

**교훈**:
- 여러 엔티티가 하나의 공유 자원(Coupon)을 참조하는 경우
- **모든 관련 엔티티에 락을 걸어야 함**

### 3. EAGER 로딩은 락을 전파하지 않는다

```java
@ManyToOne(fetch = FetchType.EAGER)
private Coupon coupon;  // ← EAGER 로딩

// MemberCoupon을 락과 함께 조회해도
MemberCoupon mc = repository.findByIdWithLock(id);

// Coupon은 락이 없음!
Coupon coupon = mc.getCoupon();  // No lock!
```

**교훈**:
- EAGER 로딩은 편리하지만 락 제어가 명확하지 않음
- 동시성이 중요한 경우 **명시적으로 락을 추가**해야 함

### 4. JOIN FETCH vs 락

```java
@Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon WHERE mc.id = :id")
```

- `JOIN FETCH`: N+1 문제 해결, 성능 최적화
- **하지만**: 조인된 엔티티에 락이 자동으로 걸리지 않음!
- `FOR UPDATE`는 주 테이블에만 적용됨

### 5. EntityManager.lock()의 중요성

```java
entityManager.lock(coupon, LockModeType.PESSIMISTIC_WRITE);
```

**유용한 시나리오**:
- 이미 로드된 엔티티에 락을 추가해야 할 때
- 1차 캐시에 있는 엔티티에 락을 걸어야 할 때
- Repository 메서드 외부에서 동적으로 락을 걸어야 할 때

### 6. SQL 로그 확인이 중요하다

```yaml
spring:
  jpa:
    properties:
      hibernate:
        show_sql: true
```

**확인해야 할 것**:
- `FOR UPDATE`가 실제로 실행되는가?
- 몇 개의 쿼리가 실행되는가?
- 어떤 테이블에 락이 걸리는가?

**예시**:
```sql
Hibernate: select ... from member_coupon ... for update  ✅
Hibernate: select ... from coupon ... for update  ✅
```

## 실수와 시행착오

### 실수 1: 단일 엔티티에만 집중

```java
// ❌ 처음 시도: MemberCoupon만 락
MemberCoupon mc = repository.findByIdWithLock(id);
mc.use();  // Coupon.useCount는 여전히 Race Condition!
```

**깨달음**:
- 엔티티 간 관계를 고려하지 않음
- 공유 자원(Coupon)이 어디인지 파악하지 못함

### 실수 2: JOIN FETCH면 충분할 거라 생각함

```java
// ❌ 두 번째 시도
@Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon ...")
```

**깨달음**:
- `JOIN FETCH`는 쿼리 최적화일 뿐, 락 전파와 무관
- SQL을 확인하지 않고 가정만 함

### 실수 3: 애플리케이션 재시작 안 함

테스트가 HTTP 요청으로 실행되는데:
1. 코드 수정
2. 테스트 실행 → **옛날 코드가 실행 중**
3. 실패!

**깨달음**:
- 통합 테스트의 경우 애플리케이션 재시작 필요
- 로컬 서버가 8080에서 실행 중인지 확인

## 동시성 문제 진단 체크리스트

### 문제 발생 시 확인 사항

- [ ] 여러 스레드/트랜잭션이 같은 데이터를 수정하는가?
- [ ] 읽기-수정-쓰기 패턴이 있는가?
- [ ] `@Transactional`만 있고 락이 없는가?
- [ ] SQL 로그에 `FOR UPDATE`가 있는가?
- [ ] 연관 엔티티도 락이 걸리는가?
- [ ] 테스트 결과가 매번 다른가?

### 해결 전략 선택

```
충돌 빈도 낮음 → 낙관적 락 (@Version)
충돌 빈도 높음 → 비관적 락 (FOR UPDATE) ✅
재고/좌석 관리 → 비관적 락 (FOR UPDATE) ✅
읽기 많음    → 낙관적 락 또는 읽기 락
```

## 성능 vs 정확성

### 트레이드오프

| 접근 방식 | 성능 | 정확성 | 복잡도 |
|-----------|------|--------|--------|
| 락 없음 | ⭐⭐⭐⭐⭐ | ❌ | ⭐ |
| 낙관적 락 | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| 비관적 락 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 분산 락 | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

### 우리의 선택: 비관적 락

**이유**:
- 쿠폰 재고는 **정확성이 최우선**
- 충돌이 빈번하게 발생 (5개 스레드가 동시에 접근)
- 트랜잭션이 짧음 (락 대기 시간 짧음)
- 단일 DB 환경 (분산 락 불필요)

## 실전 적용 팁

### 1. 테스트 주도 개발

```java
@Test
void 동시성_테스트() {
    ExecutorService executor = Executors.newFixedThreadPool(10);
    // 동시성 문제를 재현하는 테스트 작성
}
```

**장점**:
- 문제를 먼저 재현한 후 해결
- 리그레션 방지

### 2. 모니터링

```java
@Slf4j
public class MemberCouponService {
    public void useCoupon(...) {
        log.info("Thread: {}, MemberCouponId: {}",
            Thread.currentThread().getName(), memberCouponId);
        // ...
    }
}
```

**확인할 것**:
- 락 대기 시간
- 데드락 발생 빈도
- 트랜잭션 롤백 수

### 3. 점진적 적용

```java
// Step 1: 단순한 경우부터 시작
@Lock(LockModeType.PESSIMISTIC_WRITE)
Optional<Coupon> findByIdWithLock(Long id);

// Step 2: 복잡한 경우 추가
entityManager.lock(coupon, LockModeType.PESSIMISTIC_WRITE);

// Step 3: 타임아웃 설정
@QueryHints({@QueryHint(name = "jakarta.persistence.lock.timeout", value = "10000")})
```

## 확장 가능성

### 단일 DB → 분산 환경

현재 솔루션의 한계:
- 단일 데이터베이스에만 유효
- 여러 DB 인스턴스가 있으면 동작하지 않음

**분산 환경 해결책**:
1. **Redisson 분산 락**
2. **Zookeeper**
3. **DB 락 + 메시지 큐**

### 읽기 성능 최적화

```java
// 읽기 전용 쿼리는 락 불필요
@Transactional(readOnly = true)
public List<MemberCoupon> findUsableCoupons(Long memberId) {
    // 락 없이 조회 (성능 향상)
}
```

## 마무리

### 가장 중요한 3가지

1. **공유 자원을 식별하라**: 어떤 데이터가 여러 스레드에서 수정되는가?
2. **락의 범위를 명확히 하라**: 연관 엔티티까지 고려했는가?
3. **실제 SQL을 확인하라**: `FOR UPDATE`가 예상한 대로 실행되는가?

### 다음에 배울 것

- [ ] 낙관적 락 (`@Version`) 사용 사례
- [ ] 분산 락 (Redis, Redisson)
- [ ] 데드락 감지 및 해결
- [ ] 트랜잭션 격리 수준 심화
- [ ] MVCC (Multi-Version Concurrency Control)

## 참고 문헌

- Martin Kleppmann, "Designing Data-Intensive Applications", Chapter 7: Transactions
- Vlad Mihalcea, "High-Performance Java Persistence"
- [Baeldung: JPA Pessimistic Locking](https://www.baeldung.com/jpa-pessimistic-locking)
- [MySQL InnoDB Locking Reads](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking-reads.html)

---

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|처음으로 돌아가기]]
