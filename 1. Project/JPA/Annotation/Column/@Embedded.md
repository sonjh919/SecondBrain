#jpa #Annotation 

## @Embedded
같은 유형의 타입을 묶어서 새로운 타입을 정의할 때 사용한다.

```java
@Entity
public class Member {
  ...
  @Embedded
  private Address homeAddress;
  @Embedded
  private Address workAddress;
  ...
}

```

엔티티가 상세한 데이터를 그대로 가지는 것은 객체지향적이지 않으며 응집도만 떨어트린다. 같은 유형의 데이터를 묶을 수 있다면 코드가 더 명확해진다는 장점이 있다.

```java
@Embeddable
@NoArgsConstructor
public class Address {
  private String city;
  private String street;
  private String zipcode;
  ...
}
@Embeddable
@NoArgsConstructor
public class Period {
  private LocalDateTime startDate;
  private LocalDateTime endDate;
  ...
}

```