#Monitoring #Actuator

## Actuator
Actuator는 스프링 부트 애플리케이션을 모니터링하고 관리하기 위한 기능을 제공하는 라이브러리이다. Actuator는 애플리케이션의 상태를 확인하고 관리하는 데 사용된다. 이를 통해 **운영 환경에서 애플리케이션을 감시하고 문제를 진단**하는 데 도움이 된다.

실행 중인 애플리케이션의 내부를 볼 수 있게 하고, 어느 정도까지는 애플리케이션의 작동 방법을 제어할 수 있게 한다.

> [!example]+ 
> 1. 애플리케이션 환경에서 사용할 수 있는 구성 속성들
> 2. 애플리케이션에 포함된 다양한 패키지의 로깅 레벨(logging level)
> 3. 애플리케이션이 사용 중인 메모리
> 4. 지정된 엔드포인트가 받은 요청 횟수
> 5. 애플리케이션의 건강 상태 정보

> [!info]+ 
> HTTP 방식과 JMX 방식이 있으며 대표적으로 많이 쓰는 것이 **Health Check** 용도의 actuator health endpoint이다.

> [!note]+ 의존성 추가하기
> ```java
> implementation 'org.springframework.boot:spring-boot-starter-actuator'
> ```

Actuator 스타터가 프로젝트 빌드의 일부가 되면 애플리케이션에서 여러 가지 [[Actuator Endpoint]]를 사용할 수 있다.

## Actuator 기본 경로 구성
Actuator의 모든 엔드포인트의 경로에는 `/actuator`가 앞에 붙는다. Actuator의 기본 경로는 management.endpoint.web.base-path 속성을 설정하여 변경할 수 있다.

> [!tip]+ 
> 모든 엔드포인트를 노출하려면 `*`을 사용한다.

```java
management:
  endpoints:
    web:
      exposure:
        include: health,info,beans,conditions
        exclude: threaddump, heapdump
```