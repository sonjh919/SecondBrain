---
title: String
date: 2023-12-29 14:11
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

## 🌈 String
+ Java에서 문자열을 표현하고 처리하는데 사용되는 클래스
+ 컴파일시 같은 내용의 문자열 [[Literal]]은 한번만 저장된다.
+ String은 [[불변 클래스]]로, 기존 문자열의 내용이 변경되는 것이 아니라 새로운 String 인스턴스가 생성된다. 그래서 효율성을 위해 [[StringBuffer & StringBuilder]]를 쓸 수 있다.

> jdk 8 까지는 String 객체의 값은 char[] 배열로 구성되어져 있지만, jdk 9부터 기존 char[]에서 byte[]을 사용하여 String Compacting을 통한 성능 및 heap 공간 효율을 높이도록 수정되었다.
{: .prompt-tip }

### 📌 String 메서드 확인
+ https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html