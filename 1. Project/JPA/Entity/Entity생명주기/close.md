#jpa 

## close
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
