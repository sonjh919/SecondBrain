# PR #808 - [1단계 - 블랙잭] 링크(손준형) 코드 변경 사항

## PR 정보
- **제목**: [1단계 - 블랙잭] 링크(손준형) 미션 제출합니다.
- **작성자**: sonjh919 (Link)
- **생성일**: 2025-03-07
- **병합일**: 2025-03-11
- **URL**: https://github.com/woowacourse/java-blackjack/pull/808

## 주요 변경 사항

### 1. 도메인 모델 구현

#### 카드 관련 클래스
- `Card.java`: 카드 모양(Shape)과 숫자(Number)를 가진 카드 클래스
- `CardDeck.java`: 카드 덱을 관리하는 클래스
- `Hand.java`: 플레이어/딜러가 보유한 카드 목록을 관리
- `Number.java`: 카드 숫자 열거형 (ACE~KING, 점수 포함)
- `Shape.java`: 카드 모양 열거형 (스페이드, 다이아몬드, 하트, 클로버)

#### 참가자 관련 클래스
- `Participant.java`: 딜러와 플레이어의 공통 추상 클래스
- `Player.java`: 플레이어 클래스, 승패 계산 로직 포함
- `Players.java`: 여러 플레이어를 관리하는 일급 컬렉션
- `Dealer.java`: 딜러 클래스, 16 이하면 카드를 더 받는 로직 포함

#### 블랙잭 게임 로직
- `BlackJack.java`: 블랙잭 게임의 메인 로직
- `MatchResult.java`: 승/무/패 결과 열거형
- `Result.java`: 승패 판정 로직

### 2. 설정 및 팩토리
- `CardDeckFactory.java`: 52장의 카드 덱을 생성하고 셔플하는 팩토리 클래스

### 3. 컨트롤러
- `BlackJackController.java`: 게임 전체 흐름을 제어하는 컨트롤러

### 4. 뷰
- `InputView.java`: 사용자 입력을 처리
- `OutputView.java`: 게임 상태 및 결과 출력
- `Answer.java`: y/n 응답을 처리하는 열거형
- `InputUntilValid.java`: 입력 검증을 위한 함수형 인터페이스

### 5. 애플리케이션 진입점
- `Application.java`: main 메서드를 포함한 실행 클래스

### 6. 테스트 코드
- `CardDeckFactoryTest.java`: 카드 덱 생성 테스트
- `BlackJackTest.java`: 블랙잭 게임 로직 테스트
- `ResultTest.java`: 승패 판정 로직 테스트
- `DealerTest.java`: 딜러 동작 테스트
- `PlayerTest.java`: 플레이어 동작 테스트
- `PlayersTest.java`: 플레이어 그룹 관리 테스트
- `HandTest.java`: 핸드 점수 계산 테스트

## 구현된 기능

### 카드 정책
- 카드 모양: 스페이드, 다이아몬드, 하트, 클로버 4가지
- 카드 숫자: A, 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K

### 플레이어 정책
- 플레이어 인원: 최소 1명, 최대 6명

### 블랙잭 게임 정책
#### 카드 뽑기 정책
- 게임 시작 시 카드 2장 받음
- 플레이어: 21을 초과하지 않는 선에서 카드 계속 받을 수 있음
- 딜러: 16 이하면 반드시 카드를 추가로 받음

#### 카드 공개 정책
- 플레이어: 받는 즉시 모든 카드 공개
- 딜러: 처음 받은 카드 1장 비공개, 게임 끝날 때 공개

#### 점수 계산 정책
- J, Q, K: 10점
- A: 1점 또는 11점 (유리한 쪽으로 자동 계산)

#### 승자 판별 정책
- 21을 초과하지 않으면서 21에 가장 가까운 플레이어 승리
- 딜러와 점수 같으면 무승부

## 코드 구조

```
src/main/java/
├── Application.java
├── config/
│   └── CardDeckFactory.java
├── controller/
│   └── BlackJackController.java
├── domain/
│   ├── blackJack/
│   │   ├── BlackJack.java
│   │   ├── MatchResult.java
│   │   └── Result.java
│   ├── card/
│   │   ├── Card.java
│   │   ├── CardDeck.java
│   │   ├── Hand.java
│   │   ├── Number.java
│   │   └── Shape.java
│   └── participant/
│       ├── Participant.java
│       ├── Player.java
│       ├── Players.java
│       └── Dealer.java
└── view/
    ├── Answer.java
    ├── InputUntilValid.java
    ├── InputView.java
    └── OutputView.java
```

## 주요 설계 특징

1. **상속 구조**: Participant 추상 클래스를 Player와 Dealer가 상속
2. **일급 컬렉션**: Players 클래스로 플레이어 그룹 관리
3. **함수형 인터페이스**: 출력 타이밍 제어를 위해 Function과 Consumer 활용
4. **열거형 활용**: Card 속성, 승패 결과, 응답 타입을 열거형으로 관리
5. **팩토리 패턴**: CardDeckFactory로 카드 덱 생성 로직 분리
