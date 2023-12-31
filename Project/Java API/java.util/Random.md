---
title: Random
date: 2023-12-31 14:19
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

## 🌈 Random
+ 난수 생성을 위한 클래스이다.
+ 객체 생성 시 **시드값**을 설정할  수 있다. 동일한 시드로 생성된 인스턴스는 같은 순서의 난수를 생성한다.
+ 시드를 설정하지 않으면 시스템 기반으로 자동으로 시드가 선택된다.

```java
import java.util.Random;

public class RandomExample {
    public static void main(String[] args) {
        Random random = new Random();

        // 정수형 난수 생성
        int randomNumber = random.nextInt(100); // 0부터 99까지의 난수
        System.out.println("Random number: " + randomNumber);

        // 더블형 난수 생성
        double randomDouble = random.nextDouble(); // 0.0부터 1.0 사이의 난수
        System.out.println("Random double: " + randomDouble);
    }
}

```