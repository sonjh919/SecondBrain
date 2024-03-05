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
### name
table의 이름을 정한다. 이를 생략하면 클래스 이름을 테이블 이름으로 매핑한다.(정확히는 엔티티 이름을 사용한다.)
