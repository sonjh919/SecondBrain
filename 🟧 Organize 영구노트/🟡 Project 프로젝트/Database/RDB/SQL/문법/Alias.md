---
title: Alias
date: 2023-12-22 15:00
categories:
  - DataBase
  - SQL
tags:
  - DataBase
  - RDB
  - SQL
image: 
path:
---
#DataBase #RDB #SQL 

## Alias(별칭)

**AS + 별칭**으로 사용한다.

- 숫자, 특수문자 등으로 끝날 때에는 별칭을 “”로 묶어준다.
- AS 키워드는 **생략 가능**하다.
- **[[🟡 Area/Database/RDB/SQL/DML/SELECT]]에서 설정한 Alias를 [[FROM]]에서 사용할 수 없다.**

```sql
SELECT
       EMP_NAME AS '이름'
     , SALARY * 12 "1년급여"
     , (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "총소득(원)"
  FROM EMPLOYEE;
```

- 테이블명에 Alias를 설정할 경우 **테이블명 대신 Alias를 사용**해야 한다.
- 테이블명에 AS 키워드는 쓸 수 없다.

```sql
SELECT
       E.EMP_ID AS ID
 FROM EMPLOYEE E;
```