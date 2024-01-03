---
title: java.util
date: 2023-12-29 12:26
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

## java.util
+ Java의 유틸리티 클래스들을 제공한다.

## 자주 쓰이는 클래스 및 인터페이스
+ [[Collection]]
+ [[Map]]
+ [[Scanner]]
+ [[Random]]
+ [[regex]]
+ [[function]]
### 시간 & 날짜
+ Date와 Calender가 있지만, 사용하기에 불편한 점이 많아 Java 8부터 추가된 [[java.time]]을 활용하자.


### StringTokenizer
+ 문자열을 **구분자(delimiter)를 기준으로 토큰(token)으로 분리**하는 클래스이다.
+ 호환성을 위해 유지되는 레거시 클래스(legacy class)이기 때문에 [[regex]]의 split 메서드를 사용하자.


### logging
+ [[logging]]은 별도의 라이브러리나 설정 없이 기본적인 로깅이 필요한 경우에 사용하지만, 대체로 **다른 로깅 프레임워크(Log4j, SLF4J) 등을 고려하는 것이 좋다.**