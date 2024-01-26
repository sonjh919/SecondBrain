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

## Entity의 상태

![[entitystate.png]]

## 비영속(Transient)
+ 쉽게 말하자면 **new** 연산자를 통해 인스턴스화 된 [[Entity]] 객체를 의미한다.
- 아직 영속성 컨텍스트에 저장되지 않았기 때문에 JPA의 관리를 받지 않는다.

```java
Memo memo = new Memo(); // 비영속 상태
memo.setId(1L);
memo.setUsername("Robbie");
memo.setContents("비영속과 영속 상태");
```

## 영속(Managed)
### persist

```java
em.persist(memo);
```

+ 비영속 Entity를 EntityManager를 통해 영속성 컨텍스트에 저장하여 관리되고 있는 상태로 만든다.

```java
@Test
@DisplayName("비영속과 영속 상태")
void test1() {
    EntityTransaction et = em.getTransaction();

    et.begin();

    try {

        Memo memo = new Memo(); // 비영속 상태
        memo.setId(1L);
        memo.setUsername("Robbie");
        memo.setContents("비영속과 영속 상태");

        em.persist(memo);

        et.commit();

    } catch (Exception ex) {
        ex.printStackTrace();
        et.rollback();
    } finally {
        em.close();
    }

    emf.close();
}
```

## 준영속 (Detached)
+ 준영속 상태는 영속성 컨텍스트에 저장되어 관리되다가 분리된 상태를 의미한다.

## 영속 → 준영속
### detach
```java
em.detach(memo);
```

- detach(entity) : 특정 Entity만 준영속 상태로 전환한다.
+ 영속성 컨텍스트에서 관리되다(**Managed**)가 분리된 상태(**Detached**)로 전환된다.

```java
@Test
@DisplayName("준영속 상태 : detach()")
void test2() {
    EntityTransaction et = em.getTransaction();

    et.begin();

    try {

        Memo memo = em.find(Memo.class, 1);
        System.out.println("memo.getId() = " + memo.getId());
        System.out.println("memo.getUsername() = " + memo.getUsername());
        System.out.println("memo.getContents() = " + memo.getContents());

        // em.contains(entity) : Entity 객체가 현재 영속성 컨텍스트에 저장되어 관리되는 상태인지 확인하는 메서드
        System.out.println("em.contains(memo) = " + em.contains(memo));

        System.out.println("detach() 호출");
        em.detach(memo);
        System.out.println("em.contains(memo) = " + em.contains(memo));

        System.out.println("memo Entity 객체 수정 시도");
        memo.setUsername("Update");
        memo.setContents("memo Entity Update");

        System.out.println("트랜잭션 commit 전");
        et.commit();
        System.out.println("트랜잭션 commit 후");

    } catch (Exception ex) {
        ex.printStackTrace();
        et.rollback();
    } finally {
        em.close();
    }

    emf.close();
}
```

### clear
```java
em.clear();
```

+ 영속성 컨텍스트를 **완전히 초기화**한다.
+ 영속성 컨텍스트의 모든 Entity를 준영속 상태로 전환한다.
+ 영속성 컨텍스트 틀은 유지하지만 내용은 비워 새로 만든 것과 같은 상태가 되어 계속해서 영속성 컨텍스트를 이용할 수 있다.

```java
@Test
@DisplayName("준영속 상태 : clear()")
void test3() {
    EntityTransaction et = em.getTransaction();

    et.begin();

    try {

        Memo memo1 = em.find(Memo.class, 1);
        Memo memo2 = em.find(Memo.class, 2);

        // em.contains(entity) : Entity 객체가 현재 영속성 컨텍스트에 저장되어 관리되는 상태인지 확인하는 메서드
        System.out.println("em.contains(memo1) = " + em.contains(memo1));
        System.out.println("em.contains(memo2) = " + em.contains(memo2));

        System.out.println("clear() 호출");
        em.clear();
        System.out.println("em.contains(memo1) = " + em.contains(memo1));
        System.out.println("em.contains(memo2) = " + em.contains(memo2));

        System.out.println("memo#1 Entity 다시 조회");
        Memo memo = em.find(Memo.class, 1);
        System.out.println("em.contains(memo) = " + em.contains(memo));
        System.out.println("\n memo Entity 수정 시도");
        memo.setUsername("Update");
        memo.setContents("memo Entity Update");

        System.out.println("트랜잭션 commit 전");
        et.commit();
        System.out.println("트랜잭션 commit 후");

    } catch (Exception ex) {
        ex.printStackTrace();
        et.rollback();
    } finally {
        em.close();
    }

    emf.close();
}
```

### close
```java
em.close();
```

- 영속성 컨텍스트를 종료한다.
+ 해당 영속성 컨텍스트가 관리하던 영속성 상태의 Entity들은 모두 준영속 상태로 변경된다.
+ 영속성 컨텍스트가 종료되었기 때문에 계속해서 영속성 컨텍스트를 사용할 수 없다.

```java
@Test
@DisplayName("준영속 상태 : close()")
void test4() {
    EntityTransaction et = em.getTransaction();

    et.begin();

    try {

        Memo memo1 = em.find(Memo.class, 1);
        Memo memo2 = em.find(Memo.class, 2);

        // em.contains(entity) : Entity 객체가 현재 영속성 컨텍스트에 저장되어 관리되는 상태인지 확인하는 메서드
        System.out.println("em.contains(memo1) = " + em.contains(memo1));
        System.out.println("em.contains(memo2) = " + em.contains(memo2));

        System.out.println("close() 호출");
        em.close();
        Memo memo = em.find(Memo.class, 2); // Session/EntityManager is closed 메시지와 함께 오류 발생
        System.out.println("memo.getId() = " + memo.getId());

    } catch (Exception ex) {
        ex.printStackTrace();
        et.rollback();
    } finally {
        em.close();
    }

    emf.close();
}
```

## 준영속 → 영속
### merge
```java
em.merge(memo);
```

+ 전달받은 Entity를 사용하여 새로운 영속 상태의 Entity를 반환한다.

### merge 동작
- 파라미터로 전달된 Entity의 식별자 값으로 영속성 컨텍스트를 조회한다.
    1. 해당 Entity가 영속성 컨텍스트에 없다면?
        1. DB에서 새롭게 조회한다.
        2. 조회한 Entity를 영속성 컨텍스트에 저장한다.
        3. 전달 받은 Entity의 값을 사용하여 병합한다.
        4. Update SQL이 수행된다. (수정)
    2. 만약 DB에서도 없다면 ?
        1. 새롭게 생성한 Entity를 영속성 컨텍스트에 저장한다.
        2. Insert SQL이 수행된다. (저장)
+ 즉 merge(entity) 메서드는 비영속, 준영속 모두 파라미터로 받을 수 있으며 상황에 따라 ‘저장’을 할 수도 ‘수정’을 할 수도 있다.

#### 저장
```java
@Test
@DisplayName("merge() : 저장")
void test5() {
    EntityTransaction et = em.getTransaction();

    et.begin();

    try {

        Memo memo = new Memo();
        memo.setId(3L);
        memo.setUsername("merge()");
        memo.setContents("merge() 저장");

        System.out.println("merge() 호출");
        Memo mergedMemo = em.merge(memo);

        System.out.println("em.contains(memo) = " + em.contains(memo));
        System.out.println("em.contains(mergedMemo) = " + em.contains(mergedMemo));

        System.out.println("트랜잭션 commit 전");
        et.commit();
        System.out.println("트랜잭션 commit 후");

    } catch (Exception ex) {
        ex.printStackTrace();
        et.rollback();
    } finally {
        em.close();
    }

    emf.close();
}
```

#### 수정
```java
@Test
@DisplayName("merge() : 수정")
void test6() {
    EntityTransaction et = em.getTransaction();

    et.begin();

    try {

        Memo memo = em.find(Memo.class, 3);
        System.out.println("memo.getId() = " + memo.getId());
        System.out.println("memo.getUsername() = " + memo.getUsername());
        System.out.println("memo.getContents() = " + memo.getContents());

        System.out.println("em.contains(memo) = " + em.contains(memo));

        System.out.println("detach() 호출");
        em.detach(memo); // 준영속 상태로 전환
        System.out.println("em.contains(memo) = " + em.contains(memo));

        System.out.println("준영속 memo 값 수정");
        memo.setContents("merge() 수정");

        System.out.println("\n merge() 호출");
        Memo mergedMemo = em.merge(memo);
        System.out.println("mergedMemo.getContents() = " + mergedMemo.getContents());

        System.out.println("em.contains(memo) = " + em.contains(memo));
        System.out.println("em.contains(mergedMemo) = " + em.contains(mergedMemo));

        System.out.println("트랜잭션 commit 전");
        et.commit();
        System.out.println("트랜잭션 commit 후");

    } catch (Exception ex) {
        ex.printStackTrace();
        et.rollback();
    } finally {
        em.close();
    }

    emf.close();
}
```

## 삭제 (Removed)
```java
em.remove(memo);
```

+ 삭제하기 위해 조회해온 영속 상태의 Entity를 파라미터로 전달받아 삭제 상태로 전환한다.