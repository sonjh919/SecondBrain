#jpa #Annotation 

## @QueryHints
```java
QueryHints(value = {@QueryHint(name = "org.hibernate.readOnly", value = true")},
							   forCounting = true)

Page<Member> findByName(String name, Pagable pageable);
```

## 속성
> [!note]+ forCounting
> 반환 타입으로 Page 인터페이스를 적용하면 추가로 호출하는 페이징을 위한 count 쿼리에도 쿼리 힌트를 적용할지를 설정하는 옵션이다.
> 
> **기본값**
> true