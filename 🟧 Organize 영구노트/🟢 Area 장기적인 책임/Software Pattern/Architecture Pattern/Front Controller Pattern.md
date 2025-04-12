#SoftwarePattern #ArchitecturePattern

## Front Controller Pattern
웹 애플리케이션에서 클라이언트의 모든 요청을 처리하기 위한 중앙 컨트롤러 역할을 하는 컴포넌트를 도입하는 패턴이다. 이 패턴은 **애플리케이션의 진입점이 되는 컨트롤러를 통해 클라이언트 요청을 처리**하고, **요청에 따라 적절한 컨트롤러나 핸들러로 분배**하는 역할을 한다. 이렇게 된다면 공통된 로직을 매번 작성하지 않아도 되서 개발자는 핵심 로직에만 집중할 수 있을 것이다.

![[🟧 Organize 영구노트/🟤 Archive 보관소/img/Software Pattern/frontcontroller.png]]

> [!question]+ 왜 필요할까?
> 요청 경로마다 로직을 정의해주는 것은 핸들러마다 공통된 로직(ex) 인코딩처리)을 중복 작성한다는 비효율적인 측면이 있다. 따라서 공통된 로직을 앞단에 두어 한번에 처리하고자 만들어지게 되었다.

## Front Controller 패턴의 특징
> [!note]+ 
> 1. 단일 진입점 : 모든 요청은 Front Controller를 통해 먼저 진입한다.
> 2. 중앙 집중화된 요청 처리 : 공통 작업을 효율적으로 수행할 수 있다.
> 3. 컨트롤러나 핸들러로 요청 분배 : 요청을 분석하고 적절한 컨트롤러나 핸들러로 요청을 분배한다.
> 4. 공통 기능 구현 : 공통 기능을 Front Controller에서 구현하여 중복을 방지하고, 유지보수성을 향상시킨다.
> 5. 뷰 선택 및 렌더링 : 요청에 따라 어떤 뷰을 사용할지 결정하여 응답을 생성한다.


> [!info]+ 
> Spring에서는 Front Controller Pattern을 DispatcherServlet에 적용하여 사용하고 있다.