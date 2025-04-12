---
title: record
date: 2023-12-29 14:11
categories:
  - JavaAPI
  - java.lang
tags:
  - JavaAPI
  - Java
  - javalang
image: 
path:
---
#Java #JavaAPI #javalang 

## record
+ Java 14부터 도입된 record 클래스는 **불변 데이터를 객체 간에 전달하는 데이터 클래스를 정의할 때 코드를 간결히 작성할 수 있게 도와주는 역할**을 한다.

```java
record 레코드명(컴포넌트1, 컴포넌트2, ...) { }
```

## record의 특징
> [!info]+ 
> 1. 필드별 **getter가 자동으로 생성**된다. (getter랑 표현 다른건 좀...)
> 2. **불변 데이터**를 다룬다.(final로 선언된다)
> 3. **equals, hashcode, toString을 자동으로 생성**한다.
> 4. **기본 [[🟠 Project/JAVA/클래스&객체/생성자|생성자]]는 제공하지 않는다.**
> 5. 기본적으로 private로 선언되므로, 접근 제어자를 명시하지 않아도 된다.
> 6. 레코드는 다른 클래스를 [[🟠 Project/JAVA/클래스&객체/상속]]받을 수 없다.
> 7. [[제네릭]] 레코드를 만들 수 있다.
> 8. 레코드는 클래스처럼 인터페이스를 구현할 수 있다.
> 9. [[new]] 키워드를 사용하여 레코드를 인스턴스화할 수 있다.
> 10. 레코드나 레코드의 각 컴포넌트에 애노테이션을 달 수 있다.
> 11. 별도의 초기화 로직이 필요하면 생성자를 따로 만들 수도 있다.