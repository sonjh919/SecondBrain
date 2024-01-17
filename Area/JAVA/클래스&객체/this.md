---
title: this
date: 2024-01-02 15:17
categories:
  - Java
  - Class&Object
tags:
  - Java
  - Java문법
image: 
path:
---

## this
+ **현재 실행되고 있는 메소드가 속한 객체에 대한 레퍼런스**이다.
+ 컴파일러에 의해 자동 관리되므로, 우리는 사용하기만 하면 된다!

```java
public class Circle{
    public int radius;
    public String name;
    
	// this 사용
    public Circle(int radius, String name){
        this.radius = radius;
        this.name = name;
    }
    
    // 객체 자신의 레퍼런스를 리턴한다.
    pubic getMe(){
    	return this;
	}

}
```

## this()
+ **생성자가 다른 생성자를 호출**할 때 사용
+ 반드시 생성자 코드에서만 호출할 수 있다.
+ 반드시 같은 클래스 내에서 다른 생성자를 호출할 때 사용된다.
+ this()는 반드시 생성자의 첫 문장이 되어야 한다.

```java
public class Circle{
    public int radius;
    public String name;
    
    // this 함수 사용
    public Circle(){
    	this(1,"pizza");
    }
	
    // this 함수로 인해 해당 생성자가 실행된다.
    public Circle(int radius, String name){
        this.radius = radius;
        this.name = name;
    }

}
```