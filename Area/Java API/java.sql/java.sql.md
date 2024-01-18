---
title: java.sql
date: 2024-01-18 12:45
categories:
  - JavaAPI
  - java.sql
tags:
  - Java
  - JavaAPI
  - javasql
image: 
path:
---

## java.sql
+ Java에서 관계형 데이터베이스와 상호 작용하기 위한 API를 제공한다. 
+ 이 패키지는 [[JDBC]](Java Database Connectivity)라고 불리는 Java 표준 인터페이스를 정의하고 있다. JDBC는 데이터베이스와의 연결을 수립하고, SQL 쿼리를 실행하며, 결과를 처리하는 데 사용된다.

### 주요 클래스와 인터페이스
1. **`DriverManager`:**
    - 데이터베이스 드라이버를 등록하고, 데이터베이스와의 연결을 생성하는 역할을 한다.
2. **`Connection`:**
    - 데이터베이스와의 연결을 나타내는 인터페이스입니다. `DriverManager`를 통해 얻어지며, 데이터베이스와의 트랜잭션을 관리한다.
3. **`Statement`:**
    - SQL 쿼리를 실행하기 위한 기본 인터페이스이다. `Statement`의 하위 인터페이스로는 `PreparedStatement`와 `CallableStatement`가 있다.
4. **`PreparedStatement`:**
    - SQL 쿼리를 미리 컴파일하여 재사용 가능한 상태로 유지할 수 있는 인터페이스이다. 이는 보안과 성능을 향상시킨다.
5. **`CallableStatement`:**
    - 데이터베이스 내의 저장 프로시저(Stored Procedure)를 호출하기 위한 인터페이스이다.
6. **`ResultSet`:**
    - SQL 쿼리의 결과를 나타내는 인터페이스입니다. 데이터베이스로부터 가져온 행들을 담고 있으며, 데이터를 읽고 업데이트하는 메서드를 제공한다.

### JDBC를 사용한 DB 접근, 작업 과정
1. **드라이버 등록:**
    - `DriverManager`를 사용하여 데이터베이스 드라이버를 등록한다.
2. **연결 생성:**
    - `DriverManager.getConnection()`을 호출하여 데이터베이스와의 연결을 생성한다.
3. **쿼리 실행:**
    - `Statement`, `PreparedStatement`, 또는 `CallableStatement`를 사용하여 SQL 쿼리를 실행한다.
4. **결과 처리:**
    - `ResultSet`을 통해 쿼리의 결과를 받아와서 처리한다.
5. **연결 종료:**
    - 모든 작업이 끝나면 `Connection`을 닫아 연결을 종료한다.