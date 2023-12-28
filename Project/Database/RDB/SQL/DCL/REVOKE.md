---
title: REVOKE
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

## 🌈 REVOKE
+ 사용자에게 권한 회수

```sql
REVOKE '권한' FROM '사용자명';

--사용자의 권한과 연결된 상대의 권한을 전부 취소--
REVOKE '권한' ON '테이블명' FROM '사용자명' CASCADE; 
```