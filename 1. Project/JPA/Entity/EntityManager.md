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
+ EntityManager는 이름 그대로 Entity를 관리하는 관리자이다.
- 개발자들은 EntityManager를 사용해서 Entity를 DB에 **등록/수정/삭제/조회**할 수 있다.
- EntityManager는 [[EntityManagerFactory]]를 통해 생성하여 사용할 수 있다.

> [!warning]+ 
> EntityManager는 DB connection과 밀접한 관계가 있으므로 스레드간에 공유하거나 재사용하면 안된다.


![[EntityManager.png]]

> [!important]+ 
> 사용이 끝난 EntityManager는 반드시 종료해야 한다.
> 
> `em.close(); // 엔티티 매니저 종료`