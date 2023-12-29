---
title: JVM
date: 2023-12-28 15:57
categories:
  - Java
  - Java개발환경
tags:
  - Java
  - Java개발환경
  - JVM
image: 
path:
---

## 🌈 JVM(Java Virtual Machine)
Java는 C에서의 단점을 없애기 위해 JVM이라는 프로그램을 설치한다. 먼저 Java는 컴파일을 통해 하나의 목적 파일을 만들고, 이후에 JVM을 사용한다. 이 JVM이라는 친구는 각 플랫폼마다 설치되는데, **목적 파일을 각각의 운영체제로 전달될 수 있게 번역하는 역할이다.** 이 외에도 메모리 관리 등 효율적으로 관리하기 위한 **여러 수단들을 자동화해놓은 하나의 프로그램**, **Java가 실행되는 가상 컴퓨터**라고 생각하면 된다.

JVM은 주로 하나의 [[Process]]로 실행되며, 동시에 여러 작업을 수행하기 위해 멀티 [[Thread]]를 지원하고 있다.

### 📌 JVM 전 처리 과정
[[JRE]]는 프로그램을 실행하기 전에 먼저 프로그램에 메인 메서드를 포함하고 있는지 확인하고 존재한다면 JVM을 부팅시킨다. 부팅된 JVM은 전달받은 Byte 코드(.class)를 실행시키는데, 이때 가장 먼저 하는 일을 전 처리 과정이라고 한다.

1. 모든 Java 프로그램은 반드시 [[Java.lang]] 패키지를 포함한다. 따라서 JRE는 해당 패키지를 [[Method Area]]에 배치한다.
2. 프로그램이 사용하기 위해 import한 패키지들도 Method Area에 배치한다.
3. 프로그램 상의 작성한 모든 클래스, 변수 및 메서드의 정보를 Method Area에 배치한다.
4. static 변수와 메서드는 [[Heap Area]]에 배치한다.

### 📌 JVM의 내부 구조
+ [[Class Loader]]
+ [[Runtime Data Area]]
+ [[Execution Engine]]

![[JVM.png]]

