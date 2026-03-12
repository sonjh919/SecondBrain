#jpa #Annotation 

## @AttributeOverride
부모로부터 물려받은 매핑 정보를 재정의하기 위해 사용한다. @AttributeOverride를 이용해 재정의하고, @AttributeOverrides를 이용해 묶는다.

### [[상속 관계 매핑]]
```java
@Entity 
@AttributeOverrides({ 
	@AttributeOverride(name = "id", column = @Column(name = "MEMBER_ID"))
	@AttributeOverride(name = "identifier", column = @Column(name = "MEMBER_NAME")) 
})
public calss Member extends BaseEntity {...}
```

### [[@Embedded]] 재정의
```java
@Entity
public class Member {

	@Id @GeneratedValue
	private Long id;
	private String name;

	@Embeded Address homeAddress;
	
	@Embeded
	@AttributeOverrides({
		@AttributeOverride(name="city", column=@Column(name = "COMPANY_CITY")),
		@AttributeOverride(name="street", column=@Column(name = "COMPANY_STREET")),
		@AttributeOverride(name="zipcode", column=@Column(name = "COMPANY_ZIPCODE")),
	})	
Address companyAddress;
}
```

