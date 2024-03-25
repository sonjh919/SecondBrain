구현
https://velog.io/@gowjr207/%EB%8F%84%EB%A9%94%EC%9D%B8-%EC%A3%BC%EB%8F%84-%EC%84%A4%EA%B3%84DDD%EB%A5%BC-%EC%84%A4%EB%AA%85%ED%95%B4%EB%B3%B4%EB%8B%A4

ddd 책 보기

디자인 패턴 정리
[[Event Storming]]


dto..?
```
com.myshop.Order
ㄴ ui
	ㄴ contorller
	ㄴ validator
ㄴ application
	ㄴ service
	ㄴ validator
	ㄴ event
		ㄴ OrderCanceledEvent(이벤트 클래스)
		ㄴ OrderCanceledEventHandler(이벤트 핸들러)
ㄴ domain
	ㄴ Order(interface)
	ㄴ model
		ㄴ Order
		ㄴ OrderLine
		ㄴ Orderer
		ㄴ Address
	ㄴ OrderRepository(Repository)(interface)
	ㄴ service(도메인 서비스)
		ㄴ (도메인 서비스들)
ㄴ infrastructure
	ㄴ JpaOrder
		ㄴ Order(Aggregate, Root-Entity)
		ㄴ OrderLine(Entity)
		ㄴ Orderer(Entity)
		ㄴ Address(Value)
	ㄴ JpaOrderRepository(구현체)
ㄴ global 
	ㄴ common
		ㄴ event
			ㄴ Events(이벤트 발생)
			ㄴ Event(공통 추상 클래스)
			ㄴ EventsConfiguration
		ㄴ dto
			ㄴ response
			ㄴ exception
	ㄴ exception
	ㄴ config
	ㄴ aop
	ㄴ interceptor
	ㄴ filter
	ㄴ jwt
	ㄴ util 등등..
```