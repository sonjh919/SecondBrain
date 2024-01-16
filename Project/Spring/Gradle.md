---
title: Gradle
date: 2024-01-16 22:29
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Gradle
+ gradle이란 build(빌드) 자동화 시스템이다.
+ 우리가 작성한 Java 코드를 설정에 맞게 자동으로 build해 준다.

### build
+ 소스 코드를 실행 가능한 결과물로 만드는 일련의 과정을 뜻한다.
+ gradle을 사용하면 간편하게 Java 소스 코드를 실행 가능한 [[jar]] 파일로 만들어준다.

![[Project/Spring/build.png]]

### build.gradle
- build.gradle은 Gradle 기반의 빌드 스크립트이다.
- 이 스크립트를 작성하면 소스 코드를 빌드하고 라이브러리들의 의존성을 쉽게 관리할 수 있다.
- **groovy** 혹은 kotlin 언어로 스크립트를 작성할 수 있다.

### groovy
[[JVM]] 위에서 동작하는 동적 타입 프로그래밍 언어이다.

![[buildGradle.png]]
