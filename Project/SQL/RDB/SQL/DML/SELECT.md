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