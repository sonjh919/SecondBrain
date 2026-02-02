#SpringFramework 

- Spring Framework는 2003년에 초기 J2EE([[Jakarta EE]]의 전신) 사양의 **복잡성에 대한 대응**으로 탄생했다.

- Java EE(현 Jakarta EE)와 경쟁 관계로 여겨지기도 하지만, 실제로는 상호 보완적인 관계다. Spring은 EE 플랫폼 전체를 받아들이지 않고, **EE의 일부 핵심 사양(예: 의존성 주입 JSR 330, 공통 어노테이션 JSR 250 등)만 선별적으로 통합**한다.

- 초기에는 EE의 `javax` 패키지를 기반으로 했으나, Spring Framework 6.0부터는 Jakarta EE 9 수준(예: Servlet 5.0+, JPA 3.0+)으로 업그레이드되어, EE 9 이상을 지원하고 네임스페이스도 `jakarta`로 전환되었다. Spring Framework 6.0은 Tomcat 10.1, Jetty 11, Undertow 2.3, Hibernate ORM 6.1 등 최신 서버 및 ORM과 호환된다.

- 과거에는 J2EE 및 Spring 기반 애플리케이션이 전통적인 애플리케이션 서버에 배포되는 방식이 일반적이었으나, 현재는 Spring Boot의 등장으로 **서블릿 컨테이너를 내장하고, 클라우드 및 DevOps 환경에적합한 방식으로 애플리케이션을 개발**하는 것이 표준이 되었다.

- Spring Framework 5부터는 WebFlux를 통해 서블릿 API 없이도 Netty와 같은 서버에서 동작할 수 있게 되었다.

- Spring은 지속적으로 진화하고 있으며, Spring Boot, Spring Security, Spring Data, Spring Cloud, Spring Batch 등 다양한 프로젝트로 확장되었다. 각 프로젝트는 독립적으로 개발 및 관리된다.
