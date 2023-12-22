## 🌈 RULE
+ 특정 권한들을 하나의 세트처럼 묶는 것
```sql
CREATE ROLE 룰명;
GRANT 권한 TO 룰명;
GRANT 룰명 TO 사용자명;

CREATE ROLE CREATE_R;
GRANT CREATE SESSION, CREATE USER, CREATE TABLE TO CREATE_R;
GRANT CREATE_R TO USER1;

```