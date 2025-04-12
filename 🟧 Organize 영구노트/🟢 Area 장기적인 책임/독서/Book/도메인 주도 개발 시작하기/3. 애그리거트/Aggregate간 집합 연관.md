#Architecture #DDD #Book

## 1-N([[일대다]]) 연관
개념적으로 존재하는 애그리거트 간의 1:N 연관을 실제 구현에 반영하는것이 요구사항을 충족하는 것과 상관없는 경우가 종종 있다. 특정 카테고리에 있는 상품 목록을 보여주는 요구사항을 생각해보자.

> [!example]+ 
> Category가 연관된 Product를 값으로 갖는 컬렉션을 필드로 정의할 수 있다.

```java
public class Category {
	private Set<Product> products;

	public List<Product> getProducts(int page, int size) {
		List<Product> sortedProducts = sortById(Products);
		return sortedProducts.subList((page - 1) * size, page * size);
	}
}
```

이 코드를 실제 DBMS와 연동해서 구현하면 Category에 속한 모든 Product를 조회하게 된다. Product 개수가 수백에서 수만 개 정도로 많다면 이 코드를 실행할 때마다 실행 속도가 급격히 느려져 성능에 심각한 문제를 일으킬 것이다. 이는 1:N(일대다) 연관이더라도 N:1([[다대일]])로 연관지어 구하면 해결할 수 있다.

```java
public class ProductListService {
	public Page<Product> getProductOfCategory(
		Long categoryId, int page, int size
	) {
		Category category = categoryRepository.findById(categoryId);
		checkCategory(category);
		
		List<Product> products = 
			productRepository.findByCategoryId(category.getId(), page, size);
			
		int totalCount = productRepository.countsByCategoryId(category.getId());
		
		return new Page(page, size, totalCount, products);
	}
}
```

> [!tip]+ 
> 개념적으로는 애그리거트 간에 1-N 연관이 있더라도 성능 문제 때문에 실제 구현에 반영하지는 않는다.

## M-N([[다대다]]) 연관
M:N 연관은 개념적으로 양쪽 애그리거트에 컬렉션으로 연관을 만든다. RDBMS를 이용해서 M:N 연관을 구현하려면 조인 테이블을 사용한다.

![[mn.png]]

```java
@Entity
@Table(name = "product")
public class Product {
	@EmbeddedId
	private ProductId id;

	@ElementCollection
	@CollectionTable(name = "product_category",
							joinColumns = @JoinColumn(name = "product_id"))
	private Set<CategoryId> categoryIds;
```


> [!tip]+ 
> 목록이나 상세 화면과 같은 조회 기능은 조회 전용 모델을 이용해서 구현하는 것이 좋다.([[CQRS]])