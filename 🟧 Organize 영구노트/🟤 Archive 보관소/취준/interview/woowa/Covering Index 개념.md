[](쿼리%20분리와%20복합%20인덱스%20설계.md)### Question
Covering Index가 무엇인가요?

### Answer
인덱스로 설정한 컬럼만 읽어 불필요한 디스크 i/o를 없애 조회 시간을 단축시킬 수 있는 인덱스를 말합니다.

### Feedback
Covering Index의 핵심 개념인 "인덱스만으로 쿼리 처리"와 "디스크 I/O 감소"를 정확하게 설명하셨습니다. 다만, 일반 인덱스와의 차이점(테이블 접근 여부), 그리고 MySQL에서 EXPLAIN 결과의 Extra 컬럼에 "Using index"가 표시되는 것으로 확인할 수 있다는 점을 추가로 언급하면 더욱 완성도 높은 답변이 될 것입니다.

### Recommendation
Covering Index는 쿼리에서 필요로 하는 모든 컬럼이 인덱스에 포함되어 있어, 인덱스만 읽어도 쿼리 결과를 완성할 수 있는 상태를 말합니다.

일반적으로 인덱스는 검색 조건(WHERE 절)에 사용되는 컬럼만 포함하고, 실제 데이터를 가져오기 위해서는 인덱스에서 찾은 레코드의 주소를 통해 테이블에 다시 접근하는 "테이블 랜덤 액세스"가 발생합니다. 이 과정은 디스크 I/O를 추가로 발생시켜 성능 저하의 원인이 됩니다.

반면 Covering Index는 SELECT 절의 컬럼, WHERE 절의 조건 컬럼, ORDER BY/GROUP BY 등 쿼리에서 사용하는 모든 컬럼이 인덱스에 포함되어 있습니다. 따라서 데이터베이스는 인덱스만 스캔하면 되고, 테이블에 접근할 필요가 없어집니다. 이를 통해 불필요한 디스크 I/O가 제거되어 조회 성능이 크게 향상됩니다.

MySQL에서는 EXPLAIN 명령어로 쿼리 실행 계획을 확인할 때, Extra 컬럼에 **"Using index"**가 표시되면 해당 쿼리가 Covering Index를 사용하고 있다는 것을 의미합니다. 이는 인덱스만으로 쿼리가 처리되었다는 최적화의 증거입니다.

예를 들어, 다음과 같은 쿼리가 있다고 가정합니다:
```sql
SELECT user_id, created_at FROM posts WHERE status = 'published' ORDER BY created_at;
```

만약 `(status, created_at, user_id)` 형태의 복합 인덱스가 존재한다면, 쿼리에서 필요한 모든 컬럼(status, created_at, user_id)이 인덱스에 포함되어 있으므로 Covering Index가 됩니다. 데이터베이스는 인덱스만 읽어서 결과를 반환할 수 있어, posts 테이블에 접근하지 않아도 되므로 성능이 크게 향상됩니다.
