[](lessons-learned.md)[](lessons-learned.md)[](lessons-learned.md)# 해결 단계: 비관적 락 적용

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|개요로 돌아가기]] | ← [[problem-analysis|문제 분석 보기]]

## 해결 전략

동시성 문제를 해결하기 위해 **비관적 락(Pessimistic Lock)**을 적용하기로 결정했습니다.

### 왜 비관적 락인가?

| 락 종류 | 특징 | 적합한 상황 |
|---------|------|-------------|
| **낙관적 락** | 충돌이 적다고 가정, 버전 체크 | 읽기가 많고 충돌이 드문 경우 |
| **비관적 락** | 충돌이 있다고 가정, DB 락 사용 | 쓰기가 많고 충돌이 빈번한 경우 ✅ |

우리 케이스:
- 5개 스레드가 동시에 같은 Coupon 수정 → **충돌 빈번**
- 데이터 무결성이 매우 중요 (재고 관리)
- 트랜잭션이 짧음

## 시도 1: MemberCoupon에만 락 적용

### 구현

```java
// MemberCouponRepository.java
@Lock(LockModeType.PESSIMISTIC_WRITE)
@Query("SELECT mc FROM MemberCoupon mc WHERE mc.id = :id")
Optional<MemberCoupon> findByIdWithLock(@Param("id") Long id);

// MemberCouponService.java
@Transactional
public void useCoupon(Long memberId, Long memberCouponId) {
    MemberCoupon memberCoupon = memberCouponRepository.findByIdWithLock(memberCouponId)
        .orElseThrow(...);
    memberCoupon.use();
}
```

### 결과

```
expected: 5
but was: 20
```

❌ **실패**: 여전히 20번 성공

### 분석

- MemberCoupon 자체는 중복 사용 방지됨 ✅
- 하지만 여러 MemberCoupon이 **같은 Coupon 객체를 참조**
- Coupon의 `useCount` 증가는 여전히 Race Condition 발생 ❌

```
MemberCoupon 500001 ──┐
MemberCoupon 500002 ──┼──→ Coupon 351160 (락 없음!)
MemberCoupon 500003 ──┘
```

## 시도 2: JOIN FETCH로 Coupon도 함께 조회 (최종 해결책!)

### 구현

```java
@Lock(LockModeType.PESSIMISTIC_WRITE)
@Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon WHERE mc.id = :id")
Optional<MemberCoupon> findByIdWithLock(@Param("id") Long id);
```

### 생성된 SQL

```sql
SELECT
    mc.id, mc.member_id, mc.used, mc.coupon_id,
    c.id, c.use_limit, c.use_count
FROM member_coupon mc
INNER JOIN coupon c ON mc.coupon_id = c.id
WHERE mc.id = ?
FOR UPDATE;  -- MemberCoupon과 Coupon 모두 락!
```

### 결과

```
BUILD SUCCESSFUL
```

✅ **성공!** 테스트 통과

### 분석

**핵심**: `JOIN FETCH` + `@Lock(PESSIMISTIC_WRITE)` 조합은:
- ✅ 하나의 쿼리로 MemberCoupon과 Coupon을 함께 조회
- ✅ `FOR UPDATE`가 **조인된 모든 테이블의 행에 락을 적용**
- ✅ MemberCoupon 행에 락 걸림
- ✅ **Coupon 행에도 락 걸림** (JOIN으로 인해!)

MySQL/InnoDB의 동작:
```
SELECT ... FROM table1 JOIN table2 ... FOR UPDATE
→ table1의 해당 행 락 ✅
→ table2의 해당 행 락 ✅  (조인된 모든 행!)
```

### 왜 처음엔 실패했나?

**시도 1**에서는:
```java
@Query("SELECT mc FROM MemberCoupon mc WHERE mc.id = :id")  // JOIN FETCH 없음
```
- MemberCoupon만 조회
- Coupon은 EAGER 로딩으로 **별도 쿼리**로 조회
- 별도 쿼리는 FOR UPDATE 없이 실행됨
- Coupon에 락 안 걸림 ❌

**시도 2(최종)**에서는:
```java
@Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon WHERE mc.id = :id")
```
- **하나의 쿼리**로 두 엔티티 조회
- FOR UPDATE가 조인된 모든 행에 적용
- MemberCoupon과 Coupon 모두 락 걸림 ✅

## 추가 시도는 불필요!

처음에는 `entityManager.lock(coupon, LockModeType.PESSIMISTIC_WRITE)`를 추가로 사용해야 한다고 생각했지만, **실제로는 필요하지 않았습니다.**

`JOIN FETCH` + `@Lock`만으로 충분합니다!

## 최종 코드 변경 사항

### 1. MemberCouponRepository.java

```diff
package coupon.coupon.repository;

+import jakarta.persistence.LockModeType;
+import java.util.Optional;
+import org.springframework.data.jpa.repository.Lock;
+import org.springframework.data.jpa.repository.Query;
+import org.springframework.data.repository.query.Param;

public interface MemberCouponRepository extends JpaRepository<MemberCoupon, Long> {
+   @Lock(LockModeType.PESSIMISTIC_WRITE)
+   @Query("SELECT mc FROM MemberCoupon mc JOIN FETCH mc.coupon WHERE mc.id = :id")
+   Optional<MemberCoupon> findByIdWithLock(@Param("id") Long id);
}
```

### 2. MemberCouponService.java

```diff
package coupon.coupon.service;

@Service
public class MemberCouponService {

    private final MemberCouponRepository memberCouponRepository;

    @Transactional
    public void useCoupon(Long memberId, Long memberCouponId) {
        Member member = memberService.getMember(memberId);

-       MemberCoupon memberCoupon = memberCouponRepository.findById(memberCouponId)
+       MemberCoupon memberCoupon = memberCouponRepository.findByIdWithLock(memberCouponId)
            .orElseThrow(...);

        if (!Objects.equals(memberCoupon.getMemberId(), member.getId())) {
            throw new IllegalArgumentException(...);
        }

+       // JOIN FETCH + @Lock으로 이미 MemberCoupon과 Coupon 모두 락이 걸려있음
+       // entityManager.lock() 불필요!

        memberCoupon.use();
        observers.forEach(observer -> observer.onUse(memberCoupon.getId()));
    }
}
```

**중요**: `EntityManager`를 주입받을 필요도 없고, `entityManager.lock()`을 호출할 필요도 없습니다!

Repository의 `@Lock` + `JOIN FETCH`만으로 충분합니다.

## 작동 원리

### 락 적용 흐름

```
Thread 1: [MemberCoupon + Coupon 동시 락 획득] → [사용] → [락 해제]
Thread 2:        [대기........................] → [락 획득] → [사용] → [락 해제]
Thread 3:        [대기.........................................] → [락 획득] → ...
```

**핵심**: `JOIN FETCH` + `@Lock`으로 **하나의 쿼리**에서 **두 테이블 모두 락**을 겁니다!

```sql
-- 단 한 번의 쿼리로:
SELECT mc.*, c.*
FROM member_coupon mc
JOIN coupon c ON mc.coupon_id = c.id
WHERE mc.id = ?
FOR UPDATE;  -- 두 테이블 모두 락!
```

### 트랜잭션 순서화

```
시간축: →

T1: [━━━━━━━━━━] 완료 (useCount: 0→1)
T2:            [━━━━━━━━━━] 완료 (useCount: 1→2)
T3:                       [━━━━━━━━━━] 완료 (useCount: 2→3)
T4:                                  [━━━━━━━━━━] 완료 (useCount: 3→4)
T5:                                             [━━━━━━━━━━] 완료 (useCount: 4→5)
T6:                                                        [Exception!] useCount = 5
```

## 검증

### 데이터베이스 확인

```sql
mysql> SELECT id, use_limit, use_count FROM coupon WHERE id = 351160;
+--------+-----------+-----------+
| id     | use_limit | use_count |
+--------+-----------+-----------+
| 351160 |         5 |         5 |
+--------+-----------+-----------+
```

✅ **use_count = 5**: 정확히 제한됨!

### 테스트 결과

```
assertThat(successCount.get()).isEqualTo(5);  // ✅ PASS
assertThat(requestCount.get()).isEqualTo(100); // ✅ PASS
assertThat(useCount).isEqualTo(5);             // ✅ PASS
```

## 다음 단계

→ [[technical-details|기술적 세부사항 보기]]

## 핵심 교훈

1. **연관 엔티티도 락이 필요하다**: MemberCoupon만 락을 걸면 부족함
2. **JOIN FETCH + @Lock의 강력함**: 하나의 쿼리로 연관된 모든 엔티티에 락을 걸 수 있음
3. **FOR UPDATE는 조인된 모든 행에 적용됨**: MySQL/InnoDB의 중요한 특성
4. **SQL 로그 확인이 중요**: `FOR UPDATE`가 실제로 실행되는지, 어느 테이블에 걸리는지 확인해야 함
5. **과도한 방어는 불필요**: `entityManager.lock()`까지 사용할 필요 없음

## 왜 이런 오해가 생겼나?

처음에는 다음과 같이 생각했습니다:
- ❌ "JOIN FETCH는 단순히 N+1 문제 해결용"
- ❌ "연관 엔티티에 대한 락은 별도로 필요"
- ❌ "EntityManager로 명시적으로 락을 걸어야 안전"

**실제로는**:
- ✅ `@Lock` + `JOIN`을 사용하면 `FOR UPDATE`가 **조인된 모든 테이블**에 적용됨
- ✅ MySQL/InnoDB는 조인 쿼리의 모든 참여 행에 락을 걸음
- ✅ 추가적인 `entityManager.lock()` 호출은 불필요

**배운 점**:
- SQL 로그를 먼저 확인했어야 함
- 데이터베이스의 실제 동작을 이해하는 것이 중요
- 과도한 방어 코드는 복잡성만 증가시킴
