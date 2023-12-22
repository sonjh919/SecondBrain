
## 🌈 GROUP BY
+ 특정 COLUMN에 대하여 같은 값을 가지고 있는 ROW들을 GROUP으로 묶는다.
+ [[집계 함수]]를 사용하여 반환값을 설정할 수 있다.
+ 조건을 설정하려면 [[HAVING]]과 같이 쓰인다.

```sql
SELECT DISTINCT PRODUCT_CODE,
       COUNT(ORDER_CNT) AS CNT
  FROM ORDER_PRODUCT
 WHERE ORDER_DATE BETWEEN '20210701' AND '20210731'
 GROUP BY PRODUCT_CODE
HAVING COUNT(ORDER_CNT) >= 1000;
```