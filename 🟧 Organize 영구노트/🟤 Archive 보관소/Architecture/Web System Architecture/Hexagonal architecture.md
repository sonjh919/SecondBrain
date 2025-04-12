#Architecture

## Hexagonal architecture
소프트웨어 시스템을 **내부적인 도메인 로직(Core)과 외부의 환경(예: 데이터베이스, 외부 시스템 등)으로부터 분리**하는 데 중점을 둔다. 여러 소프트웨어 환경에 쉽게 연결할 수 있도록, 느슨하게 결합된 애플리케이션 구성요소를 만드는 것을 목표로 하는 아키텍처이다.

> [!note]+ 
> 도메인 비즈니스 로직이 외부요소에 의존하지 않게 만들고, 프레젠테이션 계층(controller)과 데이터 소스 계층(persistence) 같은 외부 요소들이 도메인 계층에 의존하도록 한다.
> → 외부와의 접촉을 인터페이스로 추상화하여 비즈니스 로직 안에 외부 코드나 로직의 주입을 막는 것, 외부 라이브러리 및 툴로부터 분리시키는 것이 아키텍처의 핵심이다.

### 구현
[[Port Adapter Pattern]]을 사용하여 구현한다.

![[PortAdapter.png]]

### 참고
![[Hexagonal architecture.png]]
https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/