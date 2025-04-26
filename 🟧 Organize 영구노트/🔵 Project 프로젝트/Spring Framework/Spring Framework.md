#SpringFramework

### Overview

+ 엔터프라이즈 자바 애플리케이션 개발을 용이하게 하는 **오픈 소스** 프로젝트로, Jakarta EE 스펙과 통합된다.

> [!info]+ Java EE
> 자바를 이용한 서버측 개발을 위한 플랫폼. Jakarta EE는 Java EE의 표준 플랫폼이다.


+ 핵심 컨테이너, 의존성 주입, AOP, 데이터 접근, 웹 개발(MVC 및 WebFlux), 테스트 등 **다양한 기능**을 모듈 형태로 제공한다.
+ **유연성, 선택의 자유, 강력한 하위 호환성**을 핵심 가치로 삼는다. 
+ **스프링 부트**와 같은 다른 스프링 프로젝트와 함께 사용되어 빠르고 효율적인 개발을 지원한다.

### "Spring"의 의미
가장 기본적인 의미는 **Spring Framework 프로젝트 자체**를 지칭하며, 이는 모든 Spring 관련 활동의 시작점이다. 시간에 따라 다른 Spring 프로젝트가 Spring Framework 위에 구축되었다.

대부분의 경우 "Spring"은 Spring Framework를 기반으로 구축된 Spring 프로젝트 전체 패밀리를 의미하는데, 여기서 이야기하는 "Spring"은 Spring Framework 자체에 초점을 맞추고 있다.

### Spring Framework 모듈
Spring Framework는 [[모듈]]로 나뉘어져 있고, 애플리케이션은 **필요한 모듈을 선택하여 사용**할 수 있다.

> [!question]+ 모듈
> 외부에서 재사용 할 수 있는 패키지들을 묶은 것

#### 선택적 사용 (Modularity)
Spring Framework가 모듈 구조를 채택함으로써 개발자는 애플리케이션에 필요한 기능만 포함할 수 있다.

#### 핵심 기능
Spring Framework의 핵심에는 **핵심 컨테이너 모듈**이 있으며, 이 모듈은 **설정 모델과 의존성 주입 메커니즘**을 포함한다 . 이러한 핵심 모듈은 Spring 프레임워크의 가장 기본적인 토대를 제공하며, Spring 기반 애플리케이션의 객체 관리 및 의존성 해결의 핵심 역할을 수행한다.

#### 다양한 기능 지원
핵심 컨테이너 외에도 Spring Framework는 메시징, 트랜잭션 데이터 및 영속성, 웹을 포함한 다양한 애플리케이션 아키텍처에 대한 기본적인 지원을 제공하는 모듈들을 포함한다 . 
이는 Spring Framework가 단순히 의존성 주입 컨테이너를 넘어 엔터프라이즈 애플리케이션 개발에 필요한 광범위한 기능을 제공한다는 것을 의미한다. 
특히 서블릿 기반의 Spring MVC 웹 프레임워크와 반응형 웹 프레임워크인 Spring WebFlux를 모두 포함하는 웹 관련 모듈은 Spring을 웹 애플리케이션 개발을 위한 강력한 선택지로 만들어준다.

#### Java 모듈 시스템 지원
Spring Framework의 JAR 파일은 **Java 모듈 시스템(JMS)** 으로 배포될 수 있도록 지원하며, Automatic-Module-Name 매니페스트 항목을 포함하여 안정적인 언어 수준 모듈 이름 (spring.core, spring.context 등)을 정의한다 . 이는 Spring Framework가 최신 Java 플랫폼 기능을 수용하고 있으며, 모듈화된 애플리케이션 개발을 지원한다는 것을 보여준다.