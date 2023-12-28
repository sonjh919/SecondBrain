---
title: 절차형 SQL
date: 2023-12-28 10:15
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

## 🌈 절차형 SQL
- 일반적인 개발언어처럼 절차지향적인 프로그램 작성

## 🌈 PL/SQL
- 변수와 상수 등을 사용하여 조건 등으로 대입 가능
- Procedure, User Defined Function, Trigger 객체는 작성자 기준으로 트랜잭션 분할 가능
- Procedure 내에 있는 절차적 코드는 ql/sql 엔진이 처리, 일반 sql문은 sql실행기가 처리

## 🌈 저장형 프로시져
- SQL을 로직과 함께 데이터베이스 내에 저장해 놓은 명령문의 집합

## 🌈 사용자 정의 함수
- 독단적으로 실행되기보다는 **다른 SQL문을 통하여 호출되고 리턴하는 SQL의 보조적인 역할**

## 🌈 Trigger

- [[DML]]이 수행되었을 때 자동으로 동작하는 프로그램(프로시저는 EXECUTE로 실행)
- [[DCL]]과 [[TCL]] 실행불가(프로시저는 사용가능)
- 데이터의 무결성과 일관성을 위해 **사용자 정의 함수 사용**

## 🌈 EXECUAT IMMEDIATE
- 동적 실행