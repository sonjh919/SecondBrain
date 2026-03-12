---
title: CASE
date: 2023-12-22 15:31
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

## CASE
+ 주로 [[🟡 Area/Database/RDB/SQL/DML/SELECT]]에서 사용되며, SELECT 시 필터를 걸기 위해 사용한다.

```sql
CASE
    WHEN '조건식' THEN '결과값'
    WHEN '조건식' THEN '결과값'
 END
```

```sql
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , CASE
         WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
         WHEN JOB_CODE = 'J6' THEN SALARY * 1.15
         WHEN JOB_CODE = 'J5' THEN SALARY * 1.2 
         --JOB_CODE를 CASE 옆으로 묶을 수도 있다.--
         ELSE SALARY * 1.05
       END AS '인상급여'
  FROM EMPLOYEE;
```