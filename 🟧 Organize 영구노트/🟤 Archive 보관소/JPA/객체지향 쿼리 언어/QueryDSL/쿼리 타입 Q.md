#jpa #QueryDSL

## 쿼리 타입 Q
QueryDSL은 JPQL을 사용하여 유형 안전한 쿼리를 작성할 수 있도록 지원하는 라이브러리이다. QueryDSL은 **엔티티와 관련된 쿼리를 Java 코드로 작성**할 수 있게 해주는데, 이를 가능하게 하는 것이 바로 **쿼리 타입**(Query Type)이다.

쿼리 타입(Query Type)은 엔티티의 속성을 사용하여 쿼리를 작성하고 실행할 수 있게 해주는 클래스이다. 이 클래스는 QueryDSL이 코드 생성 과정에서 엔티티 클래스를 분석하여 생성된다. 이렇게 생성된 쿼리 타입 클래스는 엔티티의 속성을 자바 코드로 사용하여 쿼리를 작성할 수 있도록 도와준다.

> [!example]+ 
> 쿼리 타입 클래스의 이름은 보통 엔티티 클래스의 이름 뒤에 `Q`를 붙여서 지어진다.
> 
> `Customer` → `QCustomer`

### 쿼리 타입 클래스의 장점
> [!summary]+ 장점
> + 컴파일 타임에 **타입 안전성을 보장**한다.
> + IDE의 자동 완성 기능을 활용하여 쿼리를 빠르게 작성할 수 있다.
> + 엔티티의 속성을 직접 참조하기 때문에 오타로 인한 버그를 줄일 수 있다.


## 기본 Q 생성
- 쿼리 타입(Q)은 사용하기 편리하도록 기본 인스턴스를 보관하고 있다.
- 같은 엔티티를 조인하거나 같은 엔티티를 서브쿼리에 사용하면 같은 별칭이 사용되므로 이때는 별칭을 직접 지정해서 사용한다.

> [!example]+ 
```java
// Member Query Type
public class QMember extends EntityPathBase<Member>{
	public static final QMember member = new QMember("member1");
	...
}
```

+ 쿼리 타입은 다음과 같이 사용한다.
```java
  public static final QMember qMember = new QMember("m");     // 직접 지정
  public static final QMember qMember2 = QMember.member;      // 기본 인스턴스 사용
```

+ 쿼리 타입의 기본 인스턴스를 사용하면 import static을 활용하여 코드를 더 간결하게 작성할 수 있다.
```java
import static jpabook.jpashop.domain.QMember.member; // 기본 인스턴스

public void basic(){
	EntityManager em = emf.createEntityManager();

	JPAQuery query = new JPAQuery(em);
	List<Member> members = 
		query.from(qMember)
			.where(qMember.name.eq("회원1"))
			.orderBy(qMember.name.desc())
			.list(qMember);
}
```