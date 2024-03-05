#jpa #Annotation 

## @Id
+ 엔티티 클래스의 필드를 테이블의 **기본 키(PK)** 에 매핑한다. @Id가 사용된 필드를 **식별자 필드**라고도 한다.
+ [[@GeneratedValue]]를 이용하여 기본 키를 직접 할당하는 대신 JPA가 제공하는 기본 키 생성 전략을 사용할수 있다.

```java
@Entity
@Table(name="MEMBER")
public class Member {
	@id
	@Column(name="ID")
	private String id;
}
```