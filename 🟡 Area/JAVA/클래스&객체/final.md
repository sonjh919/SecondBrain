---
title: final
date: 2024-01-02 15:24
categories:
  - Java
  - Class&Object
tags:
  - Java
  - Java문법
image: 
path:
---
#Java #OOP 

## final
+ [[🟡 Area/JAVA/기본 문법/자료형]]에 값을 단 한 번만 설정할 수 있게 강제하는 키워드이다.
+ 값을 한 번 설정하면 그 값을 다시 설정할 수 없다.

### final 자료형/필드
+ 자료형의 값을 다시 바꿀 수 없게 **상수로 취급**된다.
+ 클래스 내에서 필드 선언 시에도 같다.

```java
final int n = 123;  // final로 설정하면 값을 바꿀 수 없다.
n = 456;  // 컴파일 오류 발생
```

### final 클래스
+ final이 클래스 이름 앞에 사용되면 **클래스를 상속받을 수 없다.**

```java
final class FinalClass {} // 상속 불가

class SubClass extends FinalClass{} // 컴파일 오류 발생
```

### final 메소드
+ final로 메소드를 선언하면 **오버라이딩이 불가능하다.**

```java
class SuperClass{
	protected final int finalMethod(){] // 오버라이딩 불가
}

class SubClass extends SuperClass{
	protected int finalMethod(){} // 컴파일 오류 발생
}
```