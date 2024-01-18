---
title: Wrapper
date: 2023-12-29 21:27
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

## Wrapper
Java에서 [[Area/JAVA/기본 문법/자료형]]은 기본 타입(primitive type)과 참조 타입(reference type)으로 나누어진다. 그런데 프로그래밍 시 **기본 타입의 데이터를 객체로 표현**해야 할 경우가 있는데, 이를 기본 타입을 객체처럼 wrapper(포장한다)고 하여 이와 관련된 클래스들을 Wrapper 클래스라 칭한다. 공식문서를 찾아보니, 실제로 Wrapper 클래스가 존재하는 것은 아니다.

Wrapper 클래스로 포장하는 것을 **박싱(Wrapper)**, 기본 타입으로 다시 포장을 푸는 것은 **언박싱(UnBoxing)** 이라 한다. JDK 1.5 이상부터는 컴파일러가 이를 자동으로 처리해주며, 이것을 Auto Boxing / Auto UnBoxing이라 한다.
## Wrapper 계층도
![[wrapper.png]]