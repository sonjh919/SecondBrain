---
title: application.properties
date: 2024-01-17 12:50
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## application.properties
+ Spring과 관련된 설정을 할 때 사용되는 파일이다.
+ 자동으로 설정되고 있는 설정 값을 쉽게 수정할 수 있다.
- DB 연결 시 DB의 정보를 제공해야하는데 이러한 경우에도 이 파일을 이용하여 쉽게 값을 전달할 수 있다.
- yml 파일로도 설정할 수 있다.

### 가능한 설정
+ **server**: 서버 port 관련 설정
+ **spring**: spring 관련 설정, jdbc나 rds, servlet설정 등
+ **jwt**: jwt 관련 설정
+ **mybatis**: mybatis 설정
+ **cloud**: aws 사용 지 연결 설정

등등등..


## yml vs properties
둘의 대표적인 차이는 내부 구조가 있다. properties의 경우에는 각 줄마다 key-value의 형태로 이루어져 있지만, yml의 경우 **들여쓰기로 구분되는 계층 구조** 및 key:value 형태로 이루어져 가독성이 훨씬 편하다. 리스트구조에서도 properties는 배열과 비슷하게 하나씩 설정해야 하지만, yml에서는 계층 구조로 나뉜다.

어떤 것을 사용해도 문제가 없지만, 개인적으로는 yml이 구조를 파악하기 더 쉽기 때문에 yml을 쓰는 것이 더 좋다고 생각한다.

---

## application.properties 세팅

```groovy

// mysql 연결
spring.datasource.url=jdbc:mysql://localhost:3306/memo  
spring.datasource.username=root  
spring.datasource.password={password}  
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver  

// jpa
spring.jpa.hibernate.ddl-auto=update  

// hibernate가 자동으로 만들어주는 sql을 보기 좋게 해주는 역할
spring.jpa.properties.hibernate.show_sql=true  
spring.jpa.properties.hibernate.format_sql=true  
spring.jpa.properties.hibernate.use_sql_comments=true
```

### spring.jpa.hibernate.ddl-auto
+ create : 기존 table을 전부 삭제한 후에 다시 생성 (drop + create)
+ create-drop : create과 같지만 종료 시점에 table을 drop한다.
+ update : 변경된 부분만 반영한다.
+ validate : Entity와 table이 정상적으로 mapping되었는지만 확인한다.
+ none : 아무것도 하지 않는다.