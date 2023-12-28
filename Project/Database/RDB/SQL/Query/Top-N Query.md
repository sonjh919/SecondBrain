---
title: Top-N Query
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

## 🌈 Top-N

- N위까지의 데이터를 추출하기 위한 Query

### 📌 ROWNUM

- 슈도 컬럼(Pseudo Column) : 실제로는 존재하지 않는 가짜 COLUMN
- ROW NUMBER를 COLUMN으로 추가
- **ROWNUM은 SELECT 실행시 부여됨 → WHERE에서 항상 <나 ≤를 조건으로 사용( = 금지!)**

```sql
SELECT ROWNUM, '이름', '국어', '영어', '수학'
  FROM (
       SELECT '이름', '국어', '영어', '수학'
	       FROM EXAM_SCORE
        ORDER BY '국어' DESC, '영어' DESC, '수학' DESC) 
        --ORDER BY가 SELECT보다 먼저 실행되기 위함--
 WHERE ROWNUM <= 5;
```