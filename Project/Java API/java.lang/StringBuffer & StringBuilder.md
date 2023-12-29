---
title: StringBuffer & StringBuilder
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

## 🌈 StringBuffer & StringBuilder
두 클래스는 문자열을 연산(**추가 또는 변경**)할 때 주로 사용하는 자료형이다.

물론 String 자료형으로도 문자열 연산이 가능하지만, [[String]]은 [[불변 클래스]]이기 때문에 연산을 많이 할수록 **공간의 낭비되고 속도가 매우 느려진다는 단점**이 있다.

그래서 Java에서는 StringBuffer와 StringBuilder는 문자열 연산을 전용으로 하는 자료형을 따로 만들어 제공해준다. **두 클래스의 사용 방법은 같다.** 두 클래스는 내부에 **버퍼(buffer)** 라고 하는 독립적인 공간을 가지게 되어, 효율적인 공간 처리와 연산 속도가 빠른 장점이 있다.

버퍼는 [[Heap Area]]에 할당된다.

기본적으로 StringBuffer의 버퍼 크기의 기본값은 **16개의 문자**를 저장할 수 있는 크기이며, 생성자를 통해 그 크기를 별도로 설정할 수도 있다. 문자열 연산 중 할당 크기를 넘겨도 자동으로 증강시켜주지만 효율이 떨어질 수도 있으니 넉넉하게 잡자.


## 🌈 StringBuffer vs StringBuilder
둘의 차이점은 딱 하나인데, 바로 **멀티 [[Thread]]에서 안전하냐**의 차이이다.
StringBuffer는 메서드에서 synchronized 키워드를 사용하기 때문에 동기화를 지원하여 멀티 Thread 환경에서도 안전하게 동작할 수 있다. 하지만 그만큼 성능은 StringBuilder가 더 뛰어나다고 할 수 있다.(아주 조금..!)

따라서 web이나 소켓환경 등 비동기로 작동하는 경우가 많을 때는 StringBuffer를 사용하는 것이 더 좋고, 멀티 Thread를 쓰지 않으면서 성능을 중요시하면 StringBuilder를 사용하자. 하지만 대부분의 현업에서는 멀티 Thread로 돌아가기 때문에 **문자열 추가 연산이 적으면 String, 많으면 StringBuffer를 사용하자!**