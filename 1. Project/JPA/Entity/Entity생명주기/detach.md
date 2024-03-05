#jpa
## detach
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
