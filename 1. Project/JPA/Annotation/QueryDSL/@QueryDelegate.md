#jpa #Annotation #QueryDSL 

## @QueryDelegate
+ 쿼리 타입(Query Type)에 사용되는 메서드를 확장하고 커스텀한 쿼리 메서드를 정의할 때 사용된다.

```java
@QueryDelegate(Customer.class)
public class CustomerQueryDelegate {

    public static BooleanExpression isPremiumCustomer(QCustomer customer) {
        return customer.status.eq(CustomerStatus.PREMIUM);
    }
}
```