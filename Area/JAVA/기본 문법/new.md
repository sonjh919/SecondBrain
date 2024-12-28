---
title: new
date: 2023-12-28 20:49
categories:
  - Java
  - Java문법
tags:
  - Java
  - Java문법
image: 
path:
---
#Java 

## new 연산자
+ [[Heap Area]]에 메모리 공간을 할당해주고 메모리 주소를 반환한 후 생성자를 실행한다.
+ new 연산자로 생성된 객체는 항상 서로 다른 메모리를 할당하기 때문에 서로 다른 객체로 분류된다.

```java
// [자료형] [참조값저장] = [Heap할당, 인스턴스 생성, 참조값 리턴] [생성자 호출]
클래스 객체변수 = new 클래스();
```