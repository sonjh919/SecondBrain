---
title: ALTER
date: 2023-12-22 12:20
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

## ALTER TABLE

- 칼럼 추가/삭제, 제약조건 추가/삭제 등의 역할을 수행한다.

### 칼럼 추가

- 테이블의 마지막 칼럼이 되며 위치 지정 불가

```sql
ALTER TABLE '테이블명'
ADD '추가칼럼명' '데이터유형';
```

### 칼럼 삭제

- 하나 이상의 칼럼이 남아있어야한다.
- 복구 불가능

```sql
ALTER TABLE '테이블명'
DROP 'COLUMN' '삭제할칼럼명';
```

### 칼럼 수정

- 칼럼크기를 줄일 수 는 없다
- DEFAULT값 변경은 이후 발생하는 행에만 적용
- 해당 칼럼이 NULL값만 가지고 있으면 데이터 유형 변경 가능
- NULL값이 없을 경우에만 NOT NULL 추가 가능

```sql
ALTER TABLE '테이블명'
MODIFY ('칼럼명1' '데이터유형' [DEFAULT],
				'칼럼명2' '데이터유형' [DEFAULT]...);
```

### 칼럼명 변경

```sql
ALTER TABLE '테이블명'
RENAME COLUMN '이전칼럼명' TO '새칼럼명';
```

### 제약조건 삭제

```sql
ALTER TABLE '테이블명'
DROP CONSTRAINT '제약조건명';
```

### 제약조건 추가

```sql
ALTER TABLE '테이블명'
ADD CONSTRAINT '제약조건명' '제약조건'('칼럼명')
```

### 테이블 이름 변경

```sql
RENAME '변경전테이블명' TO '변경후테이블명';
```

## 사용자 변경
```sql
ALTER USER '사용자명' IDENTIFIED BY '패스워드';
```