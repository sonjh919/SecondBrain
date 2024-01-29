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
#Java #Java개발환경 

## Java 개발 환경
> [!summary]+ 
> ![[java dev.png]]
> + [[JVM]]
> + [[JDK]]
> + [[JRE]]
> + [[JIT]]
> + [[JAR]]

## Java 실행 과정
+ Java는 컴파일러와 인터프리터의 장점을 모두 가지고 있으며, 굳이 따지자면 인터프리터의 성향이 더 강하다. → C보다 느리고 파이썬보다 빠르다.

> [!summary]+ 
> 1. Java 소스 코드(.java)를 작성한다.
> 2. Java Compiler([[JDK]]의 javac.exe)를 통해 **컴파일**하여 Byte code(.class)로 변환하다.
> 3. 바이트 코드(.class)를 포함하여 여러 클리스와 리소스를 합친 [[JAR]] 파일을 [[JVM]]으로 전달한다.
> 4. JVM의 [[Class Loader]]는 컴파일로 생성된 바이트 코드(.class)를 전달 받아 동적 로딩을 통해 실행에 필요한 클래스들을 로딩하여 JVM 내부 [[Runtime Data Area]]에 로드한다.
> 5. JVM의 [[Execution Engine]]에 의해 기계어로 해석되어 실행된다. 여기서는 **Interpreter**와 [[JIT]]로 실행된다.
> 6. 최종적으로 코드는 이진 코드로 변환되어 컴퓨터가 읽을 수 있게 전달되어 실행된다.
![[Java 실행과정.png]]



