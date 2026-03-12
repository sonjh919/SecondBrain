#Monitoring #Actuator 

## Actuator Endpoint
사용자 정의 Endpoint를 이용하여 구현할 수도 있다.

| HTTP 메서드        | 경로              | 설명                                                                              | 디폴트 활성화 |
| --------------- | --------------- | ------------------------------------------------------------------------------- | ------- |
| GET             | /auditevents    | 호출된 감사(audit) 이벤트 리포트를 생성한다.                                                    | No      |
| GET             | /beans          | 스프링 애플리케이션 컨텍스트의 모든 빈을 알려준다.                                                    | No      |
| GET             | /conditions     | 성공 또는 실패했던 자동-구성 조건의 내역을 생성한다.                                                  | No      |
| GET             | /configprop     | 모든 구성 속성들을 현재 값과 같이 알려준다.                                                       | No      |
| GET,POST,DELETE | /env            | 스프링 애플리케이션에 사용할 수 있는 모든 속성 근원과 이 근원들의 속성을 알려준다.                                 | No      |
| GET             | /env/{toMatch}  | 특정 환경 속성의 값을 알려준다.                                                              | No      |
| GET             | /health         | 애플리케이션의 건강 상태 정보를 반환한다.                                                         | Yes     |
| GET             | /heapdump       | 힙(heap) 덤프를 다운로드한다.                                                             | No      |
| GET             | /httptrace      | 가장 퇴근의 100개 요청에 대한 추적 기록을 생성한다.                                                 | No      |
| GET             | /info           | 개발자가 정의한 애플리케이션에 관란 정보를 반환한다.                                                   | Yes     |
| GET             | /loggers        | 애플리케이션의 패키지 리스트(각 패키지의 로깅 레벨이 포함된)를 생성한다.                                       | No      |
| GET,POST        | /loggers/{name} | 지정된 로거의 로깅 레벨(구성된 로깅 레벨과 유효 로깅 레벨 모두)을 반환한다. 유효 로깅 레벨은 HTTP POST 요청으로 설정될 수 있다. | No      |
| GET             | /mappings       | 모든 HTTP 매핑과 이 매핑들을 처리하는 핸들러 메서드들의 내역을 제공한다.                                     | No      |
| GET             | /metrics        | 모든 메트릭 리스트를 반환한다.                                                               | No      |
| GET             | /metrics/{name} | 지정된 메트릭의 값을 반환한다.                                                               | No      |
| GET             | /scheduledtasks | 스케줄링된 모든 태스크의 내역을 제공한다.                                                         | No      |
| GET             | /threaddump     | 모든 애플리케이션 스레드의 내역을 반환한다.                                                        | No      |

## Endpoint 사용하기
> [!example]+ 
> 실행 중인 스프링 부트 애플리케이션에 관한 정보를 알려면 /info 앤드포인트에 요구하면 된다. 이름이 info.으로 시작하는 하나 이상의 구성 속성을 생성하는 것이 가장 쉬운 방법이다.