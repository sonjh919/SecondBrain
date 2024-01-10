---
title: Collection
date: 2023-12-30 11:22
categories:
  - JavaAPI
  - java.util
tags:
  - JavaAPI
  - Java
  - javautil
  - Collection
image: 
path:
---

## Java.util.Collection
+ 자료구조와 알고리즘들이 미리 구현되어 있는 패키지
+ [[배열]]이 가진 고정 크기의 단점을 극복하기 위해 객체들을 쉽게 **추가/수정/삭제/반복/순회/검색** 등의 기능을 할 수 있는 **가변 크기**의ㅌ 컨테이너이다.
+ 컬렉션의 요소로는 **객체만 가능**하지만, 기본 타입의 값이 들어오면 auto boxing에 의해 [[Wrapper]] 클래스로 변환된다.
+ [[제네릭]] 기법으로 구현되어 있다.

## Collection의 구조
+ Collection 위에는 Iterable(순회가능)이라는 속성을 상속받고 있다.

+ [[List]]
+ [[Project/Java API/java.util/Collection/Queue|Queue]]
+ [[Set]]
![[collection.png]]
