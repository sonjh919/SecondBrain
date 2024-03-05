#jpa #Annotation 

## @Id
엔티티 클래스의 필드를 테이블의 **기본 키(PK)** 에 매핑한다. @Id가 사용된 필드를 **식별자 필드**라고도 한다.

```java
@Entity
@Table(name="MEMBER")
public class Member {
	@id
	@Column(name-"ID")
	private String id;
}
```