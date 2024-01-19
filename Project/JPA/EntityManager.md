---
title: EntityManager
date: 2024-01-19 16:36
categories:
  - JPA
tags:
  - jpa
image: 
path:
---

## EntityManager
- [[영속성 컨텍스트]]에 접근하여 [[Entity]] 객체들을 조작하기 위해서는 EntityManager가 필요하다.
+ EntityManager는 이름 그대로 Entity를 관리하는 관리자이다.
- 개발자들은 EntityManager를 사용해서 Entity를 저장하고 조회하고 수정하고 삭제할 수 있다.
- EntityManager는 EntityManagerFactory를 통해 생성하여 사용할 수 있다.

![[EntityManager.png]]

## EntityManagerFactory
+ EntityManagerFactory를 만들기 위해서는 DB에 정보를 전달해야 한다.
+ 정보를 전달하기 위해서는 /resources/META-INF/ 위치에 persistence.xml 파일을 만들어 정보를 넣어두면 된다.

```java
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.2"
             xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_2.xsd">
    <persistence-unit name="memo">
        <class>com.sparta.entity.Memo</class>
        <properties>
            <property name="jakarta.persistence.jdbc.driver" value="com.mysql.cj.jdbc.Driver"/>
            <property name="jakarta.persistence.jdbc.user" value="root"/>
            <property name="jakarta.persistence.jdbc.password" value="{비밀번호}"/>
            <property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/memo"/>

            <property name="hibernate.hbm2ddl.auto" value="create" />

            <property name="hibernate.show_sql" value="true"/>
            <property name="hibernate.format_sql" value="true"/>
            <property name="hibernate.use_sql_comments" value="true"/>
        </properties>
    </persistence-unit>
</persistence>
```

```java
// JPA는 persistence.xml 의 정보를 토대로 EntityManagerFactory를 생성
EntityManagerFactory emf = Persistence.createEntityManagerFactory("memo");

// EntityManagerFactory를 사용하여 EntityManager를 생성
EntityManager em = emf.createEntityManager();
```