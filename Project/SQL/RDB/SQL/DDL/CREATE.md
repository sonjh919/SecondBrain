---
tistoryBlogName: sonjh919
tistoryTitle: CREATE
tistoryTags: DATABASE, SQL
tistoryVisibility: "3"
tistoryCategory: "1206897"
tistorySkipModal: true
tistoryPostId: "55"
tistoryPostUrl: https://sonjh919.tistory.com/55
---
## 🌈 CREATE

- DATETIME은 별도의 크기지정이 없다.
- [[제약조건]]을 추가할 수 있다.

```sql
CREATE TABLE TABLE명 (
	칼럼명1 DATATYPE [DEFAULT 형식],
	칼럼명2 DATATYPE [DEFAULT 형식]
CONSTRAINT 제약조건명 제약조건 (컬럼명)
);
```

## 🌈 사용자 생성
+ 사용자 생성 권한이 있어야 가능하다.
```sql
CREATE USER 사용자명 IDENTIFIED BY 패스워드;
```