---
title: Set
date: 2023-12-31 12:29
categories:
  - JavaAPI
  - java.util
tags:
  - JavaAPI
  - Java
  - javautil
  - Collection
image: 
path:
---
#Java #JavaAPI #javautil #Collection

## Set
+ 집합과 관련된 것들을 쉽게 처리하기 위해 만든 자료형이다.
+ **중복을 허용하지 않는다.**
+ **순서가 없다.(unordered)**

### HashSet
+ **해시 테이블**을 기반으로 한 Set 구현체이다.
+ 중복된 요소를 허용하지 않고, **순서를 보장하지 않는다.**
+ **빠른 검색 속도**에 용이하다.

> [!info]+ 
> **해시 테이블** : 키과 값으로 이루어진 데이터를 저장하는 자료구조이다.

### TreeSet
+ **이진 검색 트리**를 기반으로 한 Set 구현체이다.
+ 요소를 자동으로 정렬하여 저장하므로 요소들이 정렬된 상태로 유지된다.
+ 중복된 요소를 허용하지 않으며, 요소들의 **자동 정렬**과 검색에 용이하다.

## SortedSet
+ Set은 순서를 보장하지 않지만, SortedSet은 순서를 보장한다.

### LinkedHashSet
+ 해시 테이블과 연결 리스트를 결합한 Set 구현체이다.
+ **요소의 삽입 순서를 보존한다.**
+ HashSet과 마찬가지로 빠른 검색 모드를 제공한다.