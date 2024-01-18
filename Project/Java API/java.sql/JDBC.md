---
title: JDBC
date: 2024-01-18 12:55
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

## JDBC (Java Database Connectivity)
+ Java에서 DataBase에 접속할 수 있도록 하는 Java API이다.

## JDBC 등장 배경
### 일반적인 DB의 활용
+ Client Program(sql developer) → DBMS(oracle) → DataBase

### Java를 이용한 DB 접근
+ Java Application이 Driver라고 하는 API를 거쳐 DBMS를 사용한다.
+ **Java Application → Driver→ DBMS(Oracle) - DataBase**

#### Driver
- Java로 작성되어 있는 API
- DBMS마다 코드가 다르며, Oracle은 OracleDriver가 있다.
- OJDBC.jar (Java 압축 라이브러리)를 Java Application에서 활용하는 방식

### 문제점

먼저, 애플리케이션 서버에서 DB에 접근 하기 위해서는 여러가지 작업이 필요하다.

![[jdbc1.png]]

1. 우선 DB에 연결하기 위해 커넥션을 연결한다.
2. SQL을 작성한 후 커넥션을 통해 SQL을 요청한다.
3. 요청한 SQL에 대한 결과를 응답 받는다.

하지만 여기서, 기존에 사용하던 MySQL 서버를 다른 DB로 바꾸면 어떨까?

![[jdbc2.png]]

각 DB마다 커넥션, SQL, 결과 응답 등 모든 방법이 다르다. 즉, DBMS가 바뀌면 그에 맞춰 Java와 Driver가 모두 바뀌어야 한다. 이는 곧 **결합 상태(의존도가 높은 상태)** 라고 할 수 있다.

### 해결법
+ 중간에 interface를 하나 둔다 → **JDBC**
+ Java Application → JDBC → Driver→ DBMS(Oracle) - DataBase
+ JDBC는 java 에서 호출하는 코드를 mysql이든 oracle이든 똑같이 처리할 수 있도록 해주는 역할을 하며, **JDBC로 인해 결합 관계를 느슨하게 해준다. (약한 결합 상태)**
+ 하지만 아직도 여러 작업 로직을 직접 작성해야 하는 불편함이 있어, 이를 [[JdbcTemplate]]을 이용하여 해결한다.

![[jdbc3.png]]