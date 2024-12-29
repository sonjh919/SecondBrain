---
title: java.lang
date: 2023-12-29 12:26
categories:
  - JavaAPI
  - java.lang
tags:
  - JavaAPI
  - Java
  - javalang
image: 
path:
---
#Java #JavaAPI #javalang 

## java.lang
+ java 프로그래밍에 필요한 가장 기본적인 클래스들이 모여있는 패키지이다.
+ 모든 클래스의 최상위 클래스인 **Object** 클래스가 있다.
+ java.lang은 Compiler가 자동으로 추가해주기 때문에 java API 내에서 유일하게 import하지 않고 쓸 수 있다.

## 계층도
![[javalang.png]]
## 자주 쓰이는 클래스 및 인터페이스
+ [[Object]]
+ [[String]]
+ [[StringBuffer & StringBuilder]]
+ [[Throwable]]
+ [[Wrapper]]
+ [[Class]]
+ [[🟠 Project/Java API/java.lang/Math|Math]]
+ [[Stream]]
+ [[record]]

## 시스템 레벨의 클래스
### [[Process]]
+ Process의 생성, 실행, 관리를 위한 클래스이다. 
+ 외부 프로그램을 실행하고 해당 Process의 입력 및 출력 스트림을 얻는 데 사용된다.
### [[Thread]]
+ 다중 Thread를 지원하는 클래스이다. 
+ 이 클래스를 사용하여 Java 애플리케이션 내에서 병렬로 실행되는 Thread를 만들고 관리할 수 있다.
### [[Class Loader]]
+ 클래스 파일을 로드하여 [[JVM]]의 메모리에 적재하는 역할을 담당한다. 클래스 로딩을 커스터마이징하거나 다양한 소스에서 클래스를 로드하는 데 사용됩니다.
### Runtime
+ 현재 실행 중인 Java 응용 프로그램의 런타임 환경을 나타낸다. 
+ JVM과 상호 작용하여 Java process의 실행을 제어하는 데 사용된다.
### System
+ 시스템과 관련된 유틸리티 메서드들을 제공하는 클래스이다. 
+ 환경 변수, 시스템 속성, 입출력 스트림 등 **시스템 레벨의 기능**을 조작하는 데 사용된다.
### Compiler
+ Java 코드를 바이트 코드로 컴파일하는 데 사용된다. 
+ 일반적으로 이 클래스를 직접 사용하는 것은 드물며, 주로 [[JVM]]이나 [[JIT]] 컴파일러 등에서 내부적으로 사용된다.
