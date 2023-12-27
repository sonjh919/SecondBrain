---
title: 다중 JOIN
date: 2023-12-27 20:45
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

## 🌈 다중 JOIN
- 여러 개의 TABLE을 조회

#### 🧶 STANDARD(ANSI)
+ **JOIN의 순서가 중요하다 (별칭 참조가 가능한 순서로!!)**
	**A-B B-C C-D ...**

```sql
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM DEPARTMENT D
  JOIN EMPLOYEE E ON(D.DEPT_ID = E.DEPT_CODE)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN LOCATION L ON(L.LOCAL_CODE = D.LOCATION_ID)
```

#### 🧶 ORACLE
+ **JOIN의 순서는 중요하지 않다!!**
	**A-B A-C B-D 등등…**

```sql
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME
  FROM DEPARTMENT D, EMPLOYEE E, JOB J, LOCATION L
 WHERE J.JOB_NAME = '대리'
   AND L.LOCAL_CODE = D.LOCATION_ID
   AND D.DEPT_ID = E.DEPT_CODE
   AND E.JOB_CODE = J.JOB_CODE;
```