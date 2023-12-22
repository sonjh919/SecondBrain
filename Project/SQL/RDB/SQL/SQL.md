---
tistoryBlogName: sonjh919
tistoryTitle: SQL
tistoryTags: DATABASE, SQL
tistoryVisibility: "3"
tistoryCategory: "1206897"
tistorySkipModal: true
tistoryPostId: "48"
tistoryPostUrl: https://sonjh919.tistory.com/48
---
## 🌈 SQL (struction query language)

- 구조화된 질의 언어
- DB의 표준언어로, DB의 종류가 달라져도 사용 가능하다.

## 🌈 SQL 실행 순서
**[[FROM]] → [[WHERE]] → [[GROUP BY]] → [[HAVING]] → [[SELECT]] → [[ORDER BY]]**
```
5 : SELECT 컬럼명, 계산식, 함수식 [AS 별칭]
1 : FROM 참조할 테이블 명
2 : WHERE 컬럼명 | 함수식 비교연산자 비교값
3 : GROUP BY 그룹을 묶을 컬럼명
4 : HAVING 그룹함수식 비교연산자 비교값
6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식(ASC, DESC) [NULLS FIRST | LAST]
```

## 🌈 SQL 분류
### 📌 DB 정의 언어
[[DDL]]
[[DML]]
[[DCL]]
[[TCL]]

### 📌 함수
[[Project/SQL/RDB/SQL/함수/함수|함수]]

### 📌 문법
[[DESC]]
[[Alias]]
[[연산자]]
[[날짜형 포맷]]
[[CASE]]
[[DUAL]]
JOIN