---
title: SpringBoot
date: 2024-01-16 23:45
categories:
  - Spring
tags:
  - Spring
  - SpringBoot
image: 
path:
---

## Spring의 문제점
+ Spring 프레임워크는 AOP, IoC/DI 등과 같은 아주 강력한 핵심 기능들을 가지고 있다.
+ 하지만 이러한 핵심 기능들을 사용하기 위해서는 너무나도 많은 xml 설정들이 필요했다.
+ 이러한 불편점들을 개선하기 위해 2014년 SpringBoot가 등장하게 된다.

![[xmlconfig.png]]

## Spring Boot의 등장

### annotation 설정
- SpringBoot는 기존의 xml 설정 대신 Java의 **애너테이션 기반의 설정**을 적극적으로 사용하고 있기 때문에 무겁고 작성하기 힘들던 xml 대신에 애너테이션을 사용하여 아주 간편하게 설정할 수 있다.
- 기본적으로 개발에 필요한 설정 정보들을 일반적으로 많이 사용하는 설정 값을 default로 하여 자동으로 설정해주고 있다.

### 의존성 관리
외부 라이브러리나 하위 프레임워크들의 의존성 관리가 매우 쉬워졌다. 기존에는 외부 라이브러리와 프레임워크를 사용하기 위해서 각각의 버전들의 호환성을 직접 확인해가면서 의존성들을 설정해야 했지만 SpringBoot에서는 `spring-boot-starter-web` 처럼 필요한 외부 라이브러리들과 프레임워크들을 의존성에 맞게 starter로 묶어서 제공해 준다. 따라서 이전처럼 각각의 버전 호환성을 직접 확인할 필요가 없어졌다.

![[dependency.png]]
### 내장 Apache Tomcat
+ Spring 프레임워크에서는 서버를 실행시키기 위해 Apache Tomcat을 직접 다운로드 받고 설정하고 프로젝트에 삽입 했어야 했다.
+ 이러한 불편함을 해결하기 위해 SpringBoot에서는 기본적으로 `starter-web` dependency를 설정하면 자동으로 내장형 Apache Tomcat을 제공해 준다.