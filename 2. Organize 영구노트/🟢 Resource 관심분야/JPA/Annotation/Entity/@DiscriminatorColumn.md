#jpa #Annotation 

## @DiscriminatorColumn
[[상속 관계 매핑]] 시 부모 클래스에 @DiscriminatorColumn를 사용하여 구분 컬럼을 지정한다. 이 컬럼으로 저장된 자식 테이블을 구분할 수 있다.

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
> [!note]+ name
> 구분 컬럼을 지정한다.
> 
> **기본값**
> DTYPE