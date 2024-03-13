#jpa #SpringDataJPA 

## Spring Data JPA의 필요성
대부분의 데이터 접근 계층은 일명 CRUD로 부르는 유사한 등록, 수정, 삭제, 조회 코드를 반복해서 개발해야 한다. 그래서 JPA를 쉽게 사용하기 위해 등장하게 되었다. 이를 이용하면 **구현 클래스 없이 인터페이스만 작성해도 개발을 완료**할 수 있다.

## Spring Data JPA
- Spring Data JPA는 JPA를 쉽게 사용할 수 있게 만들어놓은 하나의 모듈로, **JPA를 추상화**시킨 **Repository 인터페이스**를 제공한다.
- Repository 인터페이스는 Hibernate 같은 JPA구현체를 사용해서 구현한 클래스를 통해 사용된다.
- Spring Data JPA에서는 JpaRepository 인터페이스를 구현하는 [[SimpleJpaRepository]]클래스를 자동으로 생성하여 Bean에 등록해준다.

![[SpringDataJPA.png]]

### Spring Data JPA의 메소드 분석
일반적인 CRUD 메소드는 JpaRepository 인터페이스가 공통으로 제공하므로 문제가 없다. 하지만 직접 작성한 메소드들은 어떻게 할까? 놀랍게도, Spring Data JPA는 메소드 이름을 분석해서 이에 맞는[[JPQL]]을 실행한다. 이를 [[Query Method]]라 한다.

```java
MemberRepository.findByUsername(...)

select m from Member m where username =: username
```

## Spring Data 프로젝트
스프링 데이터 JPA는 스프링 데이터 프로젝트의 하위 프로젝트 중 하나이다. 스프링 데이트 프로젝트는 **다양한 데이터 저장소에 대한 접근을 추상화**해서 개발자 편의를 제공하고 지루하게 반복하는 데이터 접근 코드를 줄여준다.

![[springdataproject.png]]


## Spring Data JPA의 인터페이스 및 클래스
+ [[Page]]
+ [[Pageable]]
+ [[1. Project/JPA/Spring Data JPA/Sort|Sort]]