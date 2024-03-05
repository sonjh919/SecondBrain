#jpa #Annotation 

## @Table
+ 엔티티 클래스에 매핑할 테이블 정보를 알려준다.

```java
@Entity
@Table(name="MEMBER")
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

> [!note]+ catalog
> catalog 기능이 있는 DB에서 catalog를 매핑한다.

> [!note]+ schema
> schema 기능이 있는 DB에서 schema를 매핑한다.

> [!note]+ uniqueConstraints
 > + DDL 생성 시에 유니크 제약조건을 만든다.
 > + 2개 이상의 복합 유니크 제약 조건도 만들 수 있다.
 > + 스키마 자동 생성 기능을 사용해서 DDL을 만들 때만 사용한다.
 > ```@Table(name="MEMBER"), uniqueConstraints = { @UniqueConstraint(
 > 	name = "NAME_AGE_UNIQUE",
 > 	columnNames = {"NAME", "AGE"} )})

