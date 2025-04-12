#jpa #Annotation 

## @MappedSuperclass
[[상속 관계 매핑]]은 부모 클래스와 자식 클래스를 모두 데이터베이스 테이블과 매핑한다. 부모 클래스는 테이블과 매핑하지 않고 부모 플래스를 상속받는 자식 클래스에게 매핑 정보만 제공하고 싶을 경우 사용한다.

MappedSuperclass는 추상 클래스와 비슷한데, [[@Entity]]는 실제 테이블과 매핑되지만, @MappedSuperclass는 **실제 테이블과는 매핑되지 않는다.** 단순히 매핑 정보를 상속할 목적으로만 사용한다.

```java
@MappedSuperClass // @Entity 대신 사용
public abstract class BaseEntity { 
	
    @Id
    @GeneratedValue
    private Long id;
    private String name;
    
    ...
}

@Entity
public class Member extends BaseEntity {
	
    // ID, name 상속
    private String email;
    
    ...
}

@Entity
public class Seller extends BaseEntity {

	// ID, name 상속
    private String shopName;
	
    ...
}
```

> [!tip]+ 
> @MappedSuperclass로 지정한 클래스는 엔티티가 아니므로 em.find()나 JPQL에서 사용할 수 없다.

> [!tip]+ 
> 이 클래스를 직접 생성해 사용할 일은 거의 없으므로 추상 클래스로 만들자.
