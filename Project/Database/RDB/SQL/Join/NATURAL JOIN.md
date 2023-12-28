---
title: NATURAL JOIN
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
USING(NAME, COM) -- Alias나 TABLE명을 붙이면 안됨!
```
