## 🌈 SQL (struction query language)

- 구조화된 질의 언어
- DB의 표준언어로, DB의 종류가 달라져도 사용 가능하다.

## 🌈 SQL 실행 순서
**[[FROM]] → [[WHERE]] → [[GROUP BY]] → [[HAVING]] → [[SELECT]] → [[ORDER BY]]**

## 🌈 SQL 분류
### 📌 DDL
+ 데이터 정의어
- table의 구조를 바꾸는 것

[[CREATE]]
[[ALTER]]
[[DROP]]
[[TRUNCATE]]
### 📌 DML
+ 데이터 조작어
- 구조는 변하지 않고 data 변화 행의 내용을 추가/수정/삭제하는 것

 [[INSERT]]
 [[UPDATE]]
 [[DELETE]]

### 📌 DQL/DML

- 조건에 맞는 data를 select하는 기술

[[SELECT]]

### 📌 DCL
+ 데이터 제어어
+ DB에 대한 접근 권한을 주고 회수

[[GRANT]]
[[REVOKE]]
[[RULE]]
### 📌 TCL
+ [[Transaction]] 제어에 사용되는 기술
+ 논리적인 작업 단위로 묶어 제어한다.

[[Project/SQL/RDB/SQL/TCL/COMMIT|COMMIT]]
[[ROLLBACK]]
[[SAVEPOINT]]

### 📌 함수
+ 문자 함수
CHR
LOWER/UPPER
LTRIM/RTRIM/TRIM
SUBSTR
LENGTH
INSTR
REPLACE

+ 숫자 함수
ABS
SIGN
ROUND
TRUNC
CEIL
FLOOR
MOD

+ 날짜 함수
SYSDATE
EXTRACT
ADD_MONTHS

+ 형변환
TO_NUMBER
TO_CHAR
TO_DATE

+ NULL 처리 함수
NVL
NULLIF
COALESCE

+ 기타 함수
DECODE
### 📌 기타 문법들
[[DESC]]
[[Alias]]
[[연산자]]
[[날짜형 포맷]]
[[CASE]]

