---
title: function
date: 2024-01-03 10:54
categories:
  - Java
  - java.util
tags:
  - Java
  - ModernJava
  - JavaAPI
  - javautil
image: 
path:
---

## function
+ java.util.function은 Java에서 자주 사용되는 함수형 인터페이스를 미리 정의해둔 패키지이다.
+ [[제네릭]]을 이용하여 구현되어있다.

### Function<T,R>
+ T 타입을 받아서 R 타입을 리턴하는 함수형 인터페이스다.

## 함수 조합 메서드

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

### andThen()
+ 두 개의 함수를 순차적으로 연결하여 실행하는 기능을 제공한다.
+ 첫 번째 함수를 실행한 후 그 결과를 두 번째 함수의 입력으로 전달하여 두 함수를 연쇄적으로 실행한다.

### compose()
+ `andThen()`과 반대로 두 개의 함수를 역순으로 조합하여 실행하는 기능을 제공한다.
+ 두 번째 함수를 실행한 후 그 결과를 첫 번째 함수의 입력으로 전달하여 두 함수를 연쇄적으로 실행한다.
