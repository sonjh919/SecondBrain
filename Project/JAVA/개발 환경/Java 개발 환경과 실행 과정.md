---
title: Java 개발 환경과 실행 과정
date: 2023-12-17 17:01
categories:
  - Java
  - Java개발환경
tags:
  - Java
  - Java개발환경
image: 
path:
---

## 🌈 Java 개발 환경
+ [[JVM]]
+ [[JDK]]
+ [[JRE]]
+ [[JIT]]
+ [[JAR]]

## 🌈 Java 실행 과정
+ Java는 컴파일러와 인터프리터의 장점을 모두 가지고 있으며, 굳이 따지자면 인터프리터의 성향이 더 강하다. → C보다 느리고 파이썬보다 빠르다.

1. Java 소스 코드(.java)를 작성한다.
2. Java Compiler([[JDK]]의 javac.exe)를 통해 **컴파일**하여 Byte code(.class)로 변환하다.
3. 바이트 코드(.class)를 포함하여 여러 클리스와 리소스를 합친 [[JAR]] 파일을 [[JVM]]으로 전달한다.
4. JVM의 Class Loader는 컴파일로 생성된 바이트 코드(.class)를 전달 받아 동적 로딩을 통해 실행에 필요한 클래스들을 로딩하여 JVM 내부 Runtime Data Area에 로드한다.
5. JVM의 Execution에 의해 기계어로 해석되어 실행된다. 여기서는 **Interpreter**와 [[JIT]]로 실행된다.
6. Execution에서 실행될 때 Garbage Collector도 작동한다.
7. 최종적으로 코드는 이진 코드로 변환되어 컴퓨터가 읽을 수 있게 전달되어 실행된다.
![[Java 실행과정.png]]


## 📌 JDK(Java Development Kit) : Java 개발 키트
JDK는 Java로 개발을 하려는 사람들이 설치하여 사용하면 된다! JDK에는 JRE, JVM 등이 포함된다. JDK를 설치하려면 3가지 Edition 중 하나를 선택하여 설치하면 된다.

### **1. Java SE(Java Standard Edition)**
+ 데스크탑용 어플리케이션을 만들기 위한 심플한 용도의 java

### **2. Java EE(Java Enterprise Edition)**
+ 웹 환경을 구축할 수 있는 기능이 추가로 들어있다.

### **3. Java ME(Java Micro Edition)**
+ 소형 기기에 탑재될 수 있는 가벼운 용도의 java 

성능과 비용적인 측면에서는 Oracle JDK와 Open JDK가 있다.

### **1. Oracle JDK**
비상업적인 용도에 한해서 무료, 상업은 유료 구독형 라이선스로 구매하여 사용한다.

### **2. Open JDK**
오라클이 오픈소스 커뮤니티에 제공한 소스기반으로 오픈소스로 개발되고 있으며 무료이다.
