---
title: Static
date: 2023-12-28 18:00
categories:
  - Java
  - Java문법
tags:
  - Java
  - Java문법
image: 
path:
---

## Static
- **메모리에 한번 할당되면 프로그램이 종료될 때 해제되는 것**
- Static을 통해 생성된 메서드는 Heap 영역이 아닌 **Method Area의 Static 영역**에 할당된다.([[JVM]] 구조 참조)
- 모든 객체가 공유할 수 있는 메모리
- 객체의 생성 없이 호출이 가능하다.
- 객체 안에 있는 메소드의 경우는 **클래스명.메소드명();** 으로 호출한다.

    ```java
public static void printHello() {
	System.out.println("Hello World!");
}
    ```

