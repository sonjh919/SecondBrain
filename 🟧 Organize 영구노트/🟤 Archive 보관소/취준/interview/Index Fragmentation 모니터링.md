[](OPTIMIZE%20TABLE%20실행%20전략.md)### Question
Index Fragmentation을 모니터링하고 재구성하는 과정에서, 구체적으로 어떤 지표를 확인했고 어떤 기준으로 재구성 시점을 결정하셨나요?

### Answer
10%이상이어야 효과가 있다고 해서 그렇게 설정했고, 지표는 data_free와 data_length, index_length 지표를 참고하였습니다.

### Feedback
**예상 베스트 답변**: MySQL의 INFORMATION_SCHEMA.TABLES에서 data_free, data_length, index_length를 조회하여 Fragmentation Rate를 계산했습니다. 구체적으로 `(data_free / (data_length + index_length)) * 100` 공식을 사용했고, 일반적으로 10% 이상일 때 재구성 효과가 있다고 알려져 있어 해당 기준을 채택했습니다. 재구성은 OPTIMIZE TABLE 명령을 사용했으며, 서비스 영향을 최소화하기 위해 트래픽이 적은 새벽 시간대에 스케줄러로 자동 실행하거나, Online DDL 방식으로 테이블을 잠그지 않고 진행했습니다. 특히 대용량 테이블의 경우 pt-online-schema-change 같은 도구를 고려할 수 있습니다.

**현재 답변 평가**: 핵심 지표(data_free, data_length, index_length)를 정확히 파악하고 계셨고, 10% 기준도 적절합니다. 다만 실제로 Fragmentation Rate를 어떤 계산식으로 산출했는지, 그리고 재구성 작업(OPTIMIZE TABLE 등)을 실행할 때 서비스 중단을 방지하기 위한 구체적인 전략(실행 시간대, Online DDL 여부 등)이 추가되면 더 완성도 높은 답변이 됩니다.

**추천사항**: "10% 이상이어야 효과가 있다"는 것이 경험적 기준인지, 벤치마크 결과인지 구체적으로 언급하면 좋습니다. 또한 Slack 알림 시스템을 구축하셨다고 하셨으니, 알림 발생 후 실제 조치(수동 재구성 vs 자동 재구성)를 어떻게 처리했는지도 설명하시면 운영 경험을 더 잘 보여줄 수 있습니다.

### Recommendation
Index Fragmentation 모니터링은 데이터베이스 성능 유지를 위한 핵심 운영 작업입니다. 

**모니터링 지표**로는 MySQL의 `INFORMATION_SCHEMA.TABLES`에서 제공하는 세 가지 주요 메트릭을 활용했습니다:
- `data_free`: 삭제되거나 업데이트로 인해 비어있는 공간
- `data_length`: 실제 데이터가 차지하는 공간
- `index_length`: 인덱스가 차지하는 공간

**Fragmentation Rate 계산식**은 다음과 같습니다:
```
Fragmentation Rate = (data_free / (data_length + index_length)) × 100
```

**10% 기준 설정 근거**는 MySQL 공식 문서와 DBA 커뮤니티의 경험적 기준을 참고했습니다. 일반적으로 10% 미만의 Fragmentation은 재구성 오버헤드 대비 성능 개선 효과가 미미하지만, 10% 이상부터는 쿼리 성능 저하가 체감되며 재구성 효과가 명확히 나타납니다.

**모니터링 자동화**를 위해 Spring Scheduler를 활용하여 매일 새벽 2시에 배치 작업을 실행했습니다. 다음과 같은 쿼리로 Fragmentation Rate를 조회합니다:

```sql
SELECT 
    table_name,
    data_free,
    data_length,
    index_length,
    ROUND((data_free / (data_length + index_length)) * 100, 2) as fragmentation_rate
FROM information_schema.TABLES
WHERE table_schema = 'todoktodok'
  AND data_free > 0
HAVING fragmentation_rate >= 10
ORDER BY fragmentation_rate DESC;
```

**Slack 알림 시스템**은 10% 이상 Fragmentation이 감지된 테이블을 WARN 레벨로 로깅하여, 개발팀이 즉시 상황을 인지할 수 있도록 구성했습니다.

**재구성 전략**은 서비스 영향을 최소화하는 것이 핵심입니다:
1. **실행 시간대**: 트래픽이 가장 적은 새벽 3-5시 사이에 수행
2. **Online DDL 활용**: MySQL 5.6 이상에서는 `ALGORITHM=INPLACE`를 사용하여 테이블 잠금 없이 재구성 가능
3. **대용량 테이블 대응**: 수백만 건 이상의 데이터가 있는 경우 `pt-online-schema-change` 도구를 활용하여 청크 단위로 점진적 재구성
4. **모니터링**: Grafana로 재구성 전후 쿼리 응답 시간과 디스크 I/O를 추적하여 개선 효과 검증

이러한 체계적인 모니터링과 재구성 프로세스를 통해 Full-Text Index의 성능을 지속적으로 최적 상태로 유지할 수 있었습니다.
