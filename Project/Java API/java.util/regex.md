---
title: regex
date: 2023-12-31 14:23
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

## 🌈 regex
+ Java에서 정규 표현식(Regular Expression)을 사용하기 위한 패키지이다.

### 📌 Pattern
+ 정규 표현식을 컴파일하고 패턴 객체를 생성하는데 사용된다.

### 📌 Macher
+ 패턴 객체와 입력 문자열 간의 매칭을 검사하는데 사용된다.
+ 여러 메서드를 통해 패턴과 입력 문자열 간의 일치 여부를 확인하고, 일치하는 부분을 추출할 수 있다.

```java
import java.util.regex.*;

public class RegexExample {
	private static final Pattern NUMBER_PATTERN = Pattern.compile("\\d+"); // 숫자 패턴

    public static void main(String[] args) {
        String input = "Hello, I have 2 apples and 3 oranges.";

        // Matcher 생성 및 매칭
        Matcher matcher = NUMBER_PATTERN.matcher(input);

        // 매칭된 결과 출력
        while (matcher.find()) {
            System.out.println("Match: " + matcher.group()); // 매칭된 부분 출력
        }
        
	    // 매칭 여부 확인
	     if(matcher.maches()){
		     System.out.println("Match");
	     }
    }
}

```