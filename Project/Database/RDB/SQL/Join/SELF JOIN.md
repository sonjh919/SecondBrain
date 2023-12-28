---
title: SELF JOIN
date: 2023-12-28 10:05
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

## 🌈 SELF JOIN
- 같은 TABLE을 JOIN
+ 같은 TABLE을 JOIN하기 때문에 반드시 [[Alias]]을 붙여 모든 COLUMN에 적용한다!

#### 🧶 STANDARD(ANSI)

```sql
SELECT
        E1.EMP_ID
      , E1.EMP_NAME '사원명'
      , E1.DEPT_CODE
      , E1.MANAGER_ID
      , E2.EMP_NAME '관리자이름'
   FROM EMPLOYEE E1
   JOIN EMPLOYEE E2
     ON (E1.MANAGER_ID = E2.EMP_ID);
```

#### 🧶 ORACLE

```sql
SELECT
        E1.EMP_ID
      , E1.EMP_NAME
      , E1.DEPT_CODE
      , E1.MANAGER_ID
      , E2.EMP_NAME '관리자이름'
   FROM EMPLOYEE E1
      , EMPLOYEE E2
  WHERE E1.MANAGER_ID = E2.EMP_ID;
```