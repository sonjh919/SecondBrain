---
title: Object
date: 2023-12-29 14:09
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

## Object
+ Object 클래스는 모든 클래스의 최상위 클래스로, 모든 클래스는 암묵적으로 Object 클래스를 상속받는다.
+ 필드를 가지지 않으며, 11개의 메서드로 구성되어 있다.

| 메소드 | 설명 |
| --- | --- |
|**Class getClass()**|객체의 클래스형을 반환|
|**int hashCode()**|찾을 값을 입력하면 저장된 위치를 알려주는 해시코드를 반환|
|**String toString()**|현재 객체의 문자열을 반환|
|**protected Object clone()**|객체 자신의 복사본 반환 **(깊은 복사)**|
|**boolean equals(Object obj)**|두 개의 객체가 같은지 비교하여 같으면 true를, 같지 않으면 false를 반환|
|protected void finalize()|가비지 컬렉션 직전에 객체의 리소스를 정리할 때 호출|
|void notify()|wait된 스레드 실행을 재개할 때 호출|
|void notifyAll() |wait된 모든 스레드 실행을 재개할 때 호출|
|void wait()|스레드를 일시적으로 중지할 때 호출|
|void wait(long timeout)|주어진 시간만큼 스레드를 일시적으로 중지할 때 호출|
|void wait(long timeout, int nanos) ||
