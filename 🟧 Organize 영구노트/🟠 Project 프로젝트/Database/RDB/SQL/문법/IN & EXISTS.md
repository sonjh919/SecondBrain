---
title: IN & EXISTS
date: 2023-12-28 10:17
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

## IN
+  IN 구문에 **입력된 값들 중에서 하나라도 일치하는 것이 있으면 조회**된다.
+ [[SubQuery]]를 넣을 수 있다.
+ Null과의 값 비교는 불가능하다. 
+ NULL ROW가 있을 때 NOT IN 조회시 FALSE를 반환한다.
+ 실제 존재하는 데이터들의 모든 값까지 확인한다.
+ 즉, **조건에 맞는 데이터도 NULL이 존재하면 선택하지 않는다.**

```sql
SELECT employee_name, department 
  FROM employees
 WHERE department IN ('Engineering', 'Marketing');

```

## EXISTS
+ ROW가 존재하는지만 체크하고 더 이상 수행되지 않으므로 **IN보다 성능이 좋다.**
+  NULL ROW가 있을 때 NOT EXISTS 조회시 TRUE값을 반환한다.

```sql
SELECT product_name
FROM products AS p
WHERE EXISTS (
    SELECT 1
    FROM inventory AS i
    WHERE i.product_id = p.product_id
    AND i.quantity > 0
);

```