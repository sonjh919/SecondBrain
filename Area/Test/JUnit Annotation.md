---
title: JUnit Annotation
date: 2024-01-17 11:42
categories:
  - Test
tags:
  - Test
  - JUnit
image: 
path:
---

## JUnit Annotation
+ JUnit에서 많이 쓰이는 Annotation 정리
### @Test
테스트 메소드를 나타내는 어노테이션으로, 필수로 작성되어야 한다.

### @BeforeEach
각 테스트 메소드 시작 전에 실행되어야 하는 메소드에 써준다.
### @AfterEach
각 테스트 메소드 종료 후에 실행되어야 하는 메소드에 써준다.
### @BeforeAll
테스트 시작 전에 실행되어야 하는 메소드에 써준다. static 메소드여야 한다.
### @AfterAll
테스트 종료 후에 실행되어야 하는 메소드에 써준다. static 메소드여야 한다. 
### @Disabled
실행되지 않아야 하는 테스트 메소드에서 써준다.