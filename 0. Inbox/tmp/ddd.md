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
	ㄴ querydsl/elasticsearch/elasticcache/redis등등
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