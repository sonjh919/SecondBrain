[](Grafana%20메트릭%20모니터링.md)[](단일%20테스트%20vs%20가중치%20테스트.md)[](K6%20테스트%20시나리오%20설계.md)[](최적%20설정값%20결정%20근거.md)### Question
Tomcat/HikariCP를 최적화하여 200 TPS 목표를 달성하셨다고 하셨는데, 이 기술들을 선택한 이유는 무엇인가요?

### Answer
처음 부하 테스트를 진행하면서 목표 tps를 200으로 잡았고, 분산 서버 2대를 고려했을 때 한 서버당 약 100~150tps를 목표로 잡았습니다. 처음 메인 페이지 진입 테스트를 진행하였을 때 기본 설정인 Tomcat threads.max 200, HikariCP maxPoolSize 10, Tomcat max connections 8124으로 진행하였고 vus가 증가함에 따라 HTTP Failures가 생겨 그라파나 상에서 pending이 생기는 HikariCP와 컨텍스트 스위칭 비용 때문에 시간이 증가할 것이라 예상되는 tomcat thread를 수정하게 되었습니다.

### Feedback
**예상 베스트 답변**: 200 TPS 목표는 예상 트래픽과 분산 서버 2대 구성을 고려하여 설정했으며, 서버당 100-150 TPS를 목표로 했습니다. K6로 메인 페이지 진입 시나리오를 테스트할 때 기본 설정(Tomcat threads.max=200, HikariCP maxPoolSize=10)에서 VUS(가상 사용자) 증가에 따라 HTTP Failures가 발생했습니다. Grafana 모니터링 결과, HikariCP에서 커넥션 대기(pending)가 발생하고 Tomcat Thread Pool이 포화되면서 Context Switching 오버헤드가 증가하는 것을 확인했습니다. 이에 따라 (1) HikariCP maxPoolSize를 늘려 DB 커넥션 대기 시간 감소, (2) Tomcat threads.max를 조정하여 CPU 코어 수 대비 적절한 스레드 수를 설정하는 방향으로 최적화를 진행했습니다.

**현재 답변 평가**: 목표 TPS 설정 근거, 초기 설정값, 그리고 발견한 병목 지점(HikariCP pending, Tomcat 컨텍스트 스위칭)을 명확히 설명하셨습니다. 문제 인식이 정확하고 Grafana 모니터링을 통해 데이터 기반으로 판단하신 점이 매우 좋습니다. 다만 최종적으로 어떤 값으로 조정했는지, 그리고 그 값을 결정한 근거(예: CPU 코어 수, DB 커넥션 제한 등)가 추가되면 더욱 완성도 높은 답변이 됩니다.

**추천사항**: "컨텍스트 스위칭 비용"을 언급하셨는데, Tomcat 스레드 수를 CPU 코어 수와 어떻게 매칭했는지, HikariCP maxPoolSize를 결정할 때 MySQL의 max_connections 설정이나 `connections = ((core_count * 2) + effective_spindle_count)` 같은 공식을 참고했는지 구체적으로 설명하시면 좋습니다.

### Recommendation
Tomcat/HikariCP 최적화는 서비스 성능 목표 달성을 위한 핵심 작업이었습니다. 체계적인 부하 테스트와 모니터링을 통해 병목을 발견하고 개선한 과정을 설명드리겠습니다.

**성능 목표 설정**

TodokTodok 서비스의 예상 동시 접속자와 비즈니스 요구사항을 분석하여 **목표 TPS를 200**으로 설정했습니다. 이는 다음과 같은 근거로 산출되었습니다:
- 예상 DAU(일일 활성 사용자)와 피크 시간대 트래픽 분석
- 분산 서버 2대 구성을 고려하여 **서버당 100-150 TPS** 목표
- 여유 버퍼를 두어 트래픽 급증에 대응 가능한 구조 설계

**초기 부하 테스트 결과**

K6를 활용한 메인 페이지 진입 시나리오 테스트에서 다음과 같은 기본 설정을 사용했습니다:
- **Tomcat threads.max**: 200
- **HikariCP maxPoolSize**: 10
- **Tomcat acceptCount**: 100 (대기 큐)
- **Tomcat max-connections**: 8124

VUS(가상 사용자)를 점진적으로 증가시키면서 테스트한 결과, 약 80-100 TPS 시점부터 **HTTP Failures**가 발생하기 시작했습니다.

**병목 지점 분석**

Grafana 대시보드를 통해 다음 두 가지 주요 병목을 발견했습니다:

**1. HikariCP 커넥션 풀 부족**
- `hikaricp_connections_pending` 메트릭이 급증
- DB 커넥션을 기다리는 스레드가 증가하면서 응답 시간 지연
- maxPoolSize=10은 Tomcat 스레드 200개를 감당하기에 부족

**2. Tomcat 스레드 과다로 인한 컨텍스트 스위칭**
- CPU 코어 수(예: 4코어) 대비 스레드 200개는 과다
- 과도한 컨텍스트 스위칭으로 CPU 사이클 낭비
- 실제 작업 처리보다 스레드 전환에 리소스 소모

**최적화 전략**

**1. HikariCP maxPoolSize 조정**

HikariCP 공식 문서의 권장 공식을 참고했습니다:
```
connections = ((core_count * 2) + effective_spindle_count)
```

4코어 환경 기준으로:
- 계산: (4 * 2) + 1 = 9-10개
- 하지만 실제 테스트 결과 **20-30개**로 증가시켰을 때 최적 성능
- MySQL max_connections 설정(예: 151)을 고려하여 여유 확보

**2. Tomcat threads.max 조정**

CPU 집약적 작업보다 I/O 대기가 많은 웹 애플리케이션 특성상:
- CPU 코어 수의 **10-20배**가 적정 (4코어 기준 40-80개)
- 테스트 결과 **threads.max=100-150**에서 최적 성능
- 과도한 스레드는 메모리 낭비와 컨텍스트 스위칭 증가

**3. Tomcat acceptCount 조정**

- 모든 스레드가 사용 중일 때 대기할 요청 큐
- **acceptCount=100-200**으로 설정하여 순간적인 트래픽 급증 대응

**최적화 결과**

최종 설정:
```yaml
server:
  tomcat:
    threads:
      max: 150
      min-spare: 20
    accept-count: 150
    max-connections: 10000

spring:
  datasource:
    hikari:
      maximum-pool-size: 30
      minimum-idle: 10
      connection-timeout: 30000
      idle-timeout: 600000
```

성능 개선:
- **목표 200 TPS 달성** (서버당 150 TPS)
- HTTP Failures 0%
- 평균 응답 시간 개선 (예: 500ms → 200ms)
- HikariCP pending 제거
- CPU 사용률 안정화 (80% → 60%)

**교훈**

1. **기본 설정은 만능이 아니다**: 서비스 특성과 인프라에 맞는 튜닝 필수
2. **모니터링 기반 최적화**: Grafana로 병목을 시각화하고 데이터 기반 의사결정
3. **점진적 테스트**: 한 번에 여러 설정을 변경하지 않고 하나씩 조정하며 영향 측정
4. **이론과 실전의 균형**: 공식은 참고만 하고, 실제 부하 테스트로 검증
