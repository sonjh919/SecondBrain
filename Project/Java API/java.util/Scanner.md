---
title: Scanner
date: 2023-12-31 14:15
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

## 🌈 Scanner
+ Java에서 입력을 받기 위해 사용되는 클래스이다.
+ Scanner는 클래스를 **토큰 단위**로 읽는다.(nextLine 제외)
+ 공백문자까지도 버퍼에 저장된다.

> 토큰(Token) : 공백문자(Spacebar, Tab, Enter 등)로 구분되는 요소

```java
import java.util.Scanner;

// 1. Scanner 객체 생성
Scanner sc = new Scanner(System.in);

// 자주 쓰이는 것들
int num = sc.nextInt();         // int 입력받기
String str = sc.next();       // 한 단어 입력받기
String str = sc.nextLine();   // 한 줄 입력받기
char ch = sc.nextLine().charAt(0); // 문자 입력받기


byte a = sc.nextByte();       // byte 입력
short b = sc.nextShort();     // short 입력
long c = sc.nextLong();       // long 입력

float d = sc.nextFloat();     // float 입력
double e = sc.nextDouble();   // double 입력

boolean f = sc.nextBoolean();  // boolean 입력
```