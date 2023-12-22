## 🌈 SELECT

- data 추출 시에 사용하는 명령어이다.

```sql
SELECT 컬럼명1, 컬럼명 2 FROM 테이블명 [WHERE 조건식];
```


- 문자열은 ‘’로 감싸기
- * : 전체 COLOMN 조회

```sql
SELECT *
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
```

## 🌈 TOP WITH TIES

- TOP 과 동일하게 상위 N개의 데이터를 조회
- **동일한 데이터가 있을 경우 함께 출력**된다.

```sql
SELECT TOP 1 WITH TIES
  item, cnt
FROM sql_test_a
ORDER BY item DESC, cnt DESC
```