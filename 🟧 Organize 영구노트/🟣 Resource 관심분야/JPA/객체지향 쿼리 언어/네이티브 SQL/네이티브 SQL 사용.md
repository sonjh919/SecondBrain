#jpa #NativeSQL

## 네이티브 SQL 사용
네이티브 쿼리 API는 다음 3가지가 있다.

> [!summary]+ 
> 1. 엔티티 조회
> 2. 값 조회
> 3. 결과 매핑 사용

### 1. 엔티티 조회
+ JPQL을 사용할 때와 거의 비슷하지만 **실제 데이터베이스 SQL을 사용**한다는 것과 위치 기준의 [[파라미터 바인딩]]만 지원한다는 차이가 있다.

> [!info]+ 
> 첫 번째 파라미터는 네이티브SQL을 입력하고, 두 번째 파라미터는 조회할 엔티티 클래스 타입을 입력한다.
> `em.createNativeQuery(SQL, 결과 클래스)`

```java
// SQL 정의
String sql =
	"SELECT ID, AGE, NAME, TEAM_ID" +
	"FROM MEMBER WHERE AGE > ?";

Query nativeQuery = em.createNativeQuery(sql, Member.class)
	.setParameter(1,20);

List<Member> resultList = nativeQuery.getResultList();
```

> [!important]+ 
> 네이티브SQL로 SQL만 직접 사용할 뿐이지 나머지는 JPQL을 사용할 때와 같다. 조회한 엔티티도 [[영속성 컨텍스트]]에서 관리된다.


### 2. 값 조회
엔티티로 조회하지 않고 단순히 값으로 조회하기 위해서는 `em.createNativeQuery`의 두 번째 파라미터를 사용하지 않으면 된다. 이렇게 되면 JPA는 조회한 값들을 `Object[]`에 담아 반환하게 된다.

```java
// SQL 정의
String sql =
	"SELECT ID, AGE, NAME, TEAM_ID" +
	"FROM MEMBER WHERE AGE > ?";

Query nativeQuery = em.createNativeQuery(sql)
	.setParameter(1,10);

List<Object[]> resultList = nativeQuery.getResultList();
```

> [!check]+ 
> 여기서는 스칼라 값들을 조회했을 뿐이므로 결과를 영속성 컨텍스트가 관리하지 않는다. 마치 JDBC로 데이터를 조회한 것과 비슷하다.

### 3. 결과 매핑 사용
엔티티와 스칼라 값을 함께 조회하는 것처럼 매핑이 복잡해지면 `@SqlResultSetMapping`을 정의하여 결과 매핑을 사용해야 한다.

+ 두 번째 파라미터에 결과 매핑 정보의 이름을 사용한다.
```java
// SQL
String sql = "SELECT M.ID, AGE, NAME, TEAM_ID, I.ORDER_COUNT "
		+ "FROM MEMBER M"
		+ "LEFT JOIN "
			+ "(SELECT IM.ID, COUNT(*) AS ORDER_COUNT "
			+ "FROM ORDERS O, MEMBER IM WHERE O.MEMBER_ID = IM.ID) I "
			+ "ON M.ID = I.ID";

Query nativeQuery = em.createNativeQuery(sql, "memberWithOrderCount");

List<Object[]> resultList = nativeQuery.getResultList();
```

+ 결과 매핑 정의
```java

// 매핑 정보          
@Entity
@SqlResultSetMapping(name = "memberWithOrderCount",
	entities = {@EntityResult(entityClass = Member.class)},
	columns = {@ColumnResult(name = "ORDER_COUNT")}
)
public class Member { ... }
```

- `@FieldResult`를 사용해서 컬럼명과 필드명을 직접 매핑 가능하다. 엔티티 필드에 정의한 `@Column`보다 앞선다. `@FieldResult`를 한 번이라도 사용하면 전체 필드를 매핑해야 한다.
- 엔티티 조회시 컬럼명이 중복될 때도 `@FieldResult`를 사용한다.
```java
  // SQL
  String sql = "SELECT o.id AS order_id, 
	  o.quantity AS order_quantity, 
	  o.item AS order_item, i.name AS item_name "
    + "FROM Order o, Item i 
    + WHERE (order_quantity > 25) AND (order_item = i.id)"

  // 매핑 정보
  @SqlResultSetMapping(name = "OrderResults",
    entities = {
        @EntityResult(entityClass=com.acme.Order.class, fields = {
            @FieldResult(name="id", column="order_id"),
            @FieldResult(name="quantity", column="order_quantity"),
            @FieldResult(name="item", column="order_item")})},
    columns = {
        @ColumnResult(name="item_name")})
```

### 결과 매핑 어노테이션
> [!summary]+ 
> + @SqlResultSetMapping
> + @EntityResult
> + @FieldResult
> + @ColumnResult
![[nativesqlannotation.png]]