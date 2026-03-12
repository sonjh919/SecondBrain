---
title: DI (Dependency Injection)
date: 2024-01-19 11:32
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring

## DI(Dependency Injection, 의존성 주입)
DI(Dependency Injection)란 **객체를 직접 생성하는 게 아니라 외부에서 생성한 후 넣어주는 방식**이다.
의존성 주입을 통해서 모듈 간의 결합도가 낮아지고 유연성이 높아진다.

![[di.png]]

## DI(의존성 주입)의 세가지 방식
+ 예제에 사용된 인터페이스는 다음과 같다.

```java

interface Food {
    void eat();
}

class Chicken implements Food{
    @Override
    public void eat() {
        System.out.println("치킨을 먹는다.");
    }
}

class Pizza implements Food{
    @Override
    public void eat() {
        System.out.println("피자를 먹는다.");
    }
}
```
### 1. 필드에 직접 주입
+ Food를 Consumer에 **포함** 시키고 Food에 필요한 객체를 주입받아 사용할 수 있다.
```java
public class Consumer {

    Food food;

    void eat() {
        this.food.eat();
    }

    public static void main(String[] args) {
        Consumer consumer = new Consumer();
        consumer.food = new Chicken();
        consumer.eat();

        consumer.food = new Pizza();
        consumer.eat();
    }
}
```

### 2. 메서드 주입
+ set 메서드를 사용하여 필요한 객체를 주입받아 사용할 수 있다.

```java
public class Consumer {

    Food food;

    void eat() {
        this.food.eat();
    }

    public void setFood(Food food) {
        this.food = food;
    }

    public static void main(String[] args) {
        Consumer consumer = new Consumer();
        consumer.setFood(new Chicken());
        consumer.eat();

        consumer.setFood(new Pizza());
        consumer.eat();
    }
}
```

### 3. 생성자를 통한 주입
+ 생성자를 사용하여 필요한 객체를 주입받아 사용할 수 있다.

```java
public class Consumer {

    Food food;

    public Consumer(Food food) {
        this.food = food;
    }

    void eat() {
        this.food.eat();
    }

    public static void main(String[] args) {
        Consumer consumer = new Consumer(new Chicken());
        consumer.eat();

        consumer = new Consumer(new Pizza());
        consumer.eat();
    }
}
```