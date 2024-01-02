---
title: 계층 Query
date: 2023-12-28 10:09
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

## 계층 구조
- 트리 형태의 구조

## 계층 Query
- 테이블에 계층 구조를 이루는 COLUMN이 존재할 경우 쿼리를 이용하여 데이터를 출력 가능

|명칭|설명|
|---|---|
|LEVEL|각 계층|
|NODE|각 데이터|
|ROOT|가장 첫번째 노드|
|PARENT NODE|노드의 상위노드|
|CHILD NODE|노드의 자식노드|
|LEAT|가장 아래 노드|


### LEVEL
- 현재의 DEPTH 반환(ROOT NODE = 1)

### SYS_CONNECT_BY_PATH(컬럼, 구분자)
- ROOT 노드부터 현재 노드까지의 경로 출력

### START WITH
- 계층의 ROOT로 사용될 ROW를 지정
- **결과 목록에 항상 포함됨**
- [[Subquery]] 사용가능

### CONNECT BY
- 조건에 만족하는 데이터가 없을 때까지 ROOT로부터 자식 노드를 생성
- =기준으로 앞뒤 JOIN

|PRIOR 자식 = 부모|순방향| |이전에 읽은 자식과 지금 부모 JOIN|
|---|---|---|---|
|PRIOR 부모 = 자식|역방향|같은 LEVEL 출력 안됨||

### PRIOR
- 바로 앞에 있는 부모 노드의 값을 반환
- ||를 이용해 문자열이나 COLUMN을 합칠 수 있다.
```sql
SELECT LEVEL
     , SYS_CONNECT_BY_PATH('['||CATEGORY_TYPE||']' CATEGORY_NAME, '-' AS PATH
  FROM CATEGORY
 START WITH PARRENT_CATEGORY IS NULL
CONNECT BY PRIOR CATEGORY_NAME = PARENT_CATEGORY;
```


### NOCYCLE
- 사이클이 발생(동일한 데이터가 전개중에 나타나는 경우)할 시 그 이후의 데이터는 전개 하지 않는다(원래대로라면 런타임 오류 발생)

### CONNECT_BY_ROOT COLUMN
- ROOT 노드의 주어진 COLUMN값 반환

### CONNECT_BY_ISLEAF
- 가장 하위 노드이면 1 반환, 그 외에는 0 반환
```sql
SELECT LEVEL
     , CONNECT_BY_ROOT CATEGORY_NAME AS ROOT_INFO
     , CONNECT_BY_ISLEAF AS LEAF_INFO
  FROM CATEGORY
```

### ORDER SIBLINGS BY
- 계층 내에서 형제들끼리(같은 LEVEL) 정렬하기
```sql
SELECT LEVEL
     , CONNECT_BY_ROOT CATEGORY_NAME AS ROOT_INFO
     , CONNECT_BY_ISLEAF AS LEAF_INFO
  FROM CATEGORY
 ORDER SIBLINGS BY NAME;
```