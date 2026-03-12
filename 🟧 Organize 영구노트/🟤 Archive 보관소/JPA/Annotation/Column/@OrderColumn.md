#jpa #Annotation 

## @OrderColumn
크게 두 가지 경우에 사용된다.

> [!summary]+ 
> 1. 엔티티 내의 순서가 있는 컬렉션을 매핑할 때
> 2. List 또는 Map의 순서를 데이터베이스에 저장할 때

> [!tip]+ 
> 자바에서는 리스트와 맵의 순서를 보장할 수 있지만, 데이터베이스에 저장된 데이터는 순서를 보장하지 않는다. 따라서 @OrderColumn을 사용하여 순서를 유지하기 위한 열을 데이터베이스에 추가할 수 있다.

+ 이 때 `order_item_index` 열을 새로 만들고, 각 열에는 순서가 저장된다.
```java
@Entity
public class Order {
    @OneToMany
    @OrderColumn(name = "order_item_index")
    private List<OrderItem> orderItems;
}

```