---
title: Has-A와 IS-A
date: 2024-01-02 15:52
categories:
  - Java
  - Class&Object
tags:
  - Java
  - Java문법
image: 
path:
---

## Has-A (포함 관계)
- "Has-a" 관계는 객체가 다른 객체를 포함하고 있는 관계를 나타낸다.
- 이 관계에서는 한 객체가 다른 객체를 소유하거나 그 객체를 사용한다. 즉, 객체 A가 객체 B를 포함하고 있다.
- 예를 들어, 자동차는 엔진을 가지고 있다. 자동차 클래스는 엔진 클래스의 인스턴스를 포함하고 있으므로 자동차는 엔진을 "가지고 있다"고 할 수 있다.

```java
class Engine {
    // 엔진 관련 속성과 메서드
}

class Car {
    private Engine engine; // Car 클래스가 Engine 클래스를 포함하고 있음
    // Car 클래스의 다른 속성과 메서드
}

```

## Is-A (상속 관계)
- "Is-a" 관계는 [[상속]] 관계를 나타낸다.
- 이 관계에서는 한 클래스가 다른 클래스를 상속받아 확장하는 관계를 나타낸다. 즉, 클래스 A가 클래스 B의 일종이 된다.
- 예를 들어, 사람 클래스는 동물 클래스의 일종이므로 사람은 동물 "이다"라고 할 수 있다.

```java
class Animal {
    // 동물 관련 속성과 메서드
}

class Person extends Animal {
    // Person 클래스의 다른 속성과 메서드
}

```