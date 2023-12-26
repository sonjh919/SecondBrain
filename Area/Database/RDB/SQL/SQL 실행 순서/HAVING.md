---
tistoryBlogName: sonjh919
tistoryTitle: HAVING
tistoryVisibility: "3"
tistoryCategory: "1206897"
tistorySkipModal: true
tistoryPostId: "52"
tistoryPostUrl: https://sonjh919.tistory.com/52
---

## 🌈 HAVING
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