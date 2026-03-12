# PR #808 - [1단계 - 블랙잭] 리뷰 코멘트

## PR 정보
- **리뷰어**: ddaaac
- **작성자**: sonjh919 (Link)
- **리뷰 기간**: 2025-03-07 ~ 2025-03-11
- **리뷰 라운드**: 총 3회 (Changes Requested → Changes Requested → Approved)

---

## 리뷰 코멘트 상세

### 1. 테스트를 위한 Getter에 대한 고민 🤔

**파일**: `src/test/java/domain/PlayersTest.java:55`

**작성자 (sonjh919)**:
> 여기서 getter를 사용한다면 테스트를 보다 꼼꼼히 할 수 있지만, 테스트만을 위한 코드인 getter를 만드는 것은 아니라고 생각해서 다음과 같이 테스트를 진행했습니다. 혹시 테스트를 위한 getter에 대해 어떻게 생각하시는지 궁금합니다!! 😄

**코드 컨텍스트**:
```java
// 주석 처리된 테스트
// assertSoftly(softly -> {
//     softly.assertThat(playerList.getFirst().getCardDeck().getCardsSize()).isEqualTo(2);
//     softly.assertThat(playerList.get(1).getCardDeck().getCardsSize()).isEqualTo(2);
// });

// 실제 사용한 테스트
assertDoesNotThrow(() -> players.hitCards(dealer));
```

**관련 토픽**: 테스트 설계, 캡슐화

---

### 2. Functional Interface를 활용한 출력 타이밍 제어 💡

**파일**: `src/main/java/domain/BlackJack.java:24`

**리뷰어 (ddaaac)**:
> 출력 타이밍 조절을 functional interface를 사용해서 해주셨네요.
>
> 이 방법에는 어떤 장단점이 있을까요?

**코드 컨텍스트**:
```java
public void drawPlayers(final Function<Player, Boolean> answer, final Consumer<Player> playerDeck) {
    // ...
}
```

**관련 토픽**: 함수형 프로그래밍, 의존성 제어, 출력 타이밍

**반응**: 👍 1

---

### 3. 객체 세계에서의 책임 분배 - Deck의 위치 🎯

**파일**: `src/main/java/domain/BlackJack.java:20`

**리뷰어 (ddaaac)**:
> 꼭 코드가 현실을 그대로 반영할 필요는 없습니다.
>
> "객체지향의 사실과 오해"의 한 구절을 인용해볼게요.
>
> > 흔히 '객체는 현실 세계의 반영이다.' 라고 하지만 이 말은 반은 맞고 반은 틀렸다. 현실 세계를 빗대어서 객체를 설계하면 이해가 쉽다는 장점이 있다. 하지만 현실 세계에서 일어나지 않는 일이 객체 세계에서 일어난다. 예를 들어서 현실에서는 '사람이 물을 마셨다.'라고 하면 컵과 물은 가만히 있고 사람만 능동적으로 행동한다(물을 마신다). 하지만 객체의 세계에서는 사람과 컵이 모두 능동적으로 참여할 수 있다. 그렇기 때문에 객체가 현실의 반영이라는 말은 반은 맞고 반은 틀렸다.
>
> BlackJack이 Deck을 갖고 있다면 좀 더 시그니처가 자연스러워지지 않을까요?

**코드 컨텍스트**:
```java
public void hitCardsToParticipant() {
    players.hitCards(dealer);  // Dealer가 Deck을 가지고 있음
    dealer.addCards();
}
```

**관련 토픽**: 객체지향 설계, 책임 분배, 도메인 모델링

**반응**: 👍 1

---

### 4. 도메인 요구사항은 도메인에서 처리 📋

**파일**: `src/main/java/view/OutputView.java:101`

**리뷰어 (ddaaac)**:
> "딜러는 처음에 한 장의 카드만 공개 한다"는 도메인 요구사항인 것 같아요.
> 지금은 View에서 결정하고 있네요.
>
> 리뷰 반영하시면서 상속/구현 관계에 대해서도 한 번 고민해보시면 좋을 것 같네요.

**코드 컨텍스트**:
```java
private void printDealerDeckWithHidden(final Dealer dealer) {
    System.out.println(DEALER_CARDS + toSymbol(dealer.getHand().getCards().getFirst()));
}
```

**관련 토픽**: 도메인 로직 위치, 관심사 분리, 상속 구조

**반응**: 👍 1

---

### 5. 딜러의 카드 드로우 로직 버그 🐛

**파일**: `src/main/java/controller/BlackJackController.java:37`

**리뷰어 (ddaaac)**:
> 딜러가 2, 2, 2 를 연속으로 받으면 어떻게 되나요?
>
> 주어진 요구사항만으로는 블랙잭 룰이 완전히 설명되지 않기 때문에 조금 더 찾아보시고 구현해보면 좋을 것 같아요. 명확하지 않은 요구사항을 명확하게 만들어가는 것도 개발자의 역량입니다.

**코드 컨텍스트**:
```java
blackJack.drawDealer();  // 딜러가 16 이하일 때 반복적으로 카드를 받아야 함
```

**문제점**: 딜러가 2, 2, 2를 받으면 합이 6이지만 한 장만 더 받고 멈추는 버그

**관련 토픽**: 요구사항 명확화, 반복 로직, 블랙잭 규칙

**반응**: 👍 1

---

### 6. 중복 상수 관리 🔢

**파일**: `src/main/java/domain/MatchResult.java:8`

**리뷰어 (ddaaac)**:
> Player에도 21이란 상수가 관리되고 있고, MatchResult에도 21란 상수가 관리되고 있네요.
>
> 상수를 public으로 열고 싶지 않다면 어떻게 해결할 수 있을까요?

**코드 컨텍스트**:
```java
// MatchResult.java
private static final int BLACKJACK_NUMBER = 21;

// Player.java에도 동일한 상수 존재
```

**관련 토픽**: 상수 관리, 중복 제거, 캡슐화

**반응**: 👍 1

---

### 7. 코드 포맷팅 ⚙️

**파일**: `src/main/java/domain/card/CardDeck.java:29`

**리뷰어 (ddaaac)**:
> 리포매팅 한 번 해주세요.

**코드 컨텍스트**:
```java
if(sum <= BONUS_THRESHOLD && hasA())sum+= ACE_BONUS;  // 공백 없음
```

**관련 토픽**: 코드 스타일, 가독성

**반응**: 👍 1

---

### 8. 메서드 네이밍 개선 📝

**파일**: `src/main/java/domain/card/CardDeck.java:24`

**리뷰어 (ddaaac)**:
> 로직은 단순 sum이 아닌 것 같아요. 적절하게 메서드명을 바꿔도 좋을 것 같네요.

**코드 컨텍스트**:
```java
public int sum() {
    int sum = cards.stream()
            .mapToInt(Card::getScore)
            .sum();

    if(sum <= BONUS_THRESHOLD && hasA()) sum += ACE_BONUS;  // A를 11로 계산하는 로직 포함

    return sum;
}
```

**제안**: `sumWithAce()` 또는 `calculateScore()` 같은 이름이 더 적절

**관련 토픽**: 네이밍, 의도 표현, 가독성

**반응**: 👍 1

---

### 9. OutputView의 책임과 디미터 법칙 🎭

**파일**: `src/main/java/view/OutputView.java:117`

**리뷰어 (ddaaac)**:
> OutputView가 참가자들의 구조를 모두 알고 있는 형태인데, Dealer, Player가 필요한 정보를 제공해주는 편이 더 나은 설계가 아닐까요?

**코드 컨텍스트**:
```java
// OutputView에서 참가자의 내부 구조에 깊게 접근
dealer.getHand().getCards()
player.getHand().getCards()
```

**관련 토픽**: 디미터 법칙, Tell Don't Ask, 캡슐화

**반응**: 👍 1

---

## 리뷰 진행 과정

### Round 1 (2025-03-07 15:19)
- **상태**: Changes Requested
- **주요 피드백**:
  - Functional interface 활용의 장단점 고민
  - Deck의 책임 위치 재고
  - 도메인 로직을 도메인에 위치시키기
  - 딜러 드로우 로직 버그 수정
  - 중복 상수 관리 개선
  - 코드 포맷팅
  - 메서드 네이밍 개선

### Round 2 (2025-03-09 15:28)
- **상태**: Changes Requested
- **추가 피드백 및 보완 사항 확인**

### Round 3 (2025-03-11 02:22)
- **상태**: Approved ✅
- **리뷰어 코멘트**: "안녕하세요 링크 👋 다음 단계 진행해주세요."

---

## 주요 학습 포인트

### 1. 객체지향 설계
- 현실 세계와 객체 세계의 차이점 이해
- 책임의 적절한 분배
- 도메인 로직의 위치

### 2. 캡슐화와 정보 은닉
- 테스트를 위한 getter의 필요성 vs 캡슐화
- 디미터 법칙 준수
- Tell Don't Ask 원칙

### 3. 설계 패턴과 기법
- Functional interface를 활용한 의존성 제어
- 일급 컬렉션 활용
- 상속 구조 설계

### 4. 코드 품질
- 명확한 메서드 네이밍
- 상수 중복 제거
- 코드 포맷팅

### 5. 요구사항 명확화
- 불명확한 요구사항을 명확하게 만드는 개발자의 역량
- 엣지 케이스 고려

---

## 개선 사항 요약

| 항목 | 개선 전 | 개선 후 |
|------|---------|---------|
| Deck 위치 | Dealer가 보유 | BlackJack이 보유 |
| 딜러 드로우 | 한 번만 실행 | 16 이하일 때 반복 |
| 카드 공개 | View에서 결정 | Dealer에 메서드 추가 |
| 메서드명 | `sum()` | `sumWithAce()` |
| 상수 관리 | 여러 곳에 중복 | Result 클래스로 통합 |
| OutputView | 깊은 접근 | 필요한 정보만 요청 |
