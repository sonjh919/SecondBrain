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

## Stream
### 이전의 처리 방식
이전에는 배열 또는 컬렉션 인스턴스를 다룰 때 for문을 활용하여 요소를 하나씩 꺼내야 했다. 하지만 로직이 복잡해질수록 코드의 양이 많아지고, 루프를 여러 번 도는 경우도 발생하여 성능이 떨어지는 경우도 발생하였다. 이에 Java 8 버전에서 Stream이라는 api를 새로 내놓았다. 
Stream은 **가독성, 병렬 처리, 지연 평가, 함수 구성** 등 여러 장점이 있다.

### Stream의 작동 방식
Stream은 **데이터의 흐름**이다. 컬렉션 인스턴스에 함수 여러 개를 조합해서 원하는 결과를 필터링하고 가공된 결과를 얻을 수 있다. 즉 로직을 **함수형**으로 처리할 수 있다. Stream의 방식은 크게 3가지로 나눌 수 있다
>
1. **생성하기** : 스트림 인스턴스 생성
2. **가공하기** : 필터링(filtering) 및 맵핑(mapping) 등 원하는 결과를 만들어가는 중간 작업(intermediate operations)
3. **결과 만들기** : 최종적으로 결과를 만들어내는 작업(terminal operations)

+ ex)
```java
List<Integer> numbers = new ArrayList<>();
// 스트림
numbers.stream()									// 1. 생성하기
			 .filter(i -> i > 30) 					// 2. 가공하기
			 .map(LottoNumbers::New);
			 .forEach(i -> System.out.println(i));	// 3. 결과 만들기
```
