#jpa 

## EntityManagerFactory
+ EntityManagerFactory를 만들기 위해서는 DB에 정보를 전달해야 한다.
+ 정보를 전달하기 위해서는 /resources/META-INF/ 위치에 persistence.xml 파일을 만들어 정보를 넣어두면 된다. Persistence 클래스를 사용하는데, 이 클래스가 EntityManagerFactory를 생성하여 JPA를 사용할 수 있게 준비한다.
+ Spring에서는 xml이 아니라 [[application.properties]]에서 설정한 정보를 바탕으로 EntityManager와 EntityManagerFactory를 자동으로 생성해준다.
+ EntityManagerFactory는 JPA를 동작시키기 위한 기반 객체를 만들고, 구현체에 따라서는 DB 커넥션 풀도 생성하므로 **EntityManagerFactory를 생성하는 비용은 아주 크다!**
+ EntityManagerFactory를 만든 이후에는 필요할 때마다 여기에서 [[EntityManager]]를 생성하면 된다.

> [!warning]+ 
> EntityManageFactory는 어플리케이션 전체에서 딱 한 번만 생성하고 공유해서 사용해야 한다.
> 

> [!tip]+ 
> EntityManagerFactory는 여러 스레드가 동시에 접근해도 안전하므로 서로 다른 스레드 간에 공유해도 상관없다.

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

> [!important]+ 
> 사용이 끝난 EntityManagerFactory는 반드시 종료해야 한다.
> 
> `emf.close(); //엔티티 매니저 팩토리 종료`

