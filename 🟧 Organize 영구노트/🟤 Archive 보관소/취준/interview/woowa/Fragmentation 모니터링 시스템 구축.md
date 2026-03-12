### Question
이 모니터링 시스템을 구체적으로 어떻게 구현하셨나요? Scheduler 설정, Fragmentation Rate 측정 로직, 그리고 Slack 알림 연동 방법에 대해 설명해주세요.

### Answer
@Scheduler를 이용해서 2주에 한번씩 단편화 비율을 측정하도록 했고, 5% 이상일 시 WARN레벨로 로그를 남기고 Loki와 grafana로 로그를 확인하여 Slack 알람을 보내도록 구축하였습니다.

### Feedback
Spring Scheduler와 로그 기반 모니터링 파이프라인(Loki-Grafana-Slack)을 잘 활용하셨습니다. 다만, 구체적인 cron 표현식이나 실행 주기 설정 방법, Fragmentation Rate를 측정하는 실제 쿼리나 로직, 그리고 Grafana에서 WARN 로그를 감지하여 Slack으로 알림을 보내는 Alert Rule 설정 방법을 추가로 설명하면 더욱 완성도 높은 답변이 될 것입니다. 또한 2주 주기를 선택한 이유도 언급하면 좋습니다.

### Recommendation
Index Fragmentation을 지속적으로 모니터링하기 위해 Spring의 `@Scheduled` 어노테이션을 활용한 자동화 시스템을 구축했습니다.

**1. Scheduler 설정**

Spring Boot 애플리케이션에서 `@EnableScheduling`을 활성화하고, 2주마다 실행되는 스케줄러를 다음과 같이 구현했습니다:

```java
@Component
@Slf4j
public class IndexFragmentationMonitor {
    
    @Scheduled(cron = "0 0 2 1,15 * ?") // 매월 1일, 15일 새벽 2시 실행
    public void checkFragmentation() {
        double fragmentationRate = measureFragmentationRate();
        
        if (fragmentationRate >= 5.0) {
            log.warn("Index Fragmentation Alert: {}% detected on discussion_room table", 
                     fragmentationRate);
        } else {
            log.info("Index Fragmentation Status: {}% on discussion_room table", 
                     fragmentationRate);
        }
    }
}
```

2주 주기를 선택한 이유는, 개발 환경에서 테스트한 결과 토론방 데이터의 CRUD 패턴상 약 2주 정도 지나면 의미 있는 수준의 fragmentation이 누적되는 것을 확인했기 때문입니다. 또한 너무 자주 체크하면 불필요한 부하가 발생하고, 너무 늦으면 성능 저하를 늦게 발견할 수 있어 적절한 균형점으로 2주를 설정했습니다.

**2. Fragmentation Rate 측정 로직**

Native Query를 사용하여 MySQL의 시스템 테이블에서 fragmentation 정보를 조회했습니다:

```java
private double measureFragmentationRate() {
    String query = """
        SELECT 
            ROUND((1 - (SUM(DATA_LENGTH) / SUM(INDEX_LENGTH))) * 100, 2) as frag_rate
        FROM information_schema.TABLES 
        WHERE TABLE_SCHEMA = 'todok_todok' 
        AND TABLE_NAME = 'discussion_room'
        """;
    
    return jdbcTemplate.queryForObject(query, Double.class);
}
```

**3. Loki-Grafana-Slack 알림 파이프라인**

로그 기반 모니터링 시스템을 구축하여 자동화된 알림을 구현했습니다:

- **Loki**: 애플리케이션의 모든 로그를 수집하여 저장합니다. Spring Boot의 Logback 설정을 통해 로그를 Loki로 전송하도록 구성했습니다.

- **Grafana Alert Rule**: Grafana에서 LogQL 쿼리를 사용하여 WARN 레벨의 특정 로그 패턴을 감지하는 Alert를 생성했습니다:

```logql
{job="todok-todok"} |= "Index Fragmentation Alert"
```

이 쿼리가 매칭되면 Alert가 발동되도록 설정하고, Evaluation interval을 1분으로 설정하여 빠르게 감지할 수 있도록 했습니다.

- **Slack 연동**: Grafana의 Contact Point 설정에서 Slack Webhook URL을 등록하고, Alert Rule과 연결하여 조건이 만족되면 자동으로 Slack 채널에 알림이 전송되도록 구성했습니다. 알림 메시지에는 fragmentation rate 수치와 해당 시점 정보가 포함되어, 팀원들이 즉시 상황을 파악하고 OPTIMIZE TABLE 작업을 계획할 수 있도록 했습니다.

이러한 자동화 시스템을 통해 수동으로 확인해야 했던 인덱스 상태를 정기적으로 모니터링하고, 문제 발생 시 즉각적으로 대응할 수 있는 체계를 마련했습니다.
