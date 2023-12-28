---
title: OUTER JOIN
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
 --모든 CODE에 대해 출력은 하나 JOIN 대상 데이터가 제한되어 1,2 빼고는 NULL로 출력--
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
