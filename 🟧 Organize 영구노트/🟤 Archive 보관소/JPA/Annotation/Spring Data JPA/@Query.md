#jpa #Annotation 

## @Query
실행할 메소드에 [[Named 정적 쿼리]]를 직접 작성한다. 따라서 이름 없는 Named쿼리라 할 수 있다. [[JPA NamedQuery]]처럼 어플리케이션 실행 시점에 문법 오류를 발견할 수 있는 장점이 있다.

```java
public interface MemberRepository extends JpaRepository<Member, Long>{

	@Query("select m from Member m where m.username = ?1")
	Member findByUsername(String username);
}
```

+ [[네이티브 SQL]]을 사용하려면 @Query 어노테이션에 nativeQuery = true를 설정한다.
```java
public interface MemberRepository extends JpaRepository<Member, Long>{

	@Query("select m from Member m where m.username = ?0",
		nativeQuery = true)
	Member findByUsername(String username);
}
```

> [!caution]+ 
> Spring Data JPA가 지원하는 [[파라미터 바인딩]]을 사용하면 JPQL은 위치 기반 파라미터를 1부터 시작하지만, 네이티브 SQL은 0부터 시작한다.


> [!tip]+ 
> + 코드 가독성과 유지보수를 위해 이름 기반 파라미터 바인딩을 사용하도록 하자.
> ```java
> public interface MemberRepository extends JpaRepository<Member, Long>{
> 
> 	@Query("select m from Member m where m.username = ?1")
> 	Member findByUsername(String username);
> }
> ```

