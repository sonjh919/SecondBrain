---
title: Entity 상태
date: 2024-01-19 21:02
categories:
  - JPA
tags:
  - jpa
image: 
path:
---
#jpa 

## Entity의 생명주기
+ Entity에는 [[영속성 컨텍스트]]와 관련하여 4가지의 상태가 존재한다.
+ DB와 관련된 작업은 반드시 [[flush]]가 실행된다.

> [!summary]+ 
> 1. 비영속(new/transient) : 영속성 컨텍스트와 전혀 관계가 없는 상태
> 2. 영속(managed) : 영속성 컨텍스트에 저장된 상태
> 3. 준영속(detached) : 영속성 컨텍스트에 저장되었다가 분리된 상태
> 4. 삭제(removed) : 삭제된 상태

![[entitystate.png]]

## 1. 비영속(Transient)
+ **new** 연산자를 통해 인스턴스화 된 [[Entity]] 객체를 의미한다.
- 아직 영속성 컨텍스트에 저장되지 않았기 때문에 JPA의 관리를 받지 않는다.

```java
Memo memo = new Memo(); // 비영속 상태
memo.setId(1L);
memo.setUsername("Robbie");
memo.setContents("비영속과 영속 상태");
```

## 2. 영속(Managed)
**영속성 컨텍스트에 저장하여 관리되고 있는 상태**이다. em.find()나 JPQL을 사용하여 조회한 Entity도 해당된다.

> [!summary]+ 
> + [[persist]]

## 3. 준영속 (Detached)
준영속 상태는 영속성 컨텍스트에 저장되어 관리되다가 분리된 상태를 의미한다. [[1차 캐시]]부터 [[쓰기 지연 저장소]]까지 해당 엔티티를 관리하기 위한 모든 정보가 제거된다.

### 영속 → 준영속

> [!summary]+ 
> + [[detach]]
> + [[clear]]
> + [[close]]

### 준영속 → 영속

> [!summary]+ 
> + [[merge]]

## 4. 삭제 (Removed)

> [!summary]+ 
> + [[remove]]
