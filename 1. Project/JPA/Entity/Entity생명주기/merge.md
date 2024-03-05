#jpa 

## merge
```java
em.merge(memo);
```

+ 전달받은 Entity를 사용하여 새로운 영속 상태의 Entity를 반환한다.

### merge 동작
- 파라미터로 전달된 Entity의 식별자 값으로 영속성 컨텍스트를 조회한다.

> [!info]+ 
> 1. 해당 Entity가 영속성 컨텍스트에 없다면?
> 	1. DB에서 새롭게 조회한다.
> 	2. 조회한 Entity를 영속성 컨텍스트에 저장한다.
> 	3. 전달 받은 Entity의 값을 사용하여 병합한다.
> 	4. Update SQL이 수행된다. (수정)
> 2. 만약 DB에서도 없다면 ?
> 	1. 새롭게 생성한 Entity를 영속성 컨텍스트에 저장한다.
> 	2. Insert SQL이 수행된다. (저장)

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
