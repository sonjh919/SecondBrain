---
title: Map
date: 2023-12-31 13:52
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
#Java #JavaAPI #javautil


## Map
+ 대응 관계를 쉽게 표현할 수 있게 해주는 자료형이다.
+ 리스트나 배열처럼 순차적으로 요소값을 구하지 않고 **키(key)를 이용해 값(value)를 얻는다.**
+ 사전(dictionary)와 비슷하다.

### HashMap
+ 해시 테이블을 기반으로 한 Map 구현체이다.
+ 해시 함수를 사용하여 **키를 해시 값으로 변환하여 인덱스로 사용**합니다.
+ **순서를 보장하지 않는다.**
+ **중복된 키를 허용하지 않고, 하나의 키에 대해 하나의 값**만을 가진다.
+ **빠른 검색 속도**를 제공한다.

### LinkedHashMap
+ 해시 테이블과 연결 리스트를 결합한 Map 구현체
+ HashMap과 달리 **순서를 보장**한다.

### TreeMap
+ 이진 검색 트리를 기반으로 하는 Map 구현체이다.
+ 입력된 key의 오름차순으로 데이터를 **정렬**하여 저장하지만, 정렬 기준을 설정할 수 있다.
