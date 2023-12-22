## 🌈 TRUNCATE TABLE

- 테이블 비우기(**테이블 유지**, 행만 삭제)
- 디스크 사용량도 초기화
- AUTO [[COMMIT]]

```sql
TRUNCATE TABLE 테이블명;
```

💡 DROP과 TRUNCATE는 로그를 남기지 않음. DELETE는 남김.
