---
title: SimpleJpaRepository
date: 2024-01-20 09:25
categories:
  - JPA
tags:
  - jpa
image: 
path:
---

## SimpleJpaRepository
+ Spring 프레임워크에서는 DB의 트랜잭션 개념을 애플리케이션에 적용할 수 있도록 **트랜잭션 관리자**를 제공한다.

```java
@Transactional(readOnly = true)
public class SimpleJpaRepository<T, ID> implements JpaRepositoryImplementation<T, ID> {
						...
			
		@Transactional
		@Override
		public <S extends T> S save(S entity) {
		
			Assert.notNull(entity, "Entity must not be null");
		
			if (entityInformation.isNew(entity)) {
				em.persist(entity);
				return entity;
			} else {
				return em.merge(entity);
			}
		}

						...
}
```
### @Transactional
- @Transactional 애너테이션을 클래스나 메서드에 추가하면 쉽게 트랜잭션 개념을 적용할 수 있다.
+ 메서드가 호출되면, **해당 메서드 내에서 수행되는 모든 DB 연산 내용은 하나의 트랜잭션**으로 묶인다.
+ 이때, 해당 메서드가 정상적으로 수행되면 트랜잭션을 커밋하고, **예외가 발생하면 롤백**한다.
+ 클래스에 선언한 @Transactional은 해당 클래스 내부의 모든 메서드에 트랜잭션 기능을 부여한다.
+ 이때, save 메서드는 @Transactional 애너테이션이 추가되어있기 때문에 `readOnly = true` 옵션인 @Transactional을 덮어쓰게 되어 `readOnly = false` 옵션으로 적용된다.

## Spring Data JPA의 SimpleJpaRepository
- Spring Data JPA에서는 JpaRepository 인터페이스를 구현하는 클래스를 자동으로 생성해준다.
    - Spring 서버가 뜰 때 JpaRepository 인터페이스를 상속받은 인터페이스가 자동으로 스캔이 되면,
    - 해당 인터페이스의 정보를 토대로 자동으로 **SimpleJpaRepository** 클래스를 생성해 주고, 이 클래스를 Spring ‘**Bean**’으로 등록한다.
- 따라서 인터페이스의 구현 클래스를 직접 작성하지 않아도 JpaRepository 인터페이스를 통해 JPA의 기능을 사용할 수 있다.

![[SimpleJapRepository.png]]

+ SimpleJpaRepositry 구현체

![[Pasted image 20240120101831.png]]