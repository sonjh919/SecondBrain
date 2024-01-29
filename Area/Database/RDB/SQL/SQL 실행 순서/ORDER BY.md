---
title: ORDER BY
date: 2023-12-22 17:20
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

## ORDER BY

- **ASC** : 오름차순 (Default)
+ **DESC** : 내림차순 
- ORACLE의 경우 NULL은 최댓값, SQL Server는 최솟값
- SELECT절에 기술되지 않은 COLUMN도 사용 가능!(단, FROM에 명시된 테이블내에 있어야함)
- COLUMN명 대신 [[Alias]]나 컬럼순서를 나타내는 정수도 사용 가능(혼용사용도 가능)

```sql
SELECT NAME FROM MEMEBR ORDER BY NAME;
SELECT NAME FROM MEMEBR ORDER BY NAME DESC;

SELECT GRADE, NAME FROM MEMEBR ORDER BY GRADE, NAME; -- GRADE 정렬하고 같은 GRADE 안에서 NAME 정렬
SELECT GRADE, NAME FROM MEMEBR ORDER BY GRADE DESC, NAME;
SELECT GRADE, NAME FROM MEMEBR ORDER BY GRADE DESC, NAME DESC;

SELECT * FROM MEMBER ORDER BY 1,2,3; -- 테이블의 1,2,3번째 컬럼을 기준으로 정렬
SELECT MEMBER AS M FROM IVE I ORDER BY M
```