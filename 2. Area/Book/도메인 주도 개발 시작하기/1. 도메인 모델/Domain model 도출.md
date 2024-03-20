#Architecture #DDD #개발서적 

## Domain model 도출
도메인에 대한 이해 없이 코딩을 시작할 수는 없다. 도메인 모델링에서 기본이 되는 작업은 다음과 같다.

> [!important]+ 
> 모델을 구성하는 핵심 **구성요소, 규칙, 기능**을 찾는 것

그리고 이 과정은 요구사항에서 출발한다.

## Domain model 도출 예시
+ 주문 도메인과 관련하여 다음과 같은 요구사항이 있다고 가정해보자.

> [!summary]+ 요구사항
> + 최소 한 종류 이상의 상품을 주문해야 한다.
> + 한 상품을 한 개 이상 주문할 수 있다.
> + 총 주문 금액은 각 상품의 구매 가격 합을 모두 더한 금액이다.
> + 각 상품의 구매 가격 합은 상품 가격에 구매 개수를 곱한 값이다.
> + 주문할 때 배송지 정보를 반드시 지정해야 한다.
> + 배송지 정보는 받는 사람 이름, 전화번호, 주소로 구성된다.
> + 출고를 하면 배송지 정보를 변경할 수 없다.출고 전에 주문을 취소할 수 있다.
> + 고객이 결제를 완료하기 전에는 상품을 준비하지 않는다.

여기에서 Order 관련 기능을 메서드로 추가해보자.

### 1. 기능 추가
+ **제공하는 기능**을 메서드로 추가할 수 있다.

> [!info]+ 
> + 출고 상태로 변경하기
> + 배송지 정보 변경하기
> + 주문 취소하기
> + 결제 완료하기

```java
public class Order {
	public void changeShipped() { ... } //출고 상태로 변경
	public void changeShippingInfo(ShippingInfo newShipping) { ... } //배송지 정보 변경
	public void cancel() { ... } //주문 취소
	public void completePayment() { ... } //결제 완료
}
```

### 2. 데이터 구성 기능 추가
+ 다음 요구사항은 주문 항목이 **어떤 데이터로 구성**되는지 알려준다.

> [!info]+ 
> + 한 상품은 한 개 이상 주문 가능
> + 각 상품의 구매 가격 합은 상품 가격에 구매 개수를 곱한 값

+ OrderLine은 주문할 상품, 상품 가격, 구매 개수를 포함한다. 따라서 OrderLine은 Value 타입이라 할 수 있다.
```java
public class OrderLine {
	private Product product;
	private int price;
	private int quantity;
	private int amount;

	...
}
```

### 3. 기능과 데이터와의 관계
+ 다음 요구사항은 Order와 OrderLine과의 관계를 알려준다.

> [!info]+ 
> + 최소 한 종류 이상의 상품을 주문해야 한다.
> + 총 주문 금액은 각 상품의 구매 가격 합을 모두 더한 금액이다.

+ 요구사항에 따르면 Order는 최소 한 개 이상의 OrderLine을 포함한다. 또한 총 추문 금액은 OrderLine에서 구할 수 있다.

```java
public class Order {
	private List<OrderLine> orderLines;
	private int totalAmounts;

	private void setOrderLines(List<OrderLine> orderLines) { ... }
	private void verifyAtLeastOneOrMoeOrderLines(List<OrderLine> orderLines) { ... }
	private void calculateTotalAmounts() { ... }

	...
}
```