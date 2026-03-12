### Question
Grafana에서 추적한 구체적인 메트릭에는 어떤 것들이 있었나요? 특히 hikaricp_connections_pending 같은 메트릭을 어떻게 수집하고 시각화하셨는지 궁금합니다.

### Answer
tomcat_connections_current_connections와 tomcat_connections_keepalive_current_connections로 현재 커넥션 수를 체크하였고, tomcat_threads_current_threads와 tomcat_threads_busy_threads로 스레드 수를 체크하였습니다. 히카리 connection pool은 hikaricp_connections_active / idle / pending으로 체크하였습니다. 또한 평균 요청 응답시간과 요청 성공 및 실패 수, peak rps 등을 체크하여 성능을 확인하였습니다.

### Feedback
**예상 베스트 답변**: Grafana 모니터링은 Spring Boot Actuator + Prometheus + Grafana 스택으로 구성했습니다. **Tomcat 메트릭**으로는 `tomcat_connections_current_connections`(현재 커넥션 수), `tomcat_connections_keepalive_current_connections`(Keep-Alive 커넥션), `tomcat_threads_current_threads`(총 스레드), `tomcat_threads_busy_threads`(사용 중인 스레드)를 추적했습니다. **HikariCP 메트릭**으로는 `hikaricp_connections_active`(사용 중인 커넥션), `hikaricp_connections_idle`(대기 중인 커넥션), `hikaricp_connections_pending`(커넥션 대기 중인 스레드)을 모니터링했습니다. **애플리케이션 메트릭**으로는 평균/P95/P99 응답 시간, 요청 성공/실패 수, Peak RPS(초당 요청 수)를 추적했습니다. 특히 pending이 증가할 때 응답 시간이 급증하는 패턴을 발견하여 maxPoolSize를 10에서 30으로 증가시켰고, busy_threads가 threads.max에 근접할 때 컨텍스트 스위칭이 증가하는 것을 확인하여 threads.max를 3으로 조정했습니다.

**현재 답변 평가**: 핵심 메트릭들을 정확히 파악하고 계십니다. Tomcat 커넥션/스레드, HikariCP 커넥션 풀, 그리고 응답 시간/성공률/RPS까지 전체적인 모니터링 체계가 잘 갖춰져 있습니다. 다만 이러한 메트릭을 어떻게 수집했는지(Spring Actuator, Micrometer 등), Prometheus와의 연동 방법, 그리고 각 메트릭에서 발견한 구체적인 임계값이나 패턴(예: pending > X일 때 문제 발생)을 추가로 설명하시면 더욱 기술적 깊이를 보여줄 수 있습니다.

**추천사항**: Grafana 대시보드 구성 방법(패널 레이아웃, 알림 설정 등)이나, 특정 메트릭의 임계값을 어떻게 설정했는지(예: busy_threads / current_threads > 80%일 때 경고) 언급하시면 좋습니다. 또한 이력서에 Loki도 명시되어 있으니, 로그 기반 모니터링과 메트릭 기반 모니터링을 어떻게 조합했는지 설명하시면 더욱 완성도 높은 답변이 됩니다.

### Recommendation
Grafana 모니터링 시스템은 애플리케이션의 실시간 상태를 가시화하고 성능 병목을 즉시 발견하기 위한 핵심 인프라였습니다. TodokTodok 프로젝트에서는 **Spring Boot Actuator + Micrometer + Prometheus + Grafana** 스택으로 구성했습니다.

**모니터링 아키텍처**

```
Spring Boot Application
    ↓ (expose metrics)
Spring Actuator + Micrometer
    ↓ (format metrics)
Prometheus
    ↓ (scrape & store)
Grafana
    ↓ (visualize)
Dashboard + Alerts
```

**1. Tomcat 메트릭**

Tomcat 내장 서버의 커넥션과 스레드 상태를 추적:

**커넥션 메트릭**:
- `tomcat_connections_current_connections`: 현재 활성 커넥션 수
- `tomcat_connections_keepalive_current_connections`: Keep-Alive 상태의 커넥션 수
- `tomcat_connections_max`: 최대 허용 커넥션 수

**임계값 설정**:
```
현재 커넥션 > 최대 커넥션의 80% → WARNING
현재 커넥션 = 최대 커넥션 → CRITICAL
```

**스레드 메트릭**:
- `tomcat_threads_current_threads`: 현재 생성된 스레드 총 개수
- `tomcat_threads_busy_threads`: 요청을 처리 중인 스레드 수
- `tomcat_threads_config_max_threads`: 설정된 최대 스레드 수

**임계값 설정**:
```
스레드 사용률 = (busy_threads / current_threads) * 100
스레드 사용률 > 80% → WARNING
스레드 사용률 > 95% → CRITICAL
```

**발견한 인사이트**:
- threads.max=200일 때 busy_threads가 150-180 사이를 왔다갔다 → 거의 포화 상태
- threads.max=3으로 줄인 후 busy_threads는 2-3 사이로 안정 → 효율적 활용

**2. HikariCP 메트릭**

데이터베이스 커넥션 풀의 상태를 실시간 모니터링:

**커넥션 상태 메트릭**:
- `hikaricp_connections_active`: 현재 사용 중인 커넥션 수
- `hikaricp_connections_idle`: 대기 중인 유휴 커넥션 수
- `hikaricp_connections_pending`: 커넥션을 기다리는 스레드 수
- `hikaricp_connections_total`: 풀의 전체 커넥션 수
- `hikaricp_connections_max`: 설정된 최대 커넥션 수
- `hikaricp_connections_min`: 설정된 최소 커넥션 수

**타이밍 메트릭**:
- `hikaricp_connections_acquire`: 커넥션 획득 시간
- `hikaricp_connections_usage`: 커넥션 사용 시간
- `hikaricp_connections_creation`: 커넥션 생성 시간
- `hikaricp_connections_timeout_total`: 커넥션 획득 타임아웃 발생 횟수

**임계값 설정**:
```
pending > 0 → WARNING (커넥션 부족 신호)
pending > 5 → CRITICAL (심각한 커넥션 부족)
active / max > 0.9 → WARNING (풀 용량 거의 소진)
acquire > 100ms → WARNING (커넥션 획득 지연)
```

**발견한 인사이트**:
- maxPoolSize=10일 때 pending이 지속적으로 5-10 발생 → 커넥션 부족
- threads.max를 200 → 3으로 줄이니 pending이 0으로 수렴 → 경합 해소
- acquire 시간이 평균 50ms에서 5ms로 개선

**3. 애플리케이션 성능 메트릭**

K6 부하 테스트와 연동하여 실시간 성능 추적:

**응답 시간 메트릭**:
- `http_server_requests_seconds_sum / http_server_requests_seconds_count`: 평균 응답 시간
- `http_server_requests_seconds{quantile="0.95"}`: P95 응답 시간
- `http_server_requests_seconds{quantile="0.99"}`: P99 응답 시간

**요청 처리 메트릭**:
- `http_server_requests_total{status="2xx"}`: 성공한 요청 수
- `http_server_requests_total{status="4xx"}`: 클라이언트 에러 수
- `http_server_requests_total{status="5xx"}`: 서버 에러 수
- `rate(http_server_requests_total[1m])`: 초당 요청 수 (RPS)

**목표 및 임계값**:
```
평균 응답 시간 < 300ms
P95 응답 시간 < 500ms
P99 응답 시간 < 1000ms
성공률 > 99%
Peak RPS > 200
```

**4. JVM 메트릭**

메모리 및 가비지 컬렉션 모니터링:

- `jvm_memory_used_bytes`: 사용 중인 메모리
- `jvm_memory_max_bytes`: 최대 메모리
- `jvm_gc_pause_seconds_sum`: GC 소요 시간
- `jvm_threads_live_threads`: JVM 스레드 수

**발견한 인사이트**:
- threads.max=200일 때 JVM 스레드 수가 250+ (Tomcat 스레드 + 기타)
- threads.max=3으로 줄이니 JVM 스레드 수가 50대로 감소 → 메모리 절약

**5. MySQL 메트릭**

데이터베이스 성능 모니터링:

- `mysql_global_status_connections`: 총 커넥션 수
- `mysql_global_status_threads_running`: 실행 중인 쿼리 스레드
- `mysql_global_status_slow_queries`: Slow Query 발생 수
- `mysql_global_status_questions`: 총 쿼리 실행 수

**Grafana 대시보드 구성**

**패널 레이아웃** (4개 섹션):

**1. Overview 섹션**
- Peak RPS (숫자 패널)
- 평균 응답 시간 (게이지)
- 성공률 (게이지)
- 에러율 (게이지)

**2. Tomcat 섹션**
- 현재 커넥션 수 (시계열 그래프)
- 스레드 사용률 (시계열 그래프, busy/current 비율)
- Keep-Alive 커넥션 (시계열 그래프)

**3. HikariCP 섹션**
- 커넥션 상태 (스택 영역 그래프: active + idle + pending)
- 커넥션 획득 시간 (시계열 그래프)
- Pending 커넥션 (시계열 그래프, 빨간색 강조)
- 타임아웃 발생 수 (카운터)

**4. Application 섹션**
- 응답 시간 분포 (히트맵)
- RPS (시계열 그래프)
- 성공/실패 요청 수 (스택 영역 그래프)
- 엔드포인트별 응답 시간 (테이블)

**Prometheus 설정**

**application.yml**:
```yaml
management:
  endpoints:
    web:
      exposure:
        include: prometheus, health, metrics
  metrics:
    export:
      prometheus:
        enabled: true
    tags:
      application: todoktodok
      environment: production
```

**prometheus.yml**:
```yaml
scrape_configs:
  - job_name: 'spring-boot'
    metrics_path: '/actuator/prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:8080']
```

**Loki 연동 (로그 기반 모니터링)**

메트릭만으로 파악하기 어려운 상황을 로그로 보완:

**연동 사례**:
- HikariCP pending > 5 발생 시 → Loki에서 해당 시점 SQL 로그 조회
- Tomcat 스레드 포화 시 → Loki에서 처리 중이던 요청 URI 확인
- 응답 시간 급증 시 → Loki에서 Slow Query Log 확인

**Grafana Explore 기능 활용**:
```
{app="todoktodok"} |= "HikariCP" |= "connection timeout"
```

**알림 설정**

Grafana Alerting으로 실시간 알림:

```yaml
alerts:
  - alert: HighHikariCPPending
    expr: hikaricp_connections_pending > 5
    for: 1m
    annotations:
      summary: "HikariCP 커넥션 대기 중"
      description: "Pending 커넥션이 5개 이상입니다"
    
  - alert: HighThreadUsage
    expr: (tomcat_threads_busy_threads / tomcat_threads_current_threads) > 0.8
    for: 2m
    annotations:
      summary: "Tomcat 스레드 사용률 높음"
```

**최적화 과정에서의 활용**

**Before (threads.max=200, maxPoolSize=10)**:
- busy_threads: 150-180 (거의 포화)
- pending: 5-15 (지속적 발생)
- 평균 응답 시간: 500ms
- Peak RPS: 80-100

**After (threads.max=3, maxPoolSize=10)**:
- busy_threads: 2-3 (안정적)
- pending: 0 (경합 해소)
- 평균 응답 시간: 200ms
- Peak RPS: 150+

**교훈**

1. **실시간 가시성**: 메트릭 없이는 병목 발견 불가능
2. **상관관계 분석**: 여러 메트릭을 함께 보며 원인 파악 (pending ↑ → 응답시간 ↑)
3. **임계값 기반 알림**: 문제를 사전에 감지하고 대응
4. **메트릭 + 로그 조합**: 정량적 데이터와 정성적 컨텍스트 결합
5. **지속적 모니터링**: 최적화 후에도 계속 추적하여 회귀 방지

이러한 포괄적인 모니터링 체계를 통해 시스템의 모든 레이어를 실시간으로 추적하고, 데이터 기반으로 최적화 의사결정을 내릴 수 있었습니다.
