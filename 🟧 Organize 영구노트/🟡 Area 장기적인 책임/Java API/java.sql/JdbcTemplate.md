---
title: JdbcTemplate
date: 2024-01-18 13:09
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
#Java #JavaAPI #javasql 


## JdbcTemplate
- JDBC의 등장으로 손쉽게 DB교체가 가능해졌지만 아직도 DB에 연결하기 위해 여러가지 작업 로직들을 직접 작성해야한다는 불편함이 남아있다.
- 이러한 불편함을 해결하기 위해 커넥션 연결, statement 준비 및 실행, 커넥션 종료 등의 반복적이고 중복되는 작업들을 대신 처리해주는 JdbcTemplate이 등장했다.
- 물론 JdbcTemplate이 JDBC를 직접 사용할 때 발생하는 불편함을 해결해 주었지만 아직도 복잡하고 사용하기 까다로운 것은 분명한 사실이다. 다행히도 Java 개발자들을 위해 DB와 객체를 매핑하여 소통할 수 있는 **ORM**이라는 기술이 등장했다.
- 현재 JdbcTemplate은 따로 지정하지 않아도 Spring에서 이미 Bean으로 관리하고 있다.

 
 ![[jdbcTemplate.png]]