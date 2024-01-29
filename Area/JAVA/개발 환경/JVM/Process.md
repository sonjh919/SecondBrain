---
title: Process
date: 2023-12-29 14:48
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
#Java #JVM 

## Process
+ 프로세스(Process)는 일반적으로 cpu에 의해 메모리에 올려져 **실행중인 프로그램**을 말한다.
+ **운영체제로부터 자원을 할당받는 작업의 단위**이다.
+ 자신만의 메모리 공간을 포함한 독립적인 실행 환경을 가지고 있다.
+ 프로그램 중 일부는 여러 프로세스간 상호작용을 할 수도 있다.
+ OS가 프로그램 실행을 위한 프로세스를 할당해줄때 프로세스안에 프로그램 Code와 Data 그리고 메모리 영역(Stack, Heap)을 함께 할당해준다.

![[process.png]]