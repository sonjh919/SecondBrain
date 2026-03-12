# 두 가지 에러 메시지 이해하기

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|개요로 돌아가기]] | ← [[test-validation|테스트 검증 가이드]]

## 질문

> "쿠폰을 더 이상 사용할 수 없습니다"와 "이미 사용한 쿠폰입니다" 에러가 같이 뜨는 이유가 뭐야? "이미 사용한 쿠폰입니다"는 안 뜨는 게 맞지 않아?

## 답변: 두 에러 모두 정상입니다! ✅

각각 **다른 검증 레벨**에서 발생하는 정상적인 비즈니스 로직입니다.

## 두 가지 검증 레벨

### 1. MemberCoupon 레벨: 개별 쿠폰 중복 사용 방지

**위치**: `MemberCoupon.java:62-64`

```java
public void use() {
    if (this.used) {
        throw new IllegalStateException("이미 사용한 쿠폰입니다.");  // ← 여기!
    }
    this.coupon.use();  // Coupon 검증으로 진행

    this.used = true;
    this.usedAt = LocalDateTime.now();
    this.modifiedAt = LocalDateTime.now();
}
```

**목적**: 같은 MemberCoupon을 여러 번 사용하는 것을 방지

**예시**:
```
MemberCoupon 500001을 이미 사용했는데
다시 500001을 사용하려고 하면
→ "이미 사용한 쿠폰입니다" ❌
```

### 2. Coupon 레벨: 전체 재고 관리

**위치**: `Coupon.java:94-96`

```java
public void use() {
    if (couponStatus.isNotUsable() || !this.usable) {
        throw new IllegalArgumentException("쿠폰 사용이 불가능합니다.");
    }
    if (this.limitType.isNotUseCountLimit()) {
        return;
    }
    if (this.useLimit <= this.useCount) {  // 5 <= 5?
        throw new IllegalArgumentException("쿠폰을 더 이상 사용할 수 없습니다.");  // ← 여기!
    }
    this.useCount++;
}
```

**목적**: 전체 쿠폰 사용 횟수 제한 (useLimit)

**예시**:
```
Coupon의 useLimit = 5
이미 5번 사용되었는데
새로운 MemberCoupon을 사용하려고 하면
→ "쿠폰을 더 이상 사용할 수 없습니다" ❌
```

## 검증 순서

```
HTTP 요청
    ↓
MemberCouponService.useCoupon()
    ↓
[1단계] MemberCoupon.use()
    ├→ ❌ used == true? → "이미 사용한 쿠폰입니다"
    └→ ✅ used == false → 다음 단계
        ↓
    [2단계] Coupon.use()
        ├→ ❌ useCount >= useLimit? → "쿠폰을 더 이상 사용할 수 없습니다"
        └→ ✅ useCount < useLimit → 성공!
```

## 테스트 시나리오에서 발생하는 이유

### 테스트 설정 복습

```java
// 5개 스레드
CONCURRENT_REQUEST_COUNT = 5

// 각 스레드가 20개의 MemberCoupon 사용 시도
MEMBER_COUPON_IDS = 500001L ~ 500020L

// Coupon의 사용 제한
USE_LIMIT_COUPON_ID = 351160 (useLimit = 5)
```

### 실제 실행 흐름

```java
for (int i = 0; i < 5; i++) {  // 5개 스레드
    executorService.submit(() -> {
        for (Long memberCouponId : MEMBER_COUPON_IDS) {  // 각 스레드가 500001~500020 시도
            useCoupon(memberCouponId);
        }
    });
}
```

**핵심**: 5개 스레드가 **같은 MemberCoupon 목록**을 사용하려고 시도합니다!

## 시각적 분석

### MemberCoupon 500001을 5개 스레드가 사용 시도

```
시간 →

Thread 1: Lock(500001) → used=false ✓ → Coupon.use() ✓ → used=true → ✅ Success! (useCount: 0→1)
Thread 2:     [대기.......................Lock(500001)] → used=true ✗ → ❌ "이미 사용한 쿠폰입니다"
Thread 3:     [대기.......................대기.........Lock(500001)] → used=true ✗ → ❌ "이미 사용한 쿠폰입니다"
Thread 4:     [대기.......................대기.........대기.........Lock(500001)] → used=true ✗ → ❌ "이미 사용한 쿠폰입니다"
Thread 5:     [대기.......................대기.........대기.........대기.........Lock(500001)] → used=true ✗ → ❌ "이미 사용한 쿠폰입니다"
```

**결과**:
- ✅ 1번 성공
- ❌ 4번 "이미 사용한 쿠폰입니다"

### MemberCoupon 500002~500005도 동일

```
500002: ✅ 1 성공 + ❌ 4 "이미 사용한 쿠폰입니다"  (useCount: 1→2)
500003: ✅ 1 성공 + ❌ 4 "이미 사용한 쿠폰입니다"  (useCount: 2→3)
500004: ✅ 1 성공 + ❌ 4 "이미 사용한 쿠폰입니다"  (useCount: 3→4)
500005: ✅ 1 성공 + ❌ 4 "이미 사용한 쿠폰입니다"  (useCount: 4→5)

← useCount = 5 도달! useLimit에 도달
```

### MemberCoupon 500006 이후

```
Thread 1: Lock(500006) → used=false ✓ → Coupon.use() → useCount=5 >= useLimit=5 ✗
         → ❌ "쿠폰을 더 이상 사용할 수 없습니다"

Thread 2: Lock(500006) → used=false ✓ → Coupon.use() → useCount=5 >= useLimit=5 ✗
         → ❌ "쿠폰을 더 이상 사용할 수 없습니다"

... (나머지 스레드도 동일)
```

**결과**:
- 500006~500020 (15개 MemberCoupon)
- 각 5번씩 시도 = 75번
- 모두 "쿠폰을 더 이상 사용할 수 없습니다"

## 에러 발생 비율 계산

### 총 100번 요청 분해

| 구분 | 횟수 | 설명 |
|------|------|------|
| ✅ **성공** | **5번** | MemberCoupon 500001~500005의 첫 번째 시도 |
| ❌ **이미 사용한 쿠폰** | **20번** | 500001~500005를 나머지 스레드가 재시도 (각 4번 × 5개) |
| ❌ **더 이상 사용 불가** | **75번** | 500006~500020을 5개 스레드가 시도 (15개 × 5번) |
| **합계** | **100번** | 5개 스레드 × 20개 MemberCoupon |

### 수식으로 표현

```
총 요청 = 스레드 수 × MemberCoupon 수 = 5 × 20 = 100

성공 = useLimit = 5

"이미 사용한 쿠폰입니다" = 성공한 MemberCoupon 수 × (스레드 수 - 1)
                        = 5 × (5 - 1) = 20

"쿠폰을 더 이상 사용할 수 없습니다" = 사용 못한 MemberCoupon 수 × 스레드 수
                                    = (20 - 5) × 5 = 75
```

## 비관적 락의 역할

### 락이 하는 일 ✅

비관적 락은 **동시 접근을 순차화**합니다:

```
Lock이 있을 때:

T1: Lock 획득 → used=false 확인 → 사용 처리 → used=true 설정 → Lock 해제
T2: [대기.........................................] Lock 획득 → used=true 확인 → 예외 발생 ✅

→ "이미 사용한 쿠폰입니다" (정상!)
```

### 락이 없었다면 ❌

```
Lock이 없을 때 (Race Condition):

T1: used=false 읽기 ─┐
T2: used=false 읽기 ─┼─→ 동시에 읽음!
T3: used=false 읽기 ─┘
T1: used=true 쓰기
T2: used=true 쓰기  ← 중복 사용!
T3: used=true 쓰기  ← 중복 사용!

→ 같은 MemberCoupon이 3번 사용됨! (버그!)
```

### 락은 중복 시도를 막지 않습니다

**오해**: 락을 걸면 같은 MemberCoupon을 두 번 시도하지 못한다?

**실제**: 락은 순차적으로 처리하게 할 뿐, 시도 자체는 가능합니다!

```java
// 5개 스레드가 모두 500001을 시도할 수 있음
executorService.submit(() -> useCoupon(500001L));  // ← 5번 모두 실행됨

// 다만, 락 덕분에 순차적으로 처리되어
// 첫 번째만 성공하고 나머지는 "이미 사용한 쿠폰입니다" 예외 발생
```

## 왜 "이미 사용한 쿠폰입니다"가 나와야 하나?

### 1. 중복 사용 방지 검증

만약 이 에러가 **전혀 나오지 않는다면**:

```
→ 같은 MemberCoupon을 여러 번 사용할 수 있다는 의미
→ MemberCoupon의 used 필드가 작동하지 않음
→ 중복 사용 방지가 깨짐! ❌
```

### 2. 2단계 검증의 필요성

```
1단계: MemberCoupon 검증
     → "이 쿠폰을 이미 사용했나?"
     → 개별 쿠폰의 중복 사용 방지

2단계: Coupon 검증
     → "전체 쿠폰 재고가 남았나?"
     → 전체 사용 횟수 제한
```

둘 다 필요한 이유:

```
예시 1: MemberCoupon 500001을 T1이 사용 → used=true
       T2가 500001 재시도
       → 1단계에서 차단: "이미 사용한 쿠폰입니다" ✅

예시 2: useCount=5 도달
       T1이 새로운 MemberCoupon 500010 사용 시도
       → used=false이지만 재고 없음
       → 2단계에서 차단: "쿠폰을 더 이상 사용할 수 없습니다" ✅
```

## 실제 로그 예시

### 성공 로그 (5번)

```
INFO  UseCoupon - MemberCouponId: 500001, Success, useCount: 0 → 1
INFO  UseCoupon - MemberCouponId: 500002, Success, useCount: 1 → 2
INFO  UseCoupon - MemberCouponId: 500003, Success, useCount: 2 → 3
INFO  UseCoupon - MemberCouponId: 500004, Success, useCount: 3 → 4
INFO  UseCoupon - MemberCouponId: 500005, Success, useCount: 4 → 5
```

### 실패 로그 (95번)

```
WARN  UseCoupon - MemberCouponId: 500001, IllegalStateException: 이미 사용한 쿠폰입니다
WARN  UseCoupon - MemberCouponId: 500001, IllegalStateException: 이미 사용한 쿠폰입니다
WARN  UseCoupon - MemberCouponId: 500001, IllegalStateException: 이미 사용한 쿠폰입니다
WARN  UseCoupon - MemberCouponId: 500001, IllegalStateException: 이미 사용한 쿠폰입니다
... (500002~500005도 동일, 총 20번)

WARN  UseCoupon - MemberCouponId: 500006, IllegalArgumentException: 쿠폰을 더 이상 사용할 수 없습니다
WARN  UseCoupon - MemberCouponId: 500006, IllegalArgumentException: 쿠폰을 더 이상 사용할 수 없습니다
... (500006~500020, 총 75번)
```

## 로그로 검증하기

### 에러 카운트

```bash
# "이미 사용한 쿠폰입니다" 카운트
grep "이미 사용한 쿠폰입니다" app.log | wc -l
# 예상: 약 20번

# "쿠폰을 더 이상 사용할 수 없습니다" 카운트
grep "쿠폰을 더 이상 사용할 수 없습니다" app.log | wc -l
# 예상: 약 75번

# 총합
성공(5) + 이미사용(20) + 더이상사용불가(75) = 100 ✅
```

### 어느 MemberCoupon이 성공했는지 확인

```bash
# 성공한 MemberCoupon ID 확인
grep "Success" app.log | grep "MemberCouponId"

# 결과 예시:
# MemberCouponId: 500001, Success
# MemberCouponId: 500002, Success
# MemberCouponId: 500003, Success
# MemberCouponId: 500004, Success
# MemberCouponId: 500005, Success
```

## 다이어그램: 전체 흐름

```
100번 요청 시작
     │
     ├─→ [500001~500005] 각 MemberCoupon마다
     │       │
     │       ├─→ Thread 1: ✅ 성공 (5번)
     │       └─→ Thread 2~5: ❌ "이미 사용한 쿠폰입니다" (20번)
     │
     └─→ [500006~500020] useCount=5 도달 후
             │
             └─→ 모든 Thread: ❌ "쿠폰을 더 이상 사용할 수 없습니다" (75번)

최종 결과:
✅ 성공: 5번
❌ 실패: 95번 (이미사용 20 + 더이상불가 75)
```

## 비교: 락이 없었다면

### Before: 락 없음 ❌

```
MemberCoupon 500001을 5개 스레드가 동시 접근:

T1: used=false → 사용 → used=true
T2: used=false → 사용 → used=true  ← Race Condition!
T3: used=false → 사용 → used=true  ← Race Condition!

결과: 500001이 3번 사용됨 (중복 사용!)
     "이미 사용한 쿠폰입니다" 에러 없음 (버그!)
```

### After: 락 적용 ✅

```
MemberCoupon 500001을 5개 스레드가 순차 접근:

T1: Lock → used=false → 사용 → used=true → Unlock
T2: [대기] Lock → used=true → 예외 → Unlock
T3: [대기] Lock → used=true → 예외 → Unlock

결과: 500001이 정확히 1번만 사용됨
     "이미 사용한 쿠폰입니다" 에러 2번 (정상!)
```

## FAQ

### Q1: "이미 사용한 쿠폰입니다"가 너무 많이 나오는데 문제 아닌가요?

**A**: 정상입니다.

테스트 설계상 **5개 스레드가 같은 MemberCoupon 목록을 사용**하므로:
- 각 MemberCoupon마다 첫 번째 스레드만 성공
- 나머지 4개 스레드는 "이미 사용한 쿠폰입니다" 발생

실제 프로덕션에서는:
- 각 사용자가 **자기만의 MemberCoupon**을 가지므로
- 이 에러는 거의 발생하지 않음 (같은 쿠폰을 중복 클릭하는 경우만)

### Q2: 두 에러 중 하나만 나오게 할 수 없나요?

**A**: 가능하지만 권장하지 않습니다.

두 검증은 **다른 목적**을 가집니다:
- **MemberCoupon 검증**: 개별 쿠폰의 중복 사용 방지
- **Coupon 검증**: 전체 재고 관리

둘 다 필요한 비즈니스 로직입니다.

### Q3: 락을 걸었는데 왜 여러 스레드가 같은 쿠폰을 시도하나요?

**A**: 락은 **순차화**만 하고 **시도를 막지 않습니다**.

```java
// 5개 스레드 모두 이 코드를 실행
for (Long id : memberCouponIds) {
    useCoupon(id);  // ← 모든 스레드가 실행!
}
```

락은:
- 동시에 실행되는 것을 막음 (순차적으로 실행)
- 실행 자체를 막지는 않음

### Q4: 성공한 5개가 항상 500001~500005인가요?

**A**: 아닙니다. 스레드 스케줄링에 따라 달라질 수 있습니다.

```
경우 1: 500001, 500002, 500003, 500004, 500005
경우 2: 500001, 500001, 500002, 500003, 500004
경우 3: 500001, 500002, 500002, 500003, 500004
...
```

락이 보장하는 것:
- ✅ 정확히 5개만 성공
- ✅ 각 MemberCoupon은 최대 1번만 사용
- ✅ useCount = 5

락이 보장하지 않는 것:
- ❌ 어느 MemberCoupon이 성공할지 (비결정적)

## 핵심 정리

### ✅ 정상적인 동작

```
"이미 사용한 쿠폰입니다" (약 20번)
→ MemberCoupon 레벨 검증
→ 중복 사용 방지 작동 중

"쿠폰을 더 이상 사용할 수 없습니다" (약 75번)
→ Coupon 레벨 검증
→ 전체 재고 관리 작동 중

두 에러 모두 비관적 락이 제대로 작동하고 있다는 증거! ✅
```

### ❌ 비정상이라면

```
"이미 사용한 쿠폰입니다" 없음
→ 같은 MemberCoupon이 여러 번 사용될 수 있음
→ 중복 사용 방지 실패! ❌

성공 횟수 > 5
→ useLimit 초과
→ 재고 관리 실패! ❌
```

## 관련 문서

- [[problem-analysis|문제 분석]] - Race Condition 상세
- [[solution-steps|해결 단계]] - 비관적 락 적용
- [[test-validation|테스트 검증]] - 예외 메시지가 정상인 이유
- [[technical-details|기술 상세]] - 락 메커니즘

---

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|처음으로 돌아가기]]
