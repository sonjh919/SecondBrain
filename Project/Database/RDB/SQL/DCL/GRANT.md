---
title: GRANT
date: 2023-12-22 14:41
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

## GRANT
+ 사용자에게 권한 부여
```sql
GRANT '권한' TO '사용자명';
GRANT '권한' ON '테이블명' TO '사용자명';
GRANT '권한' ANY TABLE TO '사용자명';
GRANT '권한' TO '사용자명' WITH GRANT OPTION;
--자신이 부여받은 권한에 대해 다른 계정의 사용자에게 권한 부여 가능--
```