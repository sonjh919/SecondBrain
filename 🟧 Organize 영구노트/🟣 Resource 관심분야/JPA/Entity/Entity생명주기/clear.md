#jpa 

## clear
```java
em.clear();
```

+ 영속성 컨텍스트를 **완전히 초기화**한다.
+ 영속성 컨텍스트의 **모든 Entity**를 준영속 상태로 전환한다.
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
