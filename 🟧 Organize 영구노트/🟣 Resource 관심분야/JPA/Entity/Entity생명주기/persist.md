#jpa 
## persist

```java
em.persist(memo);
```

+ 비영속 Entity를 EntityManager를 통해 **영속성 컨텍스트에 저장하여 관리되고 있는 상태**로 만든다.

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
