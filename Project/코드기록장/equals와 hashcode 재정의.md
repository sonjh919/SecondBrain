---
title: equals와 hashcode 재정의
date: 2024-01-07 01:43
categories:
  - 코드일기장
tags:
  - Java
  - 코드일기장
image: 
path:
---

## key값이 다르게 인식될 때
키오스크 프로그램을 리팩토링하는 중이었다. 장바구니를 다음과 같이 HashMap으로 구현하고, 상품을 받아 저장하는 코드를 구현 중에 있었다.

#### Product.java
```java
public class Product extends Menu{  
    private final int price;  
  
    public Product(String name, int price, String description) {  
        super(name, description);  
        this.price = price;  
    }  
  
    public int getPrice() {  
        return price;  
    }
}
```

#### Cart.java
```java
public class Cart{  
    private static final Cart cart = new Cart();  
    private Cart(){}  
    public static Cart getInstance(){  
        return cart;  
    }  
  
    private Map<Product, Integer> products = new HashMap<>();  
  
    public void add(Product product) {  
        products.compute(product, (key, value) -> (value == null) ? 1 : value + 1);  
    }
	
	...
}
```

이전에는 모든 상품 종류에 대한 ProductList를 만들어서 진행했었다. 하지만 그러면 무의미한 객체가 너무 많이 생긴다는 생각이 들어 Cart에 들어갈 때 생성하도록 로직을 바꾸었다. 그러더니 문제가 생겼다. 바꾸기 전에는 분명 잘 동작했었는데, 바꾸고 나서 Cart에 같은 객체가 들어와도 다른 객체로 인식하는 것이었다.

## hashCode가 다르면 다른 객체지!
고민하던 도중, 문득 객체가 진짜 같은가에 대한 의문이 생겼다. 이전에는 List를 만들어두고 계속 뽑아 썼기 때문에 상관없었는데, 지금은 그때그때 새로운 객체가 만들어지기 때문에 다를 수도 있다는 생각이 들었다.

확인해본 결과, 역시나 함수의 hashCode가 달랐던 것이었다!!
그렇다.. 우리의 객체는 필드값이 같다고 같은 객체로 생각해주지 않는 것이었다.

## hashCode가 재정의하기
그래서 일단 hashCode를 재정의해보기로 했다. hashCode()는 Object 클래스에 있으므로, 이를 오버라이딩하여 사용할 수 있다.

```java
public int hashCode(){  
    return Objects.hash(super.getName(), price, super.getDescription());  
}
```

## 그래도 안된다..?
이제 한껏 기대감을 가지고 확인해보았는데,, 서로 다른 객체로 인식하는 것은 똑같았다.

## equal도 재정의하자!
우리의 객체가 똑같다고 판단하기 위해서는 hashCode 이외에도 equal도 재정의해야 한다고 한다! equal도 마찬가지로 오버라이딩하여 사용할 수 있다.

```java
@Override  
public boolean equals(Object o){  
	//객체가 동일하다면 true를 리턴하여, 중복저장이 되지 않도록 한다.
    if (this == o) return true;  

	// 객체가 null이거나 클래스 값이 다르면 다른 객체이기 때문에 false를 리턴한다.
    if (o == null || getClass() != o.getClass()) return false;  

	// 멤버값을 비교해보자!
    Product product = (Product) o;  
    
    return Objects.equals(getName(), product.getName()) && price == product.price && Objects.equals(  
            getDescription(), product.getDescription());  
}
```

## 성공!
같은 객체로 받아들이는 것을 확인할 수 있었다.

![[equals와hashcode재정의.png]]