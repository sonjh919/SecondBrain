#Architecture #DDD #Book

## Aggregate를 팩토리로 사용하기
온라인 쇼핑몰에서 고객이 여러 차례 신고를 해서 특정 상점이 더 이상 물건을 등록하지 못하도록 차단한 상태라고 해보자. 상품 등록 기능을 구현한 응용 서비스는 다음과 같이 상점 계정이 차단 상태가 아닌 경우에만 상품을 생성하도록 구현할 수 있을 것이다.

```java
public class RegisterProductService {
	public ProductId registerNewProduct(NewProductRequest req) {
		Store account = accountRepository.findStoreById(req.getStoreId());
		checkNull(account);
		if (!account.isBlocked()) {
			throw new StoreBlockedException();
		}
		ProductId id = productRepository.nextId();
		Product product = new Product(id, account.getId(), ...);
		productRepository.save(product);
		return id;
	}
}
```

코드가 나빠 보이지는 않지만 **중요한 도메인 로직 처리가 응용 서비스에 노출**되었다. Store가 Product를 생성할 수 있는지 여부를 판단하고 Product를 생성하는 것은 논리적으로 하나의 도메인 기능인데 이 **도메인 기능을 응용 서비스에서 구현**하고 있는 것이다. 이는 Product를 생성하는 기능을 Store 애그리거트에 옮겨보자.

```java
public class Store {
	public Product createProduct(ProductId id, ... ) {
		if (!account.isBlocked()) {
			throw new StoreBlockedException();
		}
		return new Product(id, account.getId(), ...);
	}
}
```

> [!check]+ 
> Store 애그리거트의 createProduct()는 Product 애그리거트를 생성하는 **팩토리 역할**을 한다.

이제 Product 생성 가능 여부를 확인하는 도메인 로직을 변경해도 도메인 영역의 Store만 변경하면 되고 응용 서비스는 영향을 받지 않는다. 도메인의 응집도도 높아졌다. 이게 바로 애그리거트를 팩토리로 사용할 때 얻을 수 있는 장점이다.

> [!note]+ 
> 애그리거트가 갖고 있는 데이터를 이용해서 다른 애그리거트를 생성해야 한다면 애그리거트에 팩토리 메서드를 구현하는 것을 고려해보자.
> 참고 : [[Factory Method Pattern]]