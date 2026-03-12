#jpa #Annotation 

## @Embeddable
[[@Embedded]] 또는 [[@EmbeddedId]]를 이용해 복합 속성을 정의하고, 이를 @Embeddable을 이용하여 해당 클래스에 매핑한다는 것을 나타낸다.

```java
@Embeddable
public class Address {
    private String street;
    private String city;
    private String zipCode;

    // Getters and setters
}

@Entity
public class Customer {
    @Id
    private Long id;
    
    private String name;
    
    @Embedded
    private Address address;

    // Getters and setters
}

```