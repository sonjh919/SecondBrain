#jpa #Annotation 

## @AttributeOverrides
부모로부터 물려받은 매핑 정보를 재정의하기 위해 사용한다. @AttributeOverride를 이용해 재정의하고, @AttributeOverrides를 이용해 묶는다.

```java
@Entity 
@AttributeOverrides({ 
	@AttributeOverride(name = "id", column = @Column(name = "MEMBER_ID"))
	@AttributeOverride(name = "identifier", column = @Column(name = "MEMBER_NAME")) 
})
public calss Member extends BaseEntity {...}
```