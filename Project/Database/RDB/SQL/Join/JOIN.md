---
title: JOIN
date: 2023-12-27 20:17
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

## 🌈 JOIN
- 두 개 이상의 TABLE을 하나로 합쳐서 결과를 조회
- **ORCALE 전용 구문** / **STANDARD(=ANSI, 표준) 구문** 2가지가 있다.

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
  JOIN JOB J USING(JOB_CODE); -- *USING*사용 시 해당 *COLUMN*명에 *Alias*사용 *불가*
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

---

## 🌈 OUTER JOIN
+ JOIN 조건에 만족하지 않는 데이터들도 출력

### 📌 LEFT OUTER JOIN

- JOIN에 사용한 두 TABLE 중 왼편에 표기된 TABLE의 ROW수를 기준으로 JOIN
- 왼쪽에 표기된 테이블의 데이터는 무조건 출력

#### 🧶 STANDARD(ANSI)

```sql
SELECT E.EMP_NAME, D.DEPT_TITLE
  FROM EMPLOYEE E
  --LEFT OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
	--LEFT OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID) AND DEPT_CODE IN (1,2);
 //모든 CODE에 대해 출력은 하나 JOIN 대상 데이터가 제한되어 1,2 빼고는 NULL로 출력
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
```

#### 🧶 ORACLE

- ROW의 확장이 필요한 COLUMN에 (+)를 활용한다.

```sql
SELECT E.EMP_NAME, D.DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPT_CODE = D.DEPT_ID(+);
```

### 📌 RIGHT OUTER JOIN

- JOIN에 사용한 두 TABLE 중 오른편에 기술한 TABLE의 ROW 수를 기준으로 JOIN
- 오른쪽에 표기된 테이블의 데이터는 무조건 출력

#### 🧶 STANDARD(ANSI)

```sql
SELECT E.EMP_NAME, D.DEPT_TITLE
  FROM EMPLOYEE E
  --RIGHT OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
  RIGHT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
```

#### 🧶 ORACLE

```sql
SELECT E.EMP_NAME, D.DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPT_CODE(+) = D.DEPT_ID;
```

### 📌 FULL OUTER JOIN

- 합치기에 사용한 두 TABLE 이 가진 모든 ROW를 결과에 포함하여 JOIN(**= 두 TABLE 의 합집합**)

#### 🧶 STANDARD(ANSI)

```sql
SELECT E.EMP_NAME, D.DEPT_TITLE
  FROM EMPLOYEE E
  --FULL OUTER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
  FULL JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
```

#### 🧶 ORACLE
> ORACLE은 FULL OUTER JOIN이 안된다!
{: .prompt-warning }

---
## 🌈 NATURAL JOIN
- A TABLE과 B TABLE에서 같은 이름을 가진 COLUMN들이 모두 동일한 DATA를 가지고 있을 경우 JOIN되는 방식
- SQL Server(MSSQL)에서는 지원하지 않는다.

```sql
SELECT *
  FROM IZONE A
NATURAL JOIN IVE B;
```

- ORALCE에서는 USING을 이용하여 원하는 COLUMN만 JOIN에 사용 가능

```sql
SELECT*
  FROM IZONE A
NATURAL JOIN IVE B;
USING(NAME, COM) -- *Alias*나 *TABLE*명을 붙이면 안됨!
```

## 🌈 CROSS JOIN
- 조합할 수 있는 모든 경우를 출력
- = Cartesian Product(카테이션 곱)

```sql
SELECT E.EMP_NAME, D.DEPT_TITLE
  FROM EMPLOYEE E
 CROSS JOIN DEPARTMENT D;
```

- 별도의 JOIN 조건이 없을 경우 CROSS JOIN

```sql
SELECT A.COL1, B.COL3
  FROM SAMPLE1 A, SAMPLE2 B
 WHERE B.COL3 % 5 = 0;
```