---
title: Stream
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

## Stream
### 이전의 처리 방식
이전에는 배열 또는 컬렉션 인스턴스를 다룰 때 for문을 활용하여 요소를 하나씩 꺼내야 했다. 하지만 로직이 복잡해질수록 코드의 양이 많아지고, 루프를 여러 번 도는 경우도 발생하여 성능이 떨어지는 경우도 발생하였다. 이에 Java 8 버전에서 Stream이라는 api를 새로 내놓았다. 
Stream은 **가독성, 병렬 처리, 지연 평가, 함수 구성** 등 여러 장점이 있다.

### Stream이란?
+ **한번 더 추상화된 자료구조와 자주 사용하는 프로그래밍 API를 제공한 것** 이다. 
+ 자료구조를 한 번 더 추상화 했기 때문에, 자료구조의 종류에 상관 없이 같은 방식으로 다룰 수 있다.
+ 즉, 자료구조의 “**흐름**”을 객체로 제공해주고, 그 흐름동안 사용할 수 있는 메서드들을 api로 제공해 준다.
### Stream의 특징
1. Stream은 데이터 처리연산을 지원하도록 소스에서 추출된 연속된 요소이다.
2. 컬렉션이 데이터를 저장하거나 접근하는데 초점을 맞춘 인터페이스라면, 스트림은 **데이터를 처리**하는데 초점을 맞춘 인터페이스이다. 따라서 **원본의 데이터를 변경하지 않는다.**
3. 컬렉션의 반복을 멋지게 처리하는 일종의 기능이자, 멀티스레드 관련 코드를 구현하지 않아도 알아서 **병렬로 추가**해주는 기능이다.
4. **일회용**이다. 한번 사용한 스트림은 어디에도 남지 않는다.
### Stream의 작동 방식
Stream은 **데이터의 흐름**이다. 컬렉션 인스턴스에 함수 여러 개를 조합해서 원하는 결과를 필터링하고 가공된 결과를 얻을 수 있다. 즉 로직을 **함수형**으로 처리할 수 있다. Stream의 방식은 크게 3가지로 나눌 수 있다

> [!note]+ 
> 1. **생성하기** : 스트림 인스턴스 생성
> 2. **가공하기** : 필터링(filtering) 및 맵핑(mapping) 등 원하는 결과를 만들어가는 중간 작업(intermediate operations)
> 3. **결과 만들기** : 최종적으로 결과를 만들어내는 작업(terminal operations)

+ ex)
```java
List<Integer> numbers = new ArrayList<>();
// 스트림
numbers.stream()									// 1. 생성하기
			 .filter(i -> i > 30) 					// 2. 가공하기
			 .map(LottoNumbers::New);
			 .forEach(i -> System.out.println(i));	// 3. 결과 만들기
```

## Stream 종류
모든 내용은 https://www.baeldung.com/java-8-streams 에서 확인할 수 있다.

### 중간 연산
1. **`filter()`**: 주어진 조건에 맞는 요소만 필터링한다.
2. **`map()`**: 모든 요소들을 다른 형태로 가공하여 변환한다.
3. **`flatMap()`**: 여러 스트림을 하나의 스트림으로 평면화한다.
4. **`distinct()`**: 중복 요소를 제거한다.
5. **`sorted()`**: 요소들을 정렬한다.
6. **`limit()`**: 요소의 개수를 제한한다.
7. **`skip()`**: 처음 몇 개의 요소를 건너뛴다.

### 최종 연산
1. **`forEach()`**: 각 요소에 대해 작업을 수행한다.
2. **`collect()`**: 요소들을 컬렉션으로 수집한다.
3. **`reduce()`**: 요소들을 하나의 값으로 줄인다.
4. **`count()`**: 요소들의 개수를 반환한다.
5. **`anyMatch()`**, **`allMatch()`**, **`noneMatch()`**: 조건에 부합하는 요소의 존재 여부를 반환한다.
6. **`findFirst()`**, **`findAny()`**: 요소를 찾아 반환한다.
7. **`max()`**, **`min()`**: 최대 또는 최소 값을 반환한다.