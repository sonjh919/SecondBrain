#jpa #JPQL

## JOIN
+ JPQL도 JOIN을 지원하는데 SQL의 [[1. Project/Database/RDB/SQL/Join/JOIN|JOIN]]과 기능은 같고 문법만 약간 다르다.
+ JPQL에서는 성능 최적화를 위해 SQL에는 없는 [[FETCH JOIN]]을 지원한다.

## 1. 내부 JOIN
+ 내부 조인은 INNER JOIN을 지원한다.

> [!tip]+ 
> INNER는 생략 가능하다.

```java
String teamName = "팀A";
String query = "SELECT m FROM Member m INNER JOIN m.team t" + "WHERE t.name = :teamName";

List<Member> members = em.createQuery(query, Member.class)
	.setParameter("teamName", teamName)
	.getResultList();
```

+ 이때 생성된 내부 JOIN SQL은 다음과 같다.

```sql
SELECT
	M.ID AS ID,
	M.AGE AS AGE,
	M.TEAM_ID AS TEAM_ID,
	M.NAME AS NAME
FROM
	MEMBER M
	INNER JOIN TEAM T ON M.TEAM_ID=T.ID  -- 연관 필드 : M.TEAM
WHERE
	T.NAME=?
```

내부 JOIN 구문을 보면 SQL과는 살짝 다르게 **연관 필드**를 사용한다.  연관 필드란 **다른 엔티티와 연관관계를 가지기 위해 사용하는 필드**를 말한다.

+ JOIN한 두 개의 엔티티를 조회하는 JPQL은 다음과 같다. 이 때에는 서로 다른 타입의 두 엔티티를 조회했으므로 TypeQuery를 사용할 수 없다. (참고 : [[쿼리 객체]])

```sql
SELECT m, t
   FROM Member m JOIN m.team t
```

### 세타 JOIN
WHERE 절을 사용해서 세타 JOIN을 할 수 있다. 이를 이용하면 **전혀 관계없는 엔티티도 JOIN**할 수 있다.

```sql
-- JPQL
SELECT count(m)
  FROM Member m, Team t
 WHERE m.username = t.name

-- SQL
SELECT COUNT(M.ID)
  FROM MEMBER M CROSS JOIN TEAM T
 WHERE M.USERNAME=T.NAME
```

## 2. 외부 JOIN
외부 JOIN은 다음과 같이 사용한다. OUTER는 보통 생략하여 LEFT JOIN으로 쓰인다.
``
```sql
SELECT m
   FROM Member m LEFT [OUTER] JOIN m.team t
```

### 컬렉션 JOIN
[[일대다]] 관계나 [[다대다]] 관계처럼 [[컬렉션 래퍼]]를 사용하는 곳에 JOIN하는 것을 컬렉션 JOIN이라 한다.

```sql
SELECT t,m
  FROM Team t LEFT JOIN t.members m
```

### JOIN ON절
JPA 2.1부터 JOIN할 때 ON절을 지원한다. 이를 이용하면 JOIN 대상을 필터링하고 JOIN할 수 있다.

> [!tip]+ 
> 내부 JOIN의 ON절은 WHERE절을 사용할 때와 결과가 같으므로 보통 ON절은 외부 JOIN에서만 사용한다.

```sql
-- JPQL
SELECT m,t
  FROM Member m
 LEFT JOIN m.team t ON t.name = 'A' -- JOIN 시점에 필터링

-- SQL
SELECT m.*, t.*
  FROM Member m
  LEFT JOIN Tema t ON m.TEAM_ID=t.id and t.name='A'
```