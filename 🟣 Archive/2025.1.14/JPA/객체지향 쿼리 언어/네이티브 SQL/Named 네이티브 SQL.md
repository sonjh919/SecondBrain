#jpa #NativeSQL

## Named 네이티브 SQL
+ JPQL처럼 네이티브 SQL도 Named 네이티브 SQL을 사용해서 정적 SQL을 작성할 수 있다.
+ JPQL의 [[Named 정적 쿼리]]와 같은 createNamedQuery() 메소드를 사용한다.(TypeQuery 사용 가능)

```java
@Entity
@NamedNativeQuery(
      name = "Member.memberSQL",
      query = "SELECT ID, AGE, NAME, TEAM_ID "
          + "FROM MEMBER WHERE AGE > ?",
      resultClass = Member.class
)
public class Member { ... }

// 엔티티 조회
TypedQuery<Member> nativeQuery = em.createNamedQuery("Member.memberSQL", Member.class)
                                  .setParameter(1, 20);
```

+ Named 네이티브 SQL에서 결과 매핑 사용이 가능하다.
```java
@Entity
@SqlResultSetMapping(name = "memberWithOrderCount",
      entities = {@EntityResult(entityClass = Member.class)},
      columns = {@ColumnResult(name = "ORDER_COUNT")}
)
@NamedNativeQuery(
  name = "Member.memberWithOrderCount",
  query = "SELECT M.ID, AGE, NAME, TEAM_ID, I.ORDER_COUNT "
          + "FROM MEMBER M LEFT JOIN "
          + "(SELECT IM.ID, COUNT(*) AS ORDER_COUNT "
          + "FROM ORDERS O, MEMBER IM WHERE O.MEMBER_ID = IM.ID) I "
          + "ON M.ID = I.ID",
  resultSetMapping = "memberWithOrderCount"
)
public class Member { ... }

// 엔티티 조회
List<Object[]> resultList = em.createNamedQuery("Member.memberWithOrderCount")
                              .getResultList();
```

### @NamedNativeQuery 속성
![[NamedNativeQuery.png]]

### 여러 Named 네이티브 쿼리 선언
```java
  @NamedNativeQueries({
      @NamedNativeQuery(...),
      @NamedNativeQuery(...)
  })
```