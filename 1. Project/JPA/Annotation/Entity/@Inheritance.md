#jpa #Annotation 

## @Inheritance
[[상속 관계 매핑]] 시 부모 클래스에 @Inheritance를 사용해야 한다. 속성에 따라 매핑 전략을 지정할 수 있다. [[@DiscriminatorColumn]]과 함께 사용되며, 자식 클래스라면 [[@DiscriminatorValue]]를 사용한다.

```java
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn
public class Item {

    @Id @GeneratedValue
    private Long id;
    
    private String name;
    private int price;
}   
```

## 속성
> [!note]+ strategy
> InheritanceType.JOINED : 조인 전략
> InheritanceType.SINGLE_TABLE : 단일 테이블 전략
> InheritanceType.TABLE_PER_CLASS : 구현 클래스마다 테이블 전략
> 
> **기본값**
> InheritanceType.SINGLE_TABLE
> 