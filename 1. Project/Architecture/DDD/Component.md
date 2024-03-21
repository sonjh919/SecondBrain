#Architecture #DDD


## Component
Event Storming을 진행하기 전에 먼저 Component의 종류에 대해서 알아야 한다. Component는 시스템 내에서 역할을 수행하는 요소로, 비즈니스 프로세스에서 발생하는 이벤트들과 상호 작용하며 시스템의 동작을 결정하는 요소이다.

![[4. Archive/img/Architecture/Component.png]]

> [!caution]+ 
> 순서는 달라질 수 있다!
### 1. Domain Event
+ **시간의 흐름에 따라 비즈니스 상태 변경을 의미하는 도메인 이벤트를 도출**한다.
+ **P.P형태의 동사**로 작성한다. 이는 이 사건이 발생했다는 것을 의미한다.
+ **주어는 한 개만 사용**한다.

![[DomainEvent.png]]

### 2. External system
+ **외부 시스템**으로, 현재 설계하고 있는 도메인 시스템을 제외한 모든 시스템이다.
+ **커맨드 & 이벤트 발생 시 호출되거나 관련되는 레거시 시스템이나 외부 시스템 또는 제어되는 장비를 도출**한다. 
+ 연계가 필요한 것을 표현한다.
+ **명사 형태**로 표현한다.

> [!example]+ 
> 결제 외부 시스템 도입 : 토스, 카카오페이 등
> 이메일 외부 시스템 도입 : 구글 이메일 인증 등

![[ExternalSystem.png]]
### 3. Command & ReadModel
#### Command
+ 이벤트를 발생시키는 Command를 도출한다.
+ 행동, 결정 등의 값들에 대한 정의이다.
+ **현재형**으로 작성하며, **동사 형태**로 표현한다.
+ **API** 도출으로도 생각할 수 있다.

#### ReadModel
+ 행위와 결정을 하기 위해 유저가 참고하는 데이터이다.
+ 단순 **도메인 이벤트 조회**
+ [[Data Projection]]이 필요하다면 **CQRS** 등으로 수집
+ 조회에 해당하는 Event는 따로 ReadModel로 구분한다.

![[Command.png]]

### 4. Hotspot
+ 예측되는 Risk에 대해 정의한다.

![[HotSpot.png]]

### 5. Actor
+ **행동 주체**(관리자, 전체 회원, 로그인 회원 등)를 정의한다.

![[actor.png]]

### 6. [[2. Area/Book/도메인 주도 개발 시작하기/2. 아키텍처 개요/Aggregate|Aggregate]]
 + 비즈니스 로직 처리의 **도메인 객체 덩어리**이다.
 + 유저 인터페이스를 통해 데이터를 소비하고 명령을 실행하여 시스템과 상호 작용한다.
 + 한 Aggregate가 하나의 git repository가 되고, 여러 개의 git reopsitory가 통신하여 하나의 MSA 아키텍쳐를 구성할 것이다.

![[4. Archive/img/Architecture/Aggregate.png]]

### 7. Bounded Context Deduction
+ 같은 Aggregate끼리 묶는다.

![[BoundedContextDuduction.png]]
### 8. Policy
+ 업무 정책으로, 이벤트에 대한 반응을 정의한다.(**Business Rule Engine**)
+ Domain Event가 policy에 의해 상황에 따른 결과를 받는다.

> [!question]+ Business Rule Engine
> + 업무에서 발생하는 규칙을 기반으로 새로운 시스템 개발을 할 수 있는 툴을 말하며, 제어와 업무절차를 분리해서 IT시스템에서 규칙과 연관된 부분을 따로 관리하는 개념이다.
> + 규칙기반관리시스템(RBMS)라고도 불린다.

![[Policy.png]]

### 9. Context Mapping
+ 지금까지 설계한 것들을 Context 간 Mapping으로 간단하게 나타내면 다음과 같다.
+ MSA로 개발할 경우, [[Boris Diagram]]을 이용하여 Context Mapping을 하게 된다. 만약 Mono를 사용할 것이라면, 바로 Snap-E를 정의하고 개념 수준의 객체 모델링으로 넘어가면 된다.

![[ContextMapping.png]]

### 10. Snap-E (Snapshots of Events)
+ 이벤트들을 간단한 텍스트 형식으로 기록하여 모델의 흐름을 시각화하는 데 사용한다.

![[snapE.png]]

### 11. 개념 수준의 객체 모델
+ 객체 모델링([[Domain Model]])을 하고 ,Boris Diagram과 함께 개발을 시작하면 된다!
![[modeling.png]]