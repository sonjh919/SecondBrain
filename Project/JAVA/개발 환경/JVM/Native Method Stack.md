---
title: Native Method Stack
date: 2023-12-28 20:38
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

## Native Method Stack
- 자바 프로그램이 컴파일 되어 생성되는 바이트 코드가 아닌 실제 실행할 수 있는 기계어로 작성된 프로그램을 실행시키는 영역이다.
- 자바 이외의 언어(C, C++, 어셈블리 등)로 작성된 코드를 실행할 때, Native Method Stack이 할당 되며, 일반적인 C 스택을 사용한다.
- Java Native Interface를 통해 바이트 코드로 전환하여 저장된다.
- 일반 프로그램처럼 커널이 스택을 잡아 독자적으로 프로그램을 실행시키는 영역이다.