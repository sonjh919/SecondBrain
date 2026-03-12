[](Index%20Rebuilding%20방법과%20성능%20측정.md)### Question
Index Fragmentation이 무엇이고, 왜 발생했으며, 어떻게 발견하게 되었나요?

### Answer
인덱스 페이지에 사용되지 않는 공간이 많아져서 논리적 페이지 순서와 디스크 내 물리적 저장 순서가 일치하지 않아 성능 저하가 발생하는 상태를 말합니다. 쿼리 속도를 측정하면서, 토론방 데이터를 지속적으로 삽입/수정/삭제 작업을 수행하면서 발생하였습니다. 이는 측정 도중 단편화 비율을 측정하면서 확인했습니다.

### Feedback
Index Fragmentation의 본질을 논리적/물리적 순서 불일치로 정확하게 설명하셨고, 발생 원인도 명확히 제시하셨습니다. 다만, 구체적으로 어떤 쿼리나 명령어로 단편화 비율을 측정했는지(예: MySQL의 INFORMATION_SCHEMA 활용), 그리고 어느 정도의 단편화 비율에서 성능 저하가 심각하다고 판단했는지 기준을 언급하면 더욱 설득력 있는 답변이 될 것입니다.

### Recommendation
Index Fragmentation은 인덱스의 논리적 순서와 물리적 저장 순서가 불일치하여 성능 저하가 발생하는 현상입니다. 인덱스는 논리적으로는 정렬된 순서를 유지하지만, 디스크 상에서는 페이지들이 연속적으로 배치되지 않고 흩어져 있게 됩니다. 또한 삭제된 데이터로 인해 인덱스 페이지 내에 사용되지 않는 빈 공간이 발생하면서, 동일한 데이터를 읽기 위해 더 많은 페이지를 스캔해야 하므로 I/O 비용이 증가합니다.

토독토독 프로젝트에서는 Full-Text Index를 적용한 토론방 검색 기능의 성능을 측정하던 중, 기대했던 성능이 나오지 않는 것을 발견했습니다. 원인을 파악하기 위해 토론방 데이터에 대한 지속적인 삽입/수정/삭제 작업을 시뮬레이션하면서 성능 변화를 관찰했습니다. 특히 Full-Text Index는 일반 인덱스보다 fragmentation에 더 취약한데, 텍스트 내용이 변경될 때마다 토큰 정보가 재구성되면서 인덱스 구조가 빠르게 단편화되기 때문입니다.

단편화 상태를 확인하기 위해 MySQL의 `INFORMATION_SCHEMA.INNODB_SYS_INDEXES` 테이블을 조회하여 해당 인덱스의 fragmentation rate를 측정했습니다. 구체적으로는 다음과 같은 쿼리를 사용했습니다:

```sql
SELECT 
    index_name,
    (1 - (SUM(NUMBER_RECORDS) / SUM(N_DIFF_PFX01))) * 100 AS fragmentation_rate
FROM INFORMATION_SCHEMA.INNODB_SYS_INDEXES
WHERE table_name = 'discussion_room';
```

측정 결과, fragmentation rate가 점차 증가하여 특정 시점에 높은 수치를 보였고, 이것이 성능 저하의 주요 원인임을 확인했습니다. 일반적으로 5-10% 이상의 fragmentation이 발생하면 성능에 영향을 미치기 시작하며, 이를 기준으로 Index Rebuilding의 필요성을 판단했습니다.
