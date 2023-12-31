---
title: List
date: 2023-12-31 12:29
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

## 🌈 List
+ 리스트(List)는 배열과 비슷하지만 훨씬 편리한 자료형이다.
+ 가장 큰 차이점은 **배열은 크기가 정해져 있지만 리스트는 변한다는 데 있다.**

### 📌 ArrayList
+ **크기를 동적으로 조정**할수 있는 대표적인 배열 기반의 리스트이다.
+ 내부적으로 배열을 사용하여 요소를 저장하며, 요소를 추가하거나 삭제할 때 크기가 동적으로 조정된다.
+ 요소의 삽입과 삭제가 빈번하지 않고, 검색이 많이 이뤄지는 경우에 유용하다.
### 📌 LinkedList
+ **이중 연결 리스트를 기반으로 한 리스트 구현체**이다.
+ 요소 간의 연결 관계를 유지하며, 요소의 삽입과 삭제가 빠르지만 검색 성능은 ArrayList보다 떨어진다.
### 📌 Vector
+ ArrayList와 유사한 동적 배열 구현체이다.
+ ArrayList와 달리 [[Thread]]에 안전성이 필요할 경우에 사용 가능하지만, 동기화 오버헤드로 인해 ArrayList보다는 성능이 떨어질 수 있다.
### 📌 Stack

## 📌 Array vs ArrayList

|.|Array|ArrayList|
|---|---|---|
|길이|고정 길이|가변 길이|
|메모리|유지|추가시 재할당|
|제네릭|x|O|
제일 큰 차이점은 Array는 **고정 길이**이고, ArrayList는 **가변 길이**이다. 그래서 실제 사용할 때에는 ArrayList가 훨씬 간편하다. 또한 ArrayList는 제네릭을 사용하기 때문에 타입 안정성이 더욱 올라가고 코드를 재사용할 수 있기 때문에 클린 코드를 만들기 더 쉽다는 생각이 들었다. 메모리 측면에서 봤을 때 ArrayList는 요소가 추가될 때 메모리를 재할당하기 때문에 Array가 좀 더 효율적이라고 할 수 있지만, 앞의 두 가지 이유 때문에 ArrayList를 사용하는 것이 더 맞다고 생각된다.

## 📌 Vector vs ArrayList
Vector와 ArrayList는 가변 크기의 배열을 구현한 클래스로 거의 비슷하다. 크게 다른 점은 ArrayList는 스레드 간에 동기화를 지원하지 않기 때문에, 다수의 스레드가 동시에 접근할 때 ArrayList의 데이터가 훼손될 우려가 있다. 하지만 Vector는 호환성 때문에 남겨둔 것이고 ArrayList가 개선된 버전이기 때문에 웬만해서는 **ArrayList 사용을 권장**한다.
