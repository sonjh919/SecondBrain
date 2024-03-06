#jpa #Annotation 

## @EmbeddedId
[[@IdClass]]가 데이터베이스에 맞춘 방법이라면 @EmbeddddId는 조금 더 객체지향적인 방법이다. 복합 기본키를 엔티티 내부에 추가하여 정의한다.

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
