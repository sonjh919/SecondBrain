#Architecture #DDD


## Domain
+ 역할과 책임이 있는 사건의 주체 영역 (Action, Data, Event)
+ **주체의 값이 변경되는 곳**이다.

> [!example]+ 
> + 장바구니는 시스템적으로 상품을 목록화해주기 때문에 Domain이 아닌 Read Model이다.
> + 상품 Domain은 상품을 추가/수정/삭제를 해주기 때문에 Domain이다.

## DDD(Domain Driven Design)
Domain model 단위로 나누어 설계하는 방식이다. DDD의 핵심 목표는 의존성을 최소화하고, 응집성을 최대화시키는 것이다.

> [!faq]+ 응집도?결합도?
> 오브젝트 4장의 설계 트레이드오프 부분을 참고하자.
> + [[04 설계 품질과 트레이드오프]]


## Domain Model Design Pattern
그렇다면 도메인 모델을 설계하는 방법들은 어떤 것이 있을까? 여러 방법이 있지만 [[Event Storming]] 방식을 가장 많이 사용한다.

> [!summary]+ Domain Model Design Pattern
> **User Stroy Mapping**
> + 아이디어를 덩어리로 나누어서 토론 및 모델링하는 기법
> + 모든 것을 다 안다면 사용하는 방식이다. 하지만 현실적으로 모든 것을 아는 사람은 드물다.
> 
> **Event Storming**
> + 이벤트를 사용하여 시스템을 모델링하기 위한 워크샵 및 브레인스토밍 기법
> + User Story Mapping의 문제점을 개선하기 위해 나온 방법이다.
> + 어떤 이벤트가 발생할지, 어떤 순서로 이벤트가 발생할지 모를 경우 사용한다.
> 
> **Event Modeling**
> + 시간과 이벤트의 개념 중심으로 하는 마인드맵 모델링 기법
> + 어떤 이벤트가 발생할지 알고 있을 경우 사용한다.

> [!tip]+ 
> 설계를 잘 해놓으면 구현기간이 매우 짧아진다! 설계를 잘하자!!


---
