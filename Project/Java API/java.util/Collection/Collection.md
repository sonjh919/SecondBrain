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
image: 
path:
---

## 📌 Java.util.Collection
+ 자료구조와 알고리즘들이 미리 구현되어 있는 패키지
+ [[배열]]이 가진 고정 크기의 단점을 극복하기 위해 객체들을 쉽게 삽입, 삭제, 검색할 수 있는 **가변 크기**의 컨테이너이다.
+ 컬렉션의 요소로는 **객체만 가능**하지만, 기본 타입의 값이 들어오면 auto boxing에 의해 [[Wrapper]] 클래스로 변환된다.
+ [[제네릭]] 기법으로 구현되어 있다.

### 🌈 Collection의 구조
![](https://velog.velcdn.com/images/sonjh919/post/ef302ae1-ca7b-4ecd-a814-ad757ab199b2/image.png)


### 🌈 List
+ 리스트(List)는 배열과 비슷하지만 훨씬 편리한 자료형이다.
+ 가장 큰 차이점은 **배열은 크기가 정해져 있지만 리스트는 변한다는 데 있다.**
+ 리스트 자료형에는 [ArrayList](https://velog.io/@sonjh919/Java.util.Arraylist), Vector, LinkedList 등이 있다.

### 🌈 Map
+ 맵(Map) 은 대응 관계를 쉽게 표현할 수 있게 해주는 자료형이다.
+ 리스트나 배열처럼 순차적으로 요소값을 구하지 않고 키(key)를 이용해 값(value)를 얻는다.
+ 사전(dictionary)와 비슷하다.
+ [HashMap](https://velog.io/@sonjh919/Java.util.HashMap), LinkedHashMap, TreeMap 등이 있다.

> 💡 **HashMap, LinkedHashMap, TreeMap**
HashMap : 순서에 의존하지 않고 key로 value를 가져온다.
LinkedHashMap : 입력된 순서대로 데이터를 저장한다.
TreeMap : 입력된 key의 오름차순으로 데이터를 저장한다.

### 🌈 Set
+ 집합과 관련된 것들을 쉽게 처리하기 위해 만든 자료형이다.
+ **중복을 허용하지 않는다.**
+ **순서가 없다.(unordered)**
+ [HashSet](https://velog.io/@sonjh919/Java.util.HashSet), TreeSet, LinkedHashSet 등이 있다.

> 💡 **HashSet, LinkedHashSet, TreeSet**
HashSet : 순서가 없다.
LinkedHashMap : 값을 입력한 순서대로 정렬한다.
TreeMap : 값을 오름차순으로 정렬해 저장한다.

---

## 📌 Array vs ArrayList
||Array|ArrayList|
|---|---|---|
|길이|고정 길이|가변 길이|
|메모리|유지|추가시 재할당|
|제네릭|x|O|
제일 큰 차이점은 Array는 **고정 길이**이고, ArrayList는 **가변 길이**이다. 그래서 실제 사용할 때에는 ArrayList가 훨씬 간편하다. 또한 ArrayList는 제네릭을 사용하기 때문에 타입 안정성이 더욱 올라가고 코드를 재사용할 수 있기 때문에 클린 코드를 만들기 더 쉽다는 생각이 들었다. 메모리 측면에서 봤을 때 ArrayList는 요소가 추가될 때 메모리를 재할당하기 때문에 Array가 좀 더 효율적이라고 할 수 있지만, 앞의 두 가지 이유 때문에 ArrayList를 사용하는 것이 더 맞다고 생각된다.

## 📌 Vector vs ArrayList
Vector와 ArrayList는 가변 크기의 배열을 구현한 클래스로 거의 비슷하다. 크게 다른 점은 ArrayList는 스레드 간에 동기화를 지원하지 않기 때문에, 다수의 스레드가 동시에 접근할 때 ArrayList의 데이터가 훼손될 우려가 있다. 하지만 Vector는 호환성 때문에 남겨둔 것이고 ArrayList가 개선된 버전이기 때문에 웬만해서는 **ArrayList 사용을 권장**한다.



+ List
+ Set
+ Queue