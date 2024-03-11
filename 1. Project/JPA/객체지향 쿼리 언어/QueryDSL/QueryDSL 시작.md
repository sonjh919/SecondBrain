#jpa #QueryDSL


## QueryDSL 시작
### QueryDSL 설정
[[build.gradle]]에 다음과 같이 추가한다. 버전은 달라질 수 있다.
```java
implementation 'com.querydsl:querydsl-jpa:5.0.0:jakarta'
annotationProcessor 'com.querydsl:querydsl-apt:5.0.0:jakarta'
annotationProcessor "jakarta.annotation:jakarta.annotation-api"
annotationProcessor "jakarta.persistence:jakarta.persistence-api"
```

> [!info]+ 
> + querydsl-jpa : QueryDSL JPA 라이브러리
> + querydsl-apt : 쿼리 타입(Q)을 생성할 때 필요한 라이브러리
> + jakarta.annotation-api : QueryDSL APT가 Annotation을 처리할 때 사용
> + jakarta.persistence-api : 자바 객체와 DB간 매핑을 위한 표준 제공


### QueryDSL 사용법
1. JPAQuery 객체를 생성한다. 이때 [[EntityManager]]를 생성자에 넘겨준다.
2. 사용할 쿼리 타입(Q)를 생성한다. 생성자에는 별칭([[Alias]])을 준다.([[JPQL]])에서 사용한다.
3. 로직에 맞는 [[검색 조건 쿼리]]를 작성한다.
4. 결과를 조회한다.

```java
public void queryDSL(){
	EntityManager em = emf.createEntityManager();

	JPAQuery query = new JPAQuery(em);
	QMember qMember = new QMember("m"); // 생성되는 JPQL의 별칭이 m
	List<Member> members = 
		query.from(qMember)
			.where(qMember.name.eq("회원1"))
			.orderBy(qMember.name.desc())
			.list(qMember);
}
```

### 결과 조회
- 쿼리 작성이 끝나고 결과 조회 메소드를 호출하면 실제 데이터베이스를 조회한다.
- 보통 uniqueResult(), list()를 사용한다. 파라미터로 프로젝션 대상을 넘겨준다.

> [!note]+ 결과 조회 메서드
> + uniqueResult() : 조회 결과가 한 건일 때 사용한다. 결과가 없으면 null을 반환, 하나 이상이면 NonUniqueResultException 예외를 발생시킨다.
> + singleResult() : uniqueResult()와 같지만 결과가 하나 이상이면 처음 데이터를 반환한다.
> + list() : 결과가 하나 이상일 때 사용한다. 결과가 없으면 빈 컬렉션을 반환한다.