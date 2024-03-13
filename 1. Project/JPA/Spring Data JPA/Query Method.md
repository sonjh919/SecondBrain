#jpa #SpringDataJPA

## Query Method
+ [[Spring Data JPA]]에서는 메서드 이름으로 [[SQL]]을 생성할 수 있는 Query Methods 기능을 제공한다.
+ JpaRepository 인터페이스에서 해당 인터페이스와 매핑되어있는 테이블에 요청하고자 하는 SQL을 메서드 이름을 사용하여 선언할 수 있다.
+ SimpleJpaRepository 클래스가 생성될 때 직접 선언한 JpaRepository 인터페이스의 모든 메서드를 자동으로 구현해준다.
+ JpaRepository 인터페이스의 메서드 즉, Query Method는 개발자가 이미 정의 되어있는 규칙에 맞게 메서드를 선언하면 해당 메서드 이름을 분석하여 SimpleJpaRepository에서 구현이 된다.

### 대표적인 쿼리 생성 기능
전체 내용은 [Query Methods](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories.query-methods.query-creation)에서 확인하자.
![[querymethod1.jpg]]

![[querymethod2.jpg]]

> [!caution]+ 
> 엔티티의 필드명이 변경되면 인터페이스에 정의한 메소드 이름도 함께 변경하자.