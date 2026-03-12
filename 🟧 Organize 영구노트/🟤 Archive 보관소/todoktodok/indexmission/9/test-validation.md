# 테스트 검증 가이드: "쿠폰을 더 이상 사용할 수 없습니다" 메시지

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|개요로 돌아가기]] | ← [[solution-steps|해결 단계 보기]]

## 질문

> `동시_사용_요청` 테스트를 실행했을 때, "쿠폰을 더 이상 사용할 수 없습니다"라는 출력이 뜨는 건 괜찮은가?

## 답변: 완전히 정상입니다! ✅

오히려 그게 **제대로 작동하고 있다는 증거**입니다.

## 테스트 시나리오 분석

### 테스트 설정

```java
@Test
void 동시_사용_요청() throws InterruptedException {
    // 설정값
    private static final int CONCURRENT_REQUEST_COUNT = 5;  // 5개 스레드
    private static final List<Long> MEMBER_COUPON_IDS =
        LongStream.rangeClosed(500001L, 500020L).boxed().toList();  // 20개 쿠폰

    // Coupon의 useLimit = 5
}
```

### 총 요청 수 계산

```
5개 스레드 × 20개 MemberCoupon = 100번 요청
```

### 예상되는 결과

| 구분 | 횟수 | HTTP 상태 | 설명 |
|------|------|-----------|------|
| **성공** | 5번 | 200 OK | useLimit까지만 성공 ✅ |
| **실패** | 95번 | 4xx/5xx | "쿠폰을 더 이상 사용할 수 없습니다" ✅ |
| **합계** | 100번 | - | 모든 요청 시도됨 |

## 코드 상세 분석

### 1. 비즈니스 로직 (Coupon.java:87-98)

```java
public void use() {
    if (couponStatus.isNotUsable() || !this.usable) {
        throw new IllegalArgumentException("쿠폰 사용이 불가능합니다.");
    }
    if (this.limitType.isNotUseCountLimit()) {
        return;
    }
    // 핵심: useCount가 useLimit에 도달하면 예외 발생
    if (this.useLimit <= this.useCount) {  // 5 <= 5?
        throw new IllegalArgumentException("쿠폰을 더 이상 사용할 수 없습니다.");
    }
    this.useCount++;
}
```

### 2. 테스트 검증 로직 (MultipleUseRequestsTest.java:113-115)

```java
if (response.getStatusCode() == HttpStatus.SC_OK) {
    successCount.incrementAndGet();  // 200 OK만 카운트
}
// 실패(예외)는 카운트하지 않음 → 정상적인 비즈니스 로직
```

**중요**: 예외는 에러가 아니라 **정상적인 비즈니스 제약사항**입니다!

### 3. 테스트 검증 (MultipleUseRequestsTest.java:79-84)

```java
assertThat(successCount.get()).isEqualTo(5);      // 정확히 5번만 성공
assertThat(requestCount.get()).isEqualTo(100);    // 100번 모두 시도됨

Response couponResponse = getCoupon(USE_LIMIT_COUPON_ID);
long useCount = couponResponse.body().jsonPath().getLong("useCount");
assertThat(useCount).isEqualTo(5);                // useCount = 5
```

## 실제 동작 흐름

### 시간 순서대로 본 요청 처리

```
시점 | 스레드 | MemberCouponId | useCount | 결과
-----|--------|----------------|----------|------
T1   | T1     | 500001         | 0 → 1    | ✅ 성공 (200 OK)
T2   | T2     | 500001         | 1 → 2    | ✅ 성공 (200 OK)
T3   | T3     | 500002         | 2 → 3    | ✅ 성공 (200 OK)
T4   | T4     | 500003         | 3 → 4    | ✅ 성공 (200 OK)
T5   | T5     | 500004         | 4 → 5    | ✅ 성공 (200 OK)
T6   | T1     | 500002         | 5        | ❌ "쿠폰을 더 이상 사용할 수 없습니다"
T7   | T2     | 500002         | 5        | ❌ "쿠폰을 더 이상 사용할 수 없습니다"
T8   | T3     | 500003         | 5        | ❌ "쿠폰을 더 이상 사용할 수 없습니다"
...
T100 | T5     | 500020         | 5        | ❌ "쿠폰을 더 이상 사용할 수 없습니다"
```

**비관적 락 덕분에**:
- useCount가 정확히 5까지만 증가
- 그 이후 모든 요청은 올바르게 차단됨

## Before vs After 비교

### Before: 락 없음 (문제 상황) ❌

```
총 요청: 100번
성공: 20~24번  ← 버그! useLimit(5)를 초과함
실패: 76~80번
에러 메시지: 거의 안 나오거나 불규칙

useCount: 5~10 (불규칙)  ← Lost Update 발생
```

**문제**:
- Race Condition으로 useCount 검증 실패
- useLimit를 훨씬 초과하여 성공
- 데이터 무결성 깨짐

### After: 비관적 락 적용 (해결!) ✅

```
총 요청: 100번
성공: 정확히 5번  ← useLimit 준수!
실패: 정확히 95번
에러 메시지: 95번 "쿠폰을 더 이상 사용할 수 없습니다"

useCount: 정확히 5  ← 정상!
```

**해결**:
- 비관적 락으로 순차적 처리
- useLimit가 정확히 지켜짐
- 데이터 무결성 보장

## 로그에서 확인하는 방법

### 애플리케이션 로그

```bash
# 성공 로그 (5번)
INFO  ... Successfully used coupon ...

# 실패 로그 (95번) - 정상!
WARN  ... IllegalArgumentException: 쿠폰을 더 이상 사용할 수 없습니다
WARN  ... IllegalArgumentException: 쿠폰을 더 이상 사용할 수 없습니다
WARN  ... IllegalArgumentException: 쿠폰을 더 이상 사용할 수 없습니다
...
```

### SQL 로그 확인

```sql
-- 처음 5번: SELECT ... FOR UPDATE 후 UPDATE 성공
Hibernate: select ... from coupon ... where id=? for update
Hibernate: update coupon set use_count=1 where id=?

-- 6번째 이후: SELECT ... FOR UPDATE 후 예외 발생 (UPDATE 없음)
Hibernate: select ... from coupon ... where id=? for update
-- IllegalArgumentException 발생 → 트랜잭션 롤백
```

## 테스트 성공 확인

```bash
./gradlew test --tests "coupon.quiz.MultipleUseRequestsTest.동시_사용_요청"
```

### 성공 시 출력

```
> Task :test

MultipleUseRequestsTest > 동시_사용_요청() PASSED

BUILD SUCCESSFUL in 5s
```

### 데이터베이스 확인

```sql
mysql> SELECT id, use_limit, use_count FROM coupon WHERE id = 351160;
+--------+-----------+-----------+
| id     | use_limit | use_count |
+--------+-----------+-----------+
| 351160 |         5 |         5 |
+--------+-----------+-----------+
1 row in set (0.00 sec)
```

✅ **use_count = 5**: 정확히 제한됨!

## 예외 메시지가 많이 나오는 게 정상인 이유

### 비즈니스 관점

1. **한정 수량 쿠폰**: 선착순 5명만 사용 가능
2. **100명이 동시 신청**: 나머지 95명은 당연히 실패해야 함
3. **실패 응답**: "품절되었습니다" = 정상적인 비즈니스 로직

### 기술적 관점

```java
// 예외 = 제어 흐름의 일부
if (useLimit <= useCount) {
    throw new IllegalArgumentException(...);  // 비즈니스 규칙 위반
}
```

- 예외는 **에러가 아니라 비즈니스 규칙**
- "재고 없음"을 표현하는 정상적인 방법
- HTTP 4xx 응답으로 클라이언트에게 전달

## FAQ

### Q1: 예외가 95번이나 발생하는데 성능에 문제가 없나요?

**A**: 문제없습니다.
- 예외 발생 비용 < 데이터 무결성 가치
- 실제 프로덕션에서는 클라이언트가 미리 재고 확인
- 이 테스트는 극단적인 동시성 상황을 시뮬레이션

### Q2: 로그에 WARN이 많이 나오는데 괜찮나요?

**A**: 설정 조정 가능합니다.

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleBusinessException(IllegalArgumentException e) {
        // 비즈니스 예외는 INFO 레벨로 로깅
        log.info("Business rule violation: {}", e.getMessage());
        return ResponseEntity.badRequest().body(new ErrorResponse(e.getMessage()));
    }
}
```

### Q3: 실패한 95번의 요청이 재시도되지 않나요?

**A**: 테스트 코드는 재시도하지 않습니다.

```java
// 테스트 코드는 단순히 실패를 무시
if (response.getStatusCode() == HttpStatus.SC_OK) {
    successCount.incrementAndGet();
}
// 실패는 그냥 넘어감
```

실제 프로덕션에서는:
- 클라이언트가 4xx 응답을 받으면
- "품절되었습니다" UI 표시
- 재시도하지 않음 (재고가 없으므로)

## 핵심 정리

### ✅ 정상적인 동작

1. **성공 5번**: useLimit까지 정상 사용
2. **실패 95번**: 초과 요청은 올바르게 차단
3. **예외 발생**: 비즈니스 규칙을 표현하는 정상적인 방법
4. **useCount = 5**: 데이터 무결성 완벽히 유지

### ❌ 비정상이라면

```
성공 20번  ← useLimit(5)를 초과!
실패 80번
useCount ≠ 5  ← 데이터 무결성 깨짐
```

## 결론

> **"쿠폰을 더 이상 사용할 수 없습니다" 메시지가 많이 나온다 = 비관적 락이 제대로 작동하고 있다는 증거입니다!**

- 이 메시지가 **없거나 적게** 나온다면 오히려 문제
- useLimit를 초과하는 요청이 차단되지 않고 있다는 의미
- 동시성 문제가 해결되지 않은 상태

## 관련 문서

- [[problem-analysis|문제 분석]] - Race Condition 상세
- [[solution-steps|해결 단계]] - 비관적 락 적용 과정
- [[technical-details|기술 상세]] - 락 메커니즘 설명
- [[lessons-learned|배운 점]] - 예외 처리 전략

## 추가 검증 방법

### 1. 성공/실패 비율 확인

```java
System.out.println("Success: " + successCount.get());  // 5
System.out.println("Failure: " + (requestCount.get() - successCount.get()));  // 95
```

### 2. HTTP 상태 코드별 카운트

```java
Map<Integer, Integer> statusCodeCount = new ConcurrentHashMap<>();

// 각 요청 후
statusCodeCount.merge(response.getStatusCode(), 1, Integer::sum);

// 결과 출력
// 200: 5
// 400 (or 500): 95
```

### 3. 데이터베이스 직접 쿼리

```sql
-- 테스트 전
SELECT use_count FROM coupon WHERE id = 351160;  -- 0

-- 테스트 후
SELECT use_count FROM coupon WHERE id = 351160;  -- 5 ✅
```

---

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|처음으로 돌아가기]]
