---
title: function
date: 2024-01-03 10:54
categories:
  - JavaAPI
  - java.util
tags:
  - Java
  - ModernJava
  - JavaAPI
  - javautil
image: 
path:
---
#Java #JavaAPI #javautil

## function
+ java.util.function은 Java에서 자주 사용되는 [[🟧 Organize 영구노트/🟢 Area 장기적인 책임/JAVA/모던 자바/함수형 인터페이스]]를 미리 정의해둔 패키지이다.
+ [[제네릭]]을 이용하여 구현되어있다.

### Function<T,R>
+ T 타입을 받아서 R 타입을 리턴하는 함수형 인터페이스다.
+ `apply()`를 통해 매개변수를 전달할 수 있다.
+ 함수 조합이 가능한 `andThen()`과 `compose()`를 제공한다.

### UnaryOperator< T >
+  Function<T, R>의 특수한 형태이다.
+ **Function<T, R>의 입력 타입 T와 리턴 타입 R이 같을 경우** UnaryOperator< T >로 사용할 수 있다.

### BiFunction<T, U, R>
+ 두 개의 입력 값(T, U)를 받아서 R 타입을 리턴하는 함수형 인터페이스이다.

### BinaryOperator< T >
+ BiFunction<T, U, R>의 특수한 형태이다.
+ 입력과 출력의 타입이 다를 거라는 가정하에 만들어진 BiFunction과는 다르게 타입이 하나로 사용될 것을 고려해 만들어졌다.

### Consumer< T >
+ 타입을 받아서 아무 값도 리턴하지 않는 함수형 인터페이스로, **소비자**라고도 한다.
+ `accept()`를 통해 값을 전달할 수 있다.

### Supplier< T >
+ T 타입의 값을 제공하는 함수형 인터페이스이다. **공급자**라고도 불린다.
+ T에는 받아올 값의 타입을 명시한다.
+ `get()`으로 값을 받아올 수 있다.

### Predicate< T >
+ T타입을 받아서 boolean을 리턴하는 함수형 인터페이스이다.
+ `test()`로 값을 넘길 수 있다.
+ 함수 조합용 메서드인 `or`, `and`, `negate` 등을 통해 조합할 수 있다.


이외에도 많이 있다. 쓸때마다 정리하겠다.
DoubleBinaryOperator, BiConsumer<T, U>, BooleanSupplier 등등

## 함수 조합 메서드
### andThen()
+ 두 개의 함수를 순차적으로 연결하여 실행하는 기능을 제공한다.
+ 첫 번째 함수를 실행한 후 그 결과를 두 번째 함수의 입력으로 전달하여 두 함수를 연쇄적으로 실행한다.

### compose()
+ `andThen()`과 반대로 두 개의 함수를 역순으로 조합하여 실행하는 기능을 제공한다.
+ 두 번째 함수를 실행한 후 그 결과를 첫 번째 함수의 입력으로 전달하여 두 함수를 연쇄적으로 실행한다.

```java
import java.util.function.Function;

public class FunctionCompositionExample {
    public static void main(String[] args) {
        // 첫 번째 함수: 정수를 문자열로 변환하는 함수
        Function<Integer, String> intToString = (num) -> "Number: " + num;

        // 두 번째 함수: 문자열 끝에 "!"를 추가하는 함수
        Function<String, String> addExclamation = (str) -> str + "!";

        // andThen(): 두 함수를 연쇄적으로 실행
        Function<Integer, String> combinedFunction = intToString.andThen(addExclamation);
        String resultAndThen = combinedFunction.apply(10); // 결과: "Number: 10!"
        System.out.println(resultAndThen);

        // compose(): 두 함수를 역순으로 연쇄적으로 실행
        Function<Integer, String> composedFunction = addExclamation.compose(intToString);
        String resultCompose = composedFunction.apply(20); // 결과: "Number: 20!"
        System.out.println(resultCompose);
    }
}

```
### apply()
+ 함수형 인터페이스를 구현한 객체에서 사용된다. 
+ 이 메서드는 함수를 호출하여 입력값을 받아 처리한 후 결과를 반환하는 역할을 한다.

```java
import java.util.function.Function;

public class FunctionApplyExample {
    public static void main(String[] args) {
        // Function 인터페이스를 구현한 객체 생성 (정수를 문자열로 변환)
        Function<Integer, String> intToString = (num) -> "Number: " + num;

        // apply() 메서드를 통해 함수 실행 및 결과 반환
        String result = intToString.apply(10); // 정수 10을 문자열로 변환
        System.out.println(result); // 출력: Number: 10
    }
}

```