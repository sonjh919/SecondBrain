# 기술적 세부사항: JPA Pessimistic Lock

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|개요로 돌아가기]] | ← [[solution-steps|해결 단계 보기]]

## Pessimistic Lock이란?

### 정의

비관적 락은 데이터베이스 레벨에서 제공하는 락 메커니즘을 사용하여, **트랜잭션이 데이터를 읽는 순간부터 다른 트랜잭션의 접근을 차단**하는 방식입니다.

### 동작 원리

```sql
-- SELECT ... FOR UPDATE
SELECT * FROM coupon WHERE id = 351160 FOR UPDATE;
```

- `FOR UPDATE`: 해당 행에 배타적 락(Exclusive Lock)을 걸음
- 다른 트랜잭션은 이 행을 읽거나 수정할 수 없음
- 트랜잭션이 커밋/롤백되면 락이 자동으로 해제됨

## JPA Lock Modes

### LockModeType 종류

| LockModeType | 설명 | SQL |
|--------------|------|-----|
| `PESSIMISTIC_READ` | 공유 락 (다른 읽기는 허용, 쓰기는 차단) | `FOR SHARE` |
| `PESSIMISTIC_WRITE` | 배타적 락 (읽기/쓰기 모두 차단) ✅ | `FOR UPDATE` |
| `PESSIMISTIC_FORCE_INCREMENT` | 배타적 락 + 버전 증가 | `FOR UPDATE` |

우리가 사용한 것: **PESSIMISTIC_WRITE**

## JPA에서 락 사용 방법

### 방법 1: @Lock 애노테이션

```java
@Repository
public interface MemberCouponRepository extends JpaRepository<MemberCoupon, Long> {

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT mc FROM MemberCoupon mc WHERE mc.id = :id")
    Optional<MemberCoupon> findByIdWithLock(@Param("id") Long id);
}
```

**장점**:
- 선언적이고 간단함
- 쿼리 메서드와 함께 정의 가능

**단점**:
- 리포지토리 인터페이스에서만 사용 가능
- 동적으로 락 타입을 변경할 수 없음

### 방법 2: EntityManager.lock()

```java
@Service
public class MemberCouponService {

    @Autowired
    private EntityManager entityManager;

    @Transactional
    public void useCoupon(...) {
        // 먼저 엔티티 조회
        Coupon coupon = memberCoupon.getCoupon();

        // 명시적으로 락 추가
        entityManager.lock(coupon, LockModeType.PESSIMISTIC_WRITE);

        // 이제 안전하게 수정
        coupon.use();
    }
}
```

**장점**:
- 서비스 레이어에서 동적으로 락 추가 가능
- 이미 로드된 엔티티에도 락을 걸 수 있음 ✅

**단점**:
- EntityManager에 직접 접근해야 함
- 코드가 다소 장황함

### 방법 3: EntityManager.find() with LockMode

```java
@Transactional
public void useCoupon(...) {
    MemberCoupon memberCoupon = entityManager.find(
        MemberCoupon.class,
        memberCouponId,
        LockModeType.PESSIMISTIC_WRITE
    );
}
```

**장점**:
- 조회와 동시에 락 획득

**단점**:
- Spring Data JPA의 편리한 메서드를 사용할 수 없음

## 우리가 사용한 조합

```java
// 1. Repository에서 MemberCoupon 락
@Lock(LockModeType.PESSIMISTIC_WRITE)
@Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon WHERE mc.id = :id")
Optional<MemberCoupon> findByIdWithLock(@Param("id") Long id);

// 2. Service에서 Coupon 락
@Transactional
public void useCoupon(...) {
    MemberCoupon memberCoupon = memberCouponRepository.findByIdWithLock(memberCouponId)
        .orElseThrow(...);

    Coupon coupon = memberCoupon.getCoupon();
    entityManager.lock(coupon, LockModeType.PESSIMISTIC_WRITE);  // 추가 락!

    memberCoupon.use();
}
```

## JOIN FETCH와 락

### JOIN FETCH의 역할

```java
@Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon WHERE mc.id = :id")
```

- `JOIN FETCH`: 연관된 Coupon을 즉시 로딩 (N+1 문제 방지)
- **하지만**: Coupon에 자동으로 락이 걸리지는 않음!

### 실행되는 SQL

```sql
-- 1. MemberCoupon 조회 및 락
SELECT
    mc.id, mc.member_id, mc.used, mc.coupon_id,
    c.id, c.use_limit, c.use_count  -- JOIN FETCH
FROM member_coupon mc
INNER JOIN coupon c ON mc.coupon_id = c.id
WHERE mc.id = ?
FOR UPDATE;  -- MemberCoupon에만 락!
```

**주의**: `FOR UPDATE`는 주 테이블(member_coupon)에만 적용됨!

### 추가 락이 필요한 이유

```sql
-- 2. Coupon에 명시적으로 락 추가
SELECT * FROM coupon WHERE id = ? FOR UPDATE;
```

이렇게 해야 Coupon에도 락이 걸립니다.

## 트랜잭션 격리 수준

### MySQL의 기본 격리 수준

```sql
mysql> SELECT @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
```

### REPEATABLE READ vs Pessimistic Lock

| 격리 수준 | Lost Update 방지 | Phantom Read 방지 |
|-----------|------------------|-------------------|
| READ UNCOMMITTED | ❌ | ❌ |
| READ COMMITTED | ❌ | ❌ |
| REPEATABLE READ | ⚠️ 부분적 | ✅ (MySQL InnoDB) |
| SERIALIZABLE | ✅ | ✅ |
| **+ Pessimistic Lock** | ✅ | ✅ |

**중요**: REPEATABLE READ만으로는 Lost Update를 완전히 방지할 수 없음!

```
-- REPEATABLE READ에서도 발생하는 Lost Update
T1: SELECT use_count FROM coupon WHERE id = 351160;  -- 0
T2: SELECT use_count FROM coupon WHERE id = 351160;  -- 0
T1: UPDATE coupon SET use_count = 1 WHERE id = 351160;
T2: UPDATE coupon SET use_count = 1 WHERE id = 351160;  -- T1의 변경 덮어씀!
```

## 성능 고려사항

### 락으로 인한 대기

```
Thread 1: [━━━━━━━━━━] (100ms)
Thread 2:            [━━━━━━━━━━] (100ms)
Thread 3:                       [━━━━━━━━━━] (100ms)

총 소요 시간: 300ms (순차 실행)
```

### 데드락 위험

두 트랜잭션이 서로 다른 순서로 락을 획득하려고 하면 데드락 발생 가능:

```
T1: Lock(A) → waiting for Lock(B)
T2: Lock(B) → waiting for Lock(A)
```

**방지 방법**:
- 항상 같은 순서로 락 획득
- 타임아웃 설정
- 데드락 감지 및 재시도 로직

### 락 타임아웃 설정

```yaml
# application.yml
spring:
  jpa:
    properties:
      jakarta:
        persistence:
          lock:
            timeout: 10000  # 10초
```

## JPA 1차 캐시와 락

### 1차 캐시의 영향

```java
// 같은 트랜잭션 내에서
MemberCoupon mc = repository.findById(1L).get();
Coupon coupon1 = mc.getCoupon();  // EAGER 로딩

// 락과 함께 조회해도 1차 캐시에서 가져옴!
Coupon coupon2 = couponRepository.findByIdWithLock(coupon1.getId()).get();

coupon1 == coupon2  // true (같은 인스턴스!)
```

**문제**: 1차 캐시에 있는 엔티티는 락이 없음!

**해결**: `EntityManager.lock()`으로 추가 락 적용

## 실제 SQL 로그

### 애플리케이션 로그 확인

```
Hibernate:
    select
        mc1_0.id,
        c1_0.id, c1_0.use_count, c1_0.use_limit,
        mc1_0.member_id, mc1_0.used
    from member_coupon mc1_0
    join coupon c1_0 on c1_0.id=mc1_0.coupon_id
    where mc1_0.id=?
    for update

Hibernate:
    select c1_0.id from coupon c1_0
    where c1_0.id=?
    for update
```

✅ **두 개의 FOR UPDATE**: MemberCoupon과 Coupon 모두 락 획득!

## 다음 단계

→ [[lessons-learned|배운 점 보기]]

## 참고 자료

- [JPA 2.2 Specification - Locking](https://download.oracle.com/otn-pub/jcp/persistence-2_2-mrel-spec/JavaPersistence.pdf)
- [Hibernate Locking Documentation](https://docs.jboss.org/hibernate/orm/6.0/userguide/html_single/Hibernate_User_Guide.html#locking)
- [MySQL InnoDB Locking](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html)
