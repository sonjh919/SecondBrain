---
title: CROSS JOIN
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
