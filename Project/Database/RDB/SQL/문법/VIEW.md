---
title: VIEW
date: 2023-12-28 09:35
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

## 🌈 VIEW

- **SELECT QUERY**문을 저장한 객체(가상 Table)이다.
- 실질적 DATA를 저장하고 있지는 않다.
- TABLE 사용과 동일하게 FROM에서 사용할 수 있다.
- **보안성, 독립성, 편리성**

```sql
CREATE OR REPLACE VIEW DEPT_MEMBER AS
SELECT A.DEPARTMENT_ID, A.DEPARTMENT_NAME
  FROM DEPARTMENTS A

SELECT DEPARTMENT_NAME FROM DEPT_MEMBER
```

## 🌈 VIEW 사용의 장점

|보안성|뷰 생성시 보안을 원하는 칼럼을 빼고 생성 → 사용자에게 정보를 숨길 수 있다.|
|---|---|
|독립성|테이블 구조가 변경되어도 뷰를 사용하는 응용 프로그램은 변경하지 않아도 된다.|
|편리성|복잡한 쿼리를 단순하게, 편리하게 사용 가능|

## 🌈 VIEW 삭제

```sql
DROP VIEW DEPT_MEMBER;
```