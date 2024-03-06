#jpa #Annotation 


## @IdClass
[[복합 키]]를 매핑할 때 사용한다. 별도의 식별자 클래스를 만든 후 @IdClass를 이용해 식별자 클래스를 지정하면 된다.

### 비식별 관계
```java
@Entity
@IdClass(ParentId.class)
public class Parent {
    @Id
    @Column(name = "PARENT_ID1)
    private String id1;

    @Id
    @Column(name = "PARENT_ID2)
    private String id2;
}

@NoArgsConstructor
@EqualsAndHashCode
public class ParentId implements Serializable {
    private String id1;
    private String id2;
}

```

### 식별 관계
```java
@Entity
public class Parent {
    @Id    @Column(name = "PARENT_ID)
    private String id;
	private String anme;
	...
}

@Entity
@IdClass(ChildId.class)
public class Child {
	@Id
	@ManyToOne
	@JoinColumn(name -= )
}				   
```