#jpa #SpringDataJPA #QueryDSL 

## Spring Data JPA와 QueryDSL 통합
 [[Spring Data JPA]]는 여러 방법으로 [[QueryDSL]]을 지원한다. 그 중에서는 JPAQueryFactory가 가장 쓰기 편한 것 같다.
 
> [!summary]+ 
> 1. org.springframework.data.querydsl.QueryDslPredicateExecutor
> 2. org.springframework.data.querydsl.QueryDslRepositorySupport
> 3. Spring Data Jpa Custom Repository
> 4. JPAQueryFactory (참고 : [[QueryDSL 시작]])
> 

## 1. QueryDslPredicateExecutor
+ 첫 번째 방법은 Repository에서 QueryDslPredicateExecutor를 상속받는 것이다.

```java
public interface ItemRepository
	extends JpaRepository<Item, Long>, QueryDslPredicateExecutor<Item>{
}
```
### 사용 예제
```java
QItem item = QItem.item;
Iterable<Item> result = itemRepository.findAll(
	item.name.contains("장난감").and(item.price)
)
```

### 한계
QueryDslPredicateExecutor 인터페이스를 보면 QueryDSL을 검색조건으로 사용하면서 스프링 데이터 JPA가 제공하는 페이징과 정렬 기능도 함께 사용할 수 있다. 하지만 기능에 한계가 있다. 예를 들면 join이나 fetch 등이 있다.

따라서 QueryDSL이 제공하는 다양한 기능을 사용하려면 JPAQuery를 직접 사용하거나 Spring Data JPA가 제공하는 **QueryDslRepositorySupport**를 사용하자.

## 2. QueryDslRepositorySupport
QueryDSL이 제공하는 다양한 기능을 사용하려면 JPAQuery객체를 직접 생성해서 사용하면 되는데, 이때 QueryDslRepositorySupport를 상속받아 사용하면 조금 더 편하게 QueryDSL을 사용할 수 있다.

### 1. 사용자 정의 repository
Spring Data JPA가 제공하는 공통 인터페이스는 직접 구현할 수 없기 때문에 사용자 정의 repository를 만든다.
```java
public interface CustomOrderRepository{
	public List<Order> search(OrderSearch orderSearch);
}
```

### 2. QueryDslRepositorySupport 사용
```java
public class OrderRepositoryImpl extends QueryDslRepositorySupport implements CustomOrderRepository{
	public OrderRepositoryImpl() {
	super(Order.class);
	}

	@Override
	public List<Order> search(OrderSearch orderSearch){
		...
	}
}
```

## 3. Spring Data Jpa Custom Repository
Custom Repository를 이용하기 위해서는 다음과 같이 설정해 주어야 한다.
![[customjparepository.png]]

> [!caution]+ 
> 커스텀 클래스 구현 시 반드시 'Interface 이름 + Impl'로 만들어야 한다.