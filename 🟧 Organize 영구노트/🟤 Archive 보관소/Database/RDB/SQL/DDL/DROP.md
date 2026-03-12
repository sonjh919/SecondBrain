---
title: DROP
date: 2023-12-22 12:20
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

## DROP TABLE

- **테이블까지 제거**한다.
- [[참조 동작]]을 통해 옵션을 지정할 수 있다.
- AUTO [[🟡 Area/Database/RDB/SQL/TCL/COMMIT|COMMIT]]

```sql
DROP TABLE '테이블명' [CASCADE CONSTRAINT];
```

## 사용자 삭제
```sql
DROP USER '사용자명';
```