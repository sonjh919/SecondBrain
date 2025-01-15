---
title: Optional
date: 2024-01-03 11:37
categories:
  - JavaAPI
  - java.util
tags:
  - Java
  - javautil
  - JavaAPI
image: 
path:
---
#Java #JavaAPI #javautil

## Optional
+ 값이 존재할 수도 있고 없을 수도 있는 객체를 감싸는 래퍼([[Wrapper]]) 클래스이다.
+ **값이 없는 경우에 대한 명시적인 처리**를 위해 사용된다.

## Optional의 특징
1. **Null 방지**: `null` 참조를 방지하고, 값이 없는 상황을 명시적으로 처리한다.
2. **Null 포인터 예외 방지**: `null` 체크를 명시적으로 하지 않고도 안전하게 코드를 작성할 수 있게 한다.
3. **메서드 체이닝**: `Optional` 인스턴스를 사용하여 메서드 체이닝을 통해 간단하게 값에 접근하고 처리할 수 있다.

### Optional의 주요 메서드
- **`of()`**: 값을 감싸는 `Optional` 인스턴스를 생성한다. 값이 `null`인 경우 `NullPointerException`이 발생한다.
- **`ofNullable()`**: 값을 감싸는 `Optional` 인스턴스를 생성한다. 값이 `null`인 경우에도 예외가 발생하지 않는다.
- **`empty()`**: 비어있는 `Optional` 인스턴스를 생성한다.
- **`isPresent()`**: 값의 존재 여부를 확인한다.
- **`get()`**: 값이 존재하면 해당 값을 반환하고, 값이 없는 경우 `NoSuchElementException`을 발생시킨다. 주의해서 사용해야 합니다.
- **`orElse()`**: 값이 없는 경우 대체 값을 제공한다.
- **`orElseGet()`**: 값이 없는 경우 대체 값을 생성하는 `Supplier`를 받는다.
- **`orElseThrow()`**: 값이 없는 경우 예외를 발생시킨다.

### 예시
```java
Optional<String> optionalString = Optional.of("Hello");
String value = optionalString.orElse("No value"); // "Hello"

Optional<String> emptyOptional = Optional.empty();
String valueOrDefault = emptyOptional.orElse("Default Value"); // "Default Value"

```