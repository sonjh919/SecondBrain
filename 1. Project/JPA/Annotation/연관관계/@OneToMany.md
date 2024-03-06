#jpa #Annotation 

## @OneToMany
일대다([[일대다]])에서 사용하는 매핑이다.

```java
@OneToMany(mappedBy="team")
private List<Member> members = new ArrayList<Member>();
```

## 속성
> [!note]+ mappedBy
> 속성의 값은 **연관관계의 주인인 엔티티의 필드**로 정하면 된다.