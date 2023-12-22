## 🌈 SQL (struction query language)

- 구조화된 질의 언어
- DB의 표준언어로, DB의 종류가 달라져도 사용 가능하다.

## 🌈 SQL 분류
### 📌 DDL
+ 데이터 정의어
- table의 구조를 바꾸는 것

[[CREATE]](생성)
[[ALTER]](변경)
[[DROP]](삭제)

### 📌 DML
+ 데이터 조작어
- 구조는 변하지 않고 data 변화 행의 내용을 추가/수정/삭제하는 것

 [[INSERT]](추가)
 [[UPDATE]](수정)
 [[DELETE]](삭제)

### 📌 DQL/DML

- 조건에 맞는 data를 select하는 기술

[[SELECT]](추출)

### 📌 DCL
+ 데이터 제어어
+ DB에 대한 접근 권한을 주고 회수

[[GRANT]](권한부여)
[[REVOKE]](권한회수)

### 📌 TCL
+ 트랜잭션 제어에 사용되는 기술
+ 논리적인 작업 단위로 묶어 제어한다.

[[COMMIT]](작업 확정)
[[ROLLBACK]](작업 취소)

### 📌 기타 문법들
[[DESC]]
[[TRUNCATE]]