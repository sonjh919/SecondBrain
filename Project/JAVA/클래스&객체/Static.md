---
title: Static
date: 2024-01-02 15:22
categories:
  - Java
  - Class&Object
tags:
  - Java
  - Java문법
image: 
path:
---

### Static 멤버
+ 클래스당 하나씩 생기는 멤버로, **동일한 클래스의 모든 객체들에 의해 공유**된다.
+ 클래스 멤버라고도 한다(non Static 멤버는 인스턴스 멤버라고도 한다.)
+ 전역 변수, 전역 함수를 만들 때 활용된다.

### Static vs non Static
|.|non-static 멤버|static 멤버|
|---|---|---|
|선언|class Sample{ int n; }|class Sample{ static int n; }|
|공간적 특성|멤버는 **객체마다 별도 존재**|멤버는 **클래스당 하나 생성**, 객체 내부가 아닌 별도 공간에 생성|
|시간적 특성|**객체**의 라이프사이클을 따라간다.|**클래스 로딩**시 생성되며, 프로그램이 종료될때 사라진다.|
|공유|공유되지 않는다.|동일한 클래스의 모든 객체들에 의해 공유된다.|

### Static 메소드의 제약 조건
1. Static 메소드는 static 멤버만 접근할 수 있다.
2. this를 사용할 수 없다.