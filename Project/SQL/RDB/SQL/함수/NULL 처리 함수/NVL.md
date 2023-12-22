## 🌈 NVL

- NULL일 경우 인수2 반환, 아닐경우 인수1 반환

```sql
SELECT NVL(SCORE, 0) FROM EMPLOYEE; // SCORE : NULL -> 0, SCORE : NOT NULL -> SCORE값
```