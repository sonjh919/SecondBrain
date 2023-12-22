## 🌈 ROUND

- 반올림하여 반환
```sql
SELECT ROUND(123.456) FROM DUAL; -- *Default* : 0 // 123
SELECT ROUND(123.456, 1) FROM DUAL; // 123.5
SELECT ROUND(123.456, -1) FROM DUAL; // 120
```