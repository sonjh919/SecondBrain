---
title: SubQuery
date: 2023-12-27 20:50
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

## Subquery
- QUERY문 안에 작성한 QUERY문(질의문)
- 조금 더 목적에 가까운 Query를 Main Query로 설정
- **Sub Query**에 주로 **조건문**이 들어간다.
- Sub Query는 [[GROUP BY]]를 제외한 모든 절에서 사용할 수 있다.

|절|서브쿼리의 종류|
|---|---|
|SELECT|스칼라 서브쿼리 (Scalar Subquery)|
|FROM|인라인 뷰 (Inline View)|
|WHERE, HAVING|중첩 서브쿼리 (Nested Subquery)|

### Scalar Subquery
- 대부분의 위치에서 사용 가능
- COLUMN 대신 사용되므로 반드시 하나의 값만을 반환하지 않으면 에러 발생

```sql
SELECT Z.MEMBER_CODE
     , (SELECT V.MEMBER_CODE FROM IVE V WHERE Z.MEMBER_CODE=V.MEMBER_CODE)
FROM IZONE Z;
```


### Inline View
- FROM 절에서 사용
- TABLE명이 올 수 있는 위치에 사용 가능하다.
- **바깥 테이블의 [[Alias]]를 참조할 수 없다!**

```sql
SELECT MEMEBR_CODE
  FROM (SELECT MEMBER_CODE, MEMBER_NAME FROM IVE) I;
```


### Nested Subquery
#### Mainquery와의 관계에 따른 분류
|비연관 서브쿼리(Uncorrelated Subquery)|Subquery에 Mainquery의 COLUMN이 존재하지 않음|
|---|---|
|연관 서브쿼리(Correlated Subquery)|Subquery에 Mainquery의 COLUMN이 존재함|

#### 반환하는 DATA 형태에 따른 분류
|단일 행 서브쿼리(Single Row Subquery)|Subquery가 1건 이하의 데이터를 반환|
|---|---|
|다중 행 서브쿼리(Multi Row Subquery)|Subquery가 여러 건의 데이터를 반환|
|다중 컬럼 서브쿼리(Multi Column Subquery)|Subquery가 여러 COLUMN의 데이터를 반환|
