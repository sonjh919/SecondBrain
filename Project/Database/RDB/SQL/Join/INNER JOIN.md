---
title: INNER JOIN
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

## 🌈 Inner JOIN
+ JOIN 조건에 충족하는 데이터만 출력

### 📌 EQUI JOIN
- EQUAL(=)를 조건으로 JOIN

#### 🧶 STANDARD(ANSI)

- ON을 사용하나, 두 COLUMN명이 같을 경우 USING도 사용 가능하다.

```sql
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, D.DEPT_TITLE
  FROM EMPLOYEE E
--INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_CODE); --생략가능 
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_CODE);
```

```sql
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, D.DEPT_TITLE
  FROM EMPLOYEE E
  JOIN JOB J USING(JOB_CODE); -- USING사용 시 해당 COLUMN명에 Alias사용 불가
```

#### 🧶 ORACLE

```sql
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, J.JOB_NAME
  FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE;
```

### 📌 Non EQUI JOIN
- EQUAL(=)이 아닌 다른 조건(BETWEEN, >, <)으로 JOIN
- **설계상의 이유로 수행이 불가능한 경우도 존재**

#### 🧶 STANDARD(ANSI)

```sql
SELECT E.EMP_NAME, E.SALARY, E.SAL_LEVEL, S.SAL_LEVEL
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL); --범위
```

#### 🧶 ORACLE

```sql
SELECT E.EMP_NAME, E.SALARY, E.SAL_LEVEL, S.SAL_LEVEL
  FROM EMPLOYEE E, SAL_GRADE S
 WHERE E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
```
