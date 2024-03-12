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
