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

+ NamedQuery 사용
```java
// JpaMain.java
List<Member> resultList = em.createNamedQuery("Member.findByUsername", Member.class)
	.setParameter("username", "회원1")
	.getResultList();
```