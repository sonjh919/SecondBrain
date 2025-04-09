---
title: HAVING
date: 2023-12-22 17:13
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

## HAVING
- [[GROUP BY]]에 대한 조건을 설정하는 절

- **SELECT는 WHERE에서, GROUP BY는 HAVING에서!!**

```sql
SELECT DISTINCT PRODUCT_CODE,
       COUNT(ORDER_CNT) AS CNT
  FROM ORDER_PRODUCT
 WHERE ORDER_DATE BETWEEN '20210701' AND '20210731'
 GROUP BY PRODUCT_CODE
HAVING COUNT(ORDER_CNT) >= 1000;
```