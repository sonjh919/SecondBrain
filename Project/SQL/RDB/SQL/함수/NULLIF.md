## 🌈 NULLIF

- 두 인수가 같으면 NULL 반환, 다르면 인수1 반환

```sql
SELECT NULLIF(SCORE, 0) FROM EMPLOYEE; // SCORE=0 -> NULL, SCORE!=0 -> SCORE값
```