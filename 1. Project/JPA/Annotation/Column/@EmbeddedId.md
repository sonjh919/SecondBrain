#jpa #Annotation 

## @EmbeddedId
[[@IdClass]]가 데이터베이스에 맞춘 방법이라면 @EmbeddddId는 조금 더 객체지향적인 방법이다. 복합 기본키를 엔티티 내부에 추가하여 정의한다.

### 비식별 관계

```java
@Entity
public class Parent {
    @EmbeddedId
    private ParentId id;
}

@Embeddable
@NoArgsConstructor
@EqualsAndHashCode
public class ParentId implements Serializable {
	@Column(name = "PARENT_ID1)
    private String id1;

	@Column(name = "PARENT_ID2)
    private String id2;
}

```


> [!info]+ 
> @EmbeddedId를 적용한 식별자 클래스는 @Embeddable 어노테이션을 추가해주어야 한다.

### 식별 관계
@EmbeddedId로 식별 관계를 구성할 때는 [[@ManyToOne]]과 @MapsId를 사용해야 한다.

```java
@Entity
public class Parent {
    @Id    @Column(name = "PARENT_ID)
    private String id;
	private String name;
	...
}

@Entity
@IdClass(ChildId.class)
public class Child {
	@EmbeddedId
	private ChildId id;

	@MapsId("parentId") // ChildId.parentId mapping
	@ManyToOne
	@JoinColumn(name = "PARENT_ID")
	public Parent parent;
	
	private String name;
	...
}

@NoArgsConstructor
@Embeddable
@EqualsAndHashCode
public class ChildId implements Serializable {
	private String parentId;  // @MapsId("parentId") mapping

	@Column(name = "CHILD_ID")
	private String id;
}
```

> [!note]+ @MapsId
> 외래 키와 매핑한 연관관계를 기본 키에도 매핑하겠다는 뜻이다. 
> 
> **속성값**
> @EmbeddedId를 사용한 식별자 클래스의 기본 키 필드를 지정하면 된다.