---
title: Exception
date: 2023-12-29 14:11
categories:
  - JavaAPI
  - java.lang
tags:
  - JavaAPI
  - Java
  - javalang
  - Throwable
image: 
path:
---

## Exception
+ Java에서 예외(exception)을 나타내는 모든 클래스의 최상위 클래스이다. 이 클래스는 예외 처리와 관련된 모든 예외의 기본적인 기능을 제공한다.
+ 일반적인 예외들을 처리하기 위함이며, 구체적인 예외를 다루기 위해 이 클래스를 상속하여 구체적인 예외 클래스를 만들어 사용한다. 예시로 `IOException`, `IllegalArgumentException` 등이 있다.

### Exception?
+ 예외는 **개발자가 구현한 로직에서 발생한 실수 또는 사용자의 영향**으로 인해 발생한다.
+ 이는 개발자가 미리 예측하여 방지할 수 있기 때문에 상황에 맞는 예외 처리를 해야 한다.
+ 또는 개발자가 **임의로 예외를 던질 수도 있다.**
