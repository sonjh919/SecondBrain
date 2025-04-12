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
#jpa 

## EntityManager
- [[영속성 컨텍스트]]에 접근하여 [[Entity]] 객체들을 조작하기 위해서는 EntityManager가 필요하다.
+ EntityManager는 이름 그대로 **Entity를 관리하는 관리자**이다. Entity를 저장하는 **가상의 DB**로 생각할 수 있다.
- 개발자들은 EntityManager를 사용해서 Entity를 DB에 **등록/수정/삭제/조회**할 수 있다.
- EntityManager는 [[EntityManagerFactory]]를 통해 생성하여 사용할 수 있다.
- EntityManager는 연결이 꼭 필요한 시점까지 커넥션을 얻지 않는다. 보통 트랜잭션을 시작할 때 커넥션을 획득한다.

> [!warning]+ 
> EntityManager는 DB connection과 밀접한 관계가 있다. 여러 스레드가 동시에 접근하면 [[동시성 문제]]가 발생하므로 스레드간에 공유하거나 재사용하면 안된다.


![[EntityManager.png]]

> [!important]+ 
> 사용이 끝난 EntityManager는 반드시 종료해야 한다.
> 
> `em.close(); // 엔티티 매니저 종료`


## EntityManager와 영속성 컨텍스트
[[영속성 컨텍스트]]는 EntityManager를 생성할 때 하나 만들어진다. 그리고 EntityManager를 통해 영속성 컨텍스트에 접근할 수 있고, 관리할 수 있다.

> [!check]+ 
> 여러 EntityManager가 같은 영속성 컨텍스트에 접근하는 상황도 나올 수 있다.