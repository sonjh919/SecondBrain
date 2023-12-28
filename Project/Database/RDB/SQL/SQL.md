---
title: SQL
date: 2023-12-22 12:03
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
#### 🧶 [[DDL]]
+ 데이터 정의어
- table의 구조를 바꾸는 것

#### 🧶 [[DML]]
+ 데이터 조작어
- 구조는 변하지 않고 data 변화 행의 내용을 추가/수정/삭제하는 것

#### 🧶 [[DCL]]
+ 데이터 제어어
+ DB에 대한 접근 권한을 주고 회수

#### 🧶 [[TCL]]
+ [[Transaction]] 제어에 사용되는 기술
+ 논리적인 작업 단위로 묶어 제어한다.

### 📌 함수
+ [[Project/Database/RDB/SQL/함수/함수|함수]]

### 📌 문법
+ [[DESC]]
+ [[Alias]]
+ [[Project/Database/RDB/SQL/문법/연산자]]
+ [[날짜형 포맷]]
+ [[CASE]]
+ [[DUAL]]
+ [[IN & EXISTS]]
+ [[Project/Database/RDB/SQL/Join/JOIN|JOIN]]
+ [[VIEW]]
+ [[집합 연산자]]
+ [[절차형 SQL]]
### 📌 Query
+ [[SubQuery]]
+ [[Top-N Query]]
+ [[계층 Query]]
