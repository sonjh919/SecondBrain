---
title: OVER
date: 2023-12-22 19:47
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

## OVER
+ 윈도우 함수는 OVER 키워드와 함께 사용할 수 있다.

- 각 행별로 특정 기준에 따라 필요한 집합을 구해 함수를 적용하고 싶을 때 쓰는 구문
- 그룹 짓기보다는 행의 범위를 지정해주는 의미
- 행 집합을 정의하는 기준으로 ORDER BY 와 PARTITION BY 사용

```sql
--ORDER BY : 자신과 상위에 위치한 행들을 집합에 포함 -> 누적값에 활용--
SELECT '번호', '날짜', '수량'
     , SUM('수량') OVER(ORDER BY '날짜') AS '재고'
FROM '창고'

--PARTITION BY : 해당 COLUMN값 기준으로 행 집합 나누기--
SELECT '번호', '날짜', '수량'
     , SUM('수량') OVER(PARTITION BY '물품' ORDER BY '날짜') AS '재고' --A, B 따로!!--
FROM '창고' ORDER BY '날짜'
```
