---
title: enum
date: 2023-12-28 21:39
categories:
  - Java
  - Java문법
tags:
  - Java
  - Java문법
image: 
path:
---

## enum
+ enum 자료형은 서로 연관 있는 여러 개의 **상수 집합**을 정의할 때 사용한다.
+ 코드를 명확하게 작성할 수 있는 장점이 있다.

예를 들어 아이유의 노래 목록을 다음과 같다고 가정해 보자.

|아이유!!|
|---|
|Celebrity|
|Blueming|
|Strawberry_moon|

이렇게 3가지 노래가 있다면, enum으로 상수 집합을 만들고 접근할 수 있다.
```java
public class Sample {
  enum IU{
      CELEBRITY,
      BLUEMING,
      STRAWBERRY_MOON
  };
  
  public static void main(String[] args) {
          System.out.println(IU.CELEBRITY);
          System.out.println(IU.BLUEMING);
          System.out.println(IU.STRAWBERRY_MOON);
          
          // for문으로 접근할 수도 있다.
          for(IU type: IU.values()) {
            System.out.println(type);
        }
	}

}
```

같은 의미를 가지는 데이터들이 많다면, 이를 연관관계로 표현하여 나타낼 수 있다. 여기에는 람다 함수도 포함될 수 있다.
```java
public class Sample {
  enum IU{
      CELEBRITY(20210325),
      BLUEMING(20191118),
      STRAWBERRY_MOON(20211019)
  };
  
  public static void main(String[] args) {
          System.out.println(IU.CELEBRITY);
          System.out.println(IU.BLUEMING);
          System.out.println(IU.STRAWBERRY_MOON);
          
          // for문으로 접근할 수도 있다.
          for(IU type: IU.values()) {
            System.out.println(type);
        }
	}

}
```
	

### enum의 특징
1. ```static final```로 관리하는 것 보다 코드가 단순해지며 가독성이 좋아진다.
2. 구현의 의도가 열거임을 분명하게 나타낼 수 있다.
3. 인스턴스 생성과 상속을 방지한다.
4. 생성자가 private이다
- 외부에서 접근할 수 없으므로 인스턴스 생성을 방지하며, 싱글톤을 일반화한다.
5. if문의 사용을 줄일 수 있다.
- if문의 사용을 줄이면 클리코드를 작성할 수 있는 여지가 많아진다.
6. 타입 안정성을 보장한다.
