#jpa #Annotation 


## @NamedQuery
이름 그대로 쿼리에 이름을 부여해서 사용하는 방법이다.

+ NamedQuery 정의
```java
@Entity
@NamedQuery(
    name = "Member.findByUsername",
    query = "select m from Member m where m.username = :username")
public class Member {
    ...
}
```

## @NamedQuery 구성
```java
@Target({TYPE})
public @interface NamedQuery {
    String name();  // Named 쿼리 이름(필수)
    String query();     // JPQL 정의(필수)
    LockModeType lockMode() default NONE;   // 쿼리 실행 시 락을 건다
    QueryHint[] hints() default {};         // JPA 구현체에 쿼리 힌트를 줄 수 있다. 2차 캐시 다룰 때 사용한다.
```

## @NamedQuery 사용
```java
public class MemberRepository{
	public List<Member> findByUsername(String username){
		List<Member> resultList = em.createNamedQuery
		("Member.findByUsername", Member.class)
			.setParameter("username", "회원1")
			.getResultList();
	}
	
}
```

### Spring Data JPA로 NamedQuery 호출
+ 만약 실행할 Named 쿼리가 없으면 메소드 이름으로 쿼리 생성 전략을 사용한다.
+ 참고 : [[JPA NamedQuery]]

```java
public interface MemberRepository extends JpaRepository<Member, Long> {
	List<Member> findByUsername(@Param("username") String username);
}
```
