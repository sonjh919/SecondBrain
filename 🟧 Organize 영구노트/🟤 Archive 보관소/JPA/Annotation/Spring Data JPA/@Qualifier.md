#jpa #Annotation 

## @Qualifier
사용해야 할 페이징 정보가 둘 이상이면 접두사를 이용하여 구분할 수 있다. 접두사는 스프링 프레임워크가 제공하는 @Qualifier 어노테이션을 사용한다. 그리고 "{접두사명}\_"으로 구분한다.

```java
public String list(
	@Qualifier("member") Pageable memberPageable,
	@Qualifier("order") Pageable orderPageable, ...
)

// ex) /members?member_page=0&order_page=1
```