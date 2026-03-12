[](단일%20vs%20가중치%20테스트.md)### Question
구체적으로 어떤 설정값들을 어떻게 최적화하셨나요? 그리고 그 설정값을 선택한 근거가 무엇인가요?

### Answer
api 응답 시간과 히카리 connection pool의 pending 수, api 요청 실패 수를 보고 병목을 판단했습니다. 단일 테스트에서는 tomcat thread 3, 히카리cp 10으로도 최대 동시 접속자 500명을 기준으로 목표 tps인 200을 달성할 수 있었으나, 가중치 테스트에서는 최대 동시 접속자 300명을 기준으로 100tps까지 처리 가능하여 서버 한 대를 추가하여 scale out으로 목표 tps를 달성하였습니다.

### Feedback
메트릭 기반의 체계적인 접근과 단일/가중치 테스트를 구분하여 진행하신 점이 매우 인상적입니다. 다만, Tomcat thread를 3으로 설정한 구체적인 이유(예: CPU 코어 수와의 관계, context switching 최소화 등)와 HikariCP를 10으로 설정한 근거(예: DB 최대 커넥션 수, 계산 공식 등)를 추가로 설명하면 더욱 완성도 높은 답변이 될 것입니다. 또한 Scale Out을 선택한 이유(Scale Up 대비 장점)도 언급하면 좋습니다.

### Recommendation
성능 병목을 판단하기 위해 API 응답 시간, `hikaricp_connections_pending` 메트릭, 그리고 API 요청 실패율을 주요 지표로 모니터링했습니다.

최적화 과정에서는 먼저 단일 API에 대한 부하 테스트를 진행했습니다. Tomcat의 `threads.max`는 서버의 CPU 코어 수(2 vCPU)를 고려하여 3으로 설정했는데, 이는 과도한 스레드로 인한 context switching 오버헤드를 최소화하기 위함이었습니다. HikariCP의 `maximum-pool-size`는 10으로 설정했는데, 이는 HikariCP 권장 공식인 `connections = ((core_count * 2) + effective_spindle_count)`를 참고하되, RDS의 최대 커넥션 제한과 서버 대수를 고려하여 조정한 값입니다. 이 설정으로 최대 동시 접속자 500명 기준 목표 TPS 200을 달성할 수 있었습니다.

그러나 실제 운영 환경을 시뮬레이션한 가중치 테스트(여러 API를 동시에 호출)에서는 최대 동시 접속자 300명 기준 100 TPS까지만 처리 가능했습니다. 이는 다양한 API가 동시에 리소스를 경쟁하면서 발생한 결과였습니다. 

단일 서버의 스레드나 커넥션 풀을 더 늘리는 Scale Up 방식은 CPU와 메모리 한계로 인해 효율이 떨어지고, context switching으로 오히려 성능이 저하될 수 있다고 판단했습니다. 따라서 동일한 설정의 서버를 한 대 더 추가하는 Scale Out 방식을 선택하여, ALB를 통한 로드 밸런싱으로 각 서버가 100 TPS씩 처리하도록 구성해 목표인 200 TPS를 안정적으로 달성했습니다.
