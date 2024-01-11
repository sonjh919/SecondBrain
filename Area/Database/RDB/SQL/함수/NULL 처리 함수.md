---
title: NULL 처리 함수
date: 2023-12-22 17:01
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

## COALESCE
- NULL이 아닌 최초의 인수 반환
```sql
SELECT COALESCE(PHONE, EMAIL, FAX) FROM MEMBER;
```

## NULLIF
- 두 인수가 같으면 NULL 반환, 다르면 인수1 반환
```sql
SELECT NULLIF(SCORE, 0) FROM EMPLOYEE; 
--SCORE=0 -> NULL, SCORE!=0 -> SCORE값--
```

## NVL
- NULL일 경우 인수2 반환, 아닐경우 인수1 반환
```sql
SELECT NVL(SCORE, 0) FROM EMPLOYEE; 
--SCORE : NULL -> 0, SCORE : NOT NULL -> SCORE값--
```