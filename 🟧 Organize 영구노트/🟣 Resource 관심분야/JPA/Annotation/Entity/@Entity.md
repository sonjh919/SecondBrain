#jpa #Annotation 

## @Entity
JPA를 사용해서 테이블과 매핑할 클래스는 @Entity를 필수로 붙여야 한다. 이렇게 @Entity가 사용된 클래스를 **엔티티 클래스**라고 한다.

```java
@Entity
public class Member {
...
}
```

## 속성
> [!note]+ name
> JPA에서 사용할 엔티티 이름을 지정한다. 보통 기본값인 클래스 이름을 사용한다.
> 
> **기본값**
> 설정하지 않으면 클래스 이름을 그대로 사용한다.

## @Entity 적용 시 주의사항
> [!caution]+ 
> + 기본 생성자는 필수이다.
> + final 클래스, enun, interface, inner 클래스에는 사용할 수 없다.
> + 저장할 필드에 final을 사용할 수 없다.
