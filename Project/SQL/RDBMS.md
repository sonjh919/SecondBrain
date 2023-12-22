## 🌈 RDBMS (relation database management system)

- **관계형 database 관리 프로그램**
- 많은 종류의 db가 있으나 **관계형 db**가 주력으로 쓰임

## 🌈 DBMS (database management system)

- db를 control할 수 있게 중간에서 도와주는 프로그램


## 🌈 RDBMS의 구조

- db는 2차원의 table형태로 data를 저장
- 중복된 데이터 저장에서 오는 수정/관리의 이상현상을 효율적으로 관리하기 위해 관계형 db가 등장(정규화)

> **이상현상** data의 수정 과정에서 data가 서로 일치하지 않는 현상

### TABLE

- 테이블 : **ENTITY**
    
- 가로 : **ROW / INSTANCE**
    
- 세로 : **COLUMN / 속성(ATTRIBUTE)**
    
    첫번째 COLUMN : **COLUMN행** 또는 **COLUMN HEADER**
    
- Data 한개 : **COLUMN값, 필드(FIELD)**
    

---

### 데이터 유형

|데이터 유형|설명|.|
|---|---|---|
|CHAR|고정 길이 문자열|‘AA’ = ‘AA ‘|
|VARCHAR|가변 길이 문자열|‘AA’ ≠ ‘AA ‘|
|NUMERIC|숫자||
|DATETIME|날짜||

|명령어 종류|명령어|설명|
|---|---|---|
|DDL(데이터 정의어)|CREATE(생성)||
|ALTER(변경)|||
|RENAME(변경)|||
|DROP(삭제)|TABLE 구조 변경||
|DML(데이터 조작어)|SELECT(추출)||
|INSERT(추가)|||
|UPDATE(수정)|||
|DELETE(삭제)|구조 변경 없이 내용을 추출/추가/수정/삭제||
|DCL(데이터 제어어)|GRANT(권한부여)||
|REVOKE(권한회수)|DB 접근 권한을 주고 회수||
|TCL(트랜잭션 제어어)|COMMIT(작업 확정)||
|ROLLBACK(작업 취소)|트랜잭션(논리적 작업 단위)로 묶어 제어||

### Database 정의 언어

- table의 구조를 바꾸는 것
- 정의언어 : **DDL**

💡 **CREATE(생성), ALTER(변경), DROP(삭제)**



### Database 조작

- 구조는 변하지 않고 data 변화 행의 내용을 추가/수정/삭제하는 것
- 정의언어 : **DML**

 **INSERT(추가), UPDATE(수정), DELETE(삭제)**



### Database 추출

- 조건에 맞는 data를 select하는 기술
- 정의언어 : **DQL** 또는 **DML** 안에 포함

💡 **SELECT(추출)**
