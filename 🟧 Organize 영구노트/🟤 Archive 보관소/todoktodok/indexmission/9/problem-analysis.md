[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)[](technical-details.md)# 문제 분석: Race Condition in Coupon Usage

← [[🟧 Organize 영구노트/🟤 Archive 보관소/todoktodok/indexmission/9/overview|개요로 돌아가기]]

## 테스트 실패 현상

### 테스트 코드 분석

```java
@Test
void 동시_사용_요청() throws InterruptedException {
    // 5개 스레드가 동시에 실행
    ExecutorService executorService = Executors.newFixedThreadPool(CONCURRENT_REQUEST_COUNT);

    // 각 스레드가 20개의 MemberCoupon 사용 시도
    for (int i = 0; i < 5; i++) {
        executorService.submit(() -> useCoupon(...));
    }

    // 기대: successCount = 5, requestCount = 100
    assertThat(successCount.get()).isEqualTo(5);
    assertThat(requestCount.get()).isEqualTo(100);
}
```

### 실패 결과

```
expected: 5
but was: 20~24
```

- **총 요청**: 100회 ✅
- **성공 횟수**: 20~24회 ❌ (5회여야 함)
- **Coupon.useCount**: 값이 불규칙함

## 원인 분석

### 1. 엔티티 구조

```
Coupon (쿠폰 템플릿)
├── useLimit: 5      (최대 사용 가능 횟수)
├── useCount: 0      (현재 사용된 횟수)
└── 여러 MemberCoupon이 참조

MemberCoupon (회원에게 발급된 쿠폰)
├── used: false      (사용 여부)
├── coupon: Coupon   (참조)
└── 여러 개가 같은 Coupon을 참조
```

### 2. Race Condition 발생 지점

#### 문제 코드 (Coupon.java:87-98)

```java
public void use() {
    // 1. useLimit 체크 (여러 스레드가 동시에 읽음)
    if (this.useLimit <= this.useCount) {  // ← Race Condition!
        throw new IllegalArgumentException("쿠폰을 더 이상 사용할 수 없습니다.");
    }

    // 2. useCount 증가 (여러 스레드가 동시에 쓰기)
    this.useCount++;  // ← Lost Update!
}
```

### 3. 동시성 문제 시나리오

```
시간축: →

Thread 1: [READ useCount=0] → [CHECK OK] ──→ [WRITE useCount=1]
Thread 2: [READ useCount=0] → [CHECK OK] → [WRITE useCount=1]  ← 덮어씀!
Thread 3:   [READ useCount=0] → [CHECK OK] → [WRITE useCount=1]  ← 덮어씀!
Thread 4:     [READ useCount=0] → [CHECK OK] → [WRITE useCount=1]  ← 덮어씀!
Thread 5:       [READ useCount=0] → [CHECK OK] → [WRITE useCount=1]  ← 덮어씀!

결과: useCount = 1이지만 실제로는 5번 사용됨!
```

### 4. Lost Update 문제

**Lost Update**란 여러 트랜잭션이 같은 데이터를 동시에 수정할 때, 나중에 커밋된 트랜잭션이 이전 트랜잭션의 변경사항을 덮어쓰는 현상입니다.

```
시점  | Thread 1      | Thread 2      | DB의 useCount
------|---------------|---------------|---------------
T0    |               |               | 0
T1    | READ (0)      |               | 0
T2    |               | READ (0)      | 0
T3    | useCount++    |               | 0
T4    | COMMIT (1)    |               | 1
T5    |               | useCount++    | 1
T6    |               | COMMIT (1)    | 1  ← Thread 1의 변경 손실!
```

## 왜 락이 없었는가?

### 원래 코드의 트랜잭션 처리

```java
@Transactional
public void useCoupon(Long memberId, Long memberCouponId) {
    MemberCoupon memberCoupon = memberCouponRepository.findById(memberCouponId)
        .orElseThrow(...);

    // Coupon이 EAGER 로딩되지만 락이 없음
    memberCoupon.use();  // ← 여기서 Coupon.use() 호출
}
```

- JPA의 `@Transactional`은 트랜잭션 경계만 관리
- **락을 명시하지 않으면** 데이터베이스 락이 걸리지 않음
- 각 트랜잭션이 독립적으로 실행되어 서로의 변경사항을 인지하지 못함

## 문제의 심각성

### 비즈니스 영향

1. **재고 관리 실패**: 5개만 제공해야 하는데 20개 이상 제공
2. **금전적 손실**: 한정된 할인 쿠폰이 무제한으로 사용됨
3. **데이터 무결성**: DB에 저장된 `useCount`가 실제 사용 횟수와 다름

### 실제 데이터베이스 상태

```sql
-- 테스트 실행 후
SELECT id, use_limit, use_count FROM coupon WHERE id = 351160;

-- 락 없이 실행한 결과:
-- use_limit: 5
-- use_count: 5~10 (불규칙, 매번 다름)

-- 실제 성공한 HTTP 요청: 20~24회
-- → useCount와 실제 사용 횟수가 불일치!
```

## 핵심 문제

> **여러 스레드(트랜잭션)이 공유 자원(Coupon.useCount)에 동시에 접근하여 읽기-수정-쓰기를 수행할 때, 동기화 메커니즘이 없으면 Race Condition과 Lost Update가 발생한다.**

## 다음 단계

→ [[solution-steps|해결 단계 보기]]

## 참고 자료

- [JPA Locking Mechanisms](https://www.baeldung.com/jpa-pessimistic-locking)
- [Database Transaction Isolation Levels](https://www.postgresql.org/docs/current/transaction-iso.html)
- [Race Condition in Database](https://en.wikipedia.org/wiki/Race_condition)
