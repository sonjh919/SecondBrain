#SoftwarePattern #ArchitecturePattern

## Layered Pattern
코드를 논리적인 부분 혹은 **역할에 따라 독립된 모듈로 나누어서 구성하는 패턴**이다. 각 모듈이 서로의 의존도에 따라 층층히 쌓듯이 연결되어 전체의 시스템을 구현하는 구조다. 그래서 마치 **레이어(layer)를 쌓아 놓은 것 같은 형태의 구조**가 된다. 즉, 역할에 따라 분리했던 파일들은 하나의 레이어로 볼 수 있다. 보통 다음과 같이 3개의 레이어가 존재한다.

> [!summary]+ 
> + Presentation Layer
> + Business Layer
> + Persistence Layer


![[layeredPattern.png]]

## 1. Presentation Layer
해당 시스템을 사용하는 사용자 혹은 클라이언트 시스템과 직접적으로 연결되는 부분이다. **백엔드 API에서 엔드포인트 부분**에 해당된다. 그러므로 Presentation Layer에서 API의 엔드포인트들을 정의하고 전송된 HTTP 요청(request)들을 읽어 들이는 로직을 구현한다. 하지만 그 이상의 역할은 담당하지 않는다. 실제 시스템이 구현하는 비즈니스 로직은 다음 레이어(layer)로 넘기게 된다.

## 2. Business Layer
**실제 시스템이 구현해야 하는 로직들을 이 레이어에서 구현**하게 된다. 

## 2. Persistence Layer
**데이터베이스와 관련된 로직을 구현**하는 부분이다. Business Layer에서 필요한 CRUD를 처리하여 실제로 데이터베이스와 Connection되는 부분이다.

> [!example]+ 
> [[MVC Pattern]]도 Layered Pattern의 일종이라 생각할 수 있다.

> [!example]+ 
> [[spring MVC]]에서는 다음과 같이 사용한다.
> Presentation layer → Controller
> Business layer → Service
> Persistence layer → Repository