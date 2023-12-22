## 🌈 TRUNC

- 버림하여 반환
```sql
SELECT TRUNC(123.456) FROM DUAL; -- *Default* : 0 // 123
SELECT TRUNC(123.456, 1) FROM DUAL; // 123.4
SELECT TRUNC(123.456, -1) FROM DUAL; // 120
```