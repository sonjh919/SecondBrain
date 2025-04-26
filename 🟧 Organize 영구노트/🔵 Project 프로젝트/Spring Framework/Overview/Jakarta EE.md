#SpringFramework 

Jakarta EE(이전 명칭: Java EE, J2EE)는 자바 SE를 확장하여 대규모 엔터프라이즈 애플리케이션 개발을 위한 다양한 사양(스펙)과 API를 제공하는 플랫폼이다. 이 플랫폼은 분산 컴퓨팅, 웹 서비스, 트랜잭션, 보안, 확장성, 동시성 관리 등 **엔터프라이즈 환경에 필요한 기능을 표준화**하여 제공한다.

> [!question]+ 엔터프라이즈 환경
> 대규모 조직(기업, 공공기관 등)의 복잡하고 다양한 IT 시스템, 애플리케이션, 데이터, 네트워크, 프로세스, 장치 등이 유기적으로 연결되어 운영되는 환경

원래 Sun Microsystems가 J2EE라는 이름으로 1999년에 도입했고, 이후 Java EE로 명칭이 바뀌었다. 2017년 Oracle이 Java EE를 Eclipse Foundation에 이관하면서, Java 및 javax 네임스페이스 상표권 문제로 인해 2018년부터 Jakarta EE로 이름이 변경되었다. 

Jakarta EE는 여러 벤더가 구현체(예: GlassFish, WildFly, Open Liberty 등)를 제공하며, 다양한 서버 환경에서 이식성과 표준성을 보장한다. 

> [!example]+ 주요 사양
> + Servlet
> + JSP
> + EJB
> + JPA
> + CDI
> + RESTful Web Services
> + WebSocket
> + Batch
> + Messaging
> + Validation

주요 변화로는 Java EE 8에서 Jakarta EE 8로의 완전 호환, Jakarta EE 9에서 API 네임스페이스가 `javax`에서 `jakarta`로 전환된 점이 있다.