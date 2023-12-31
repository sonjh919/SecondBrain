---
title: Queue
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

## 🌈 Queue
+ 선입선출(FIFO, First-In-First-Out)의 Queue를 구현한 클래스이다.

### 📌 PriorityQueue
+ PriorityQueue(우선순위 큐)를 구현한 클래스이다.
+ 요소들은 정렬되지 않은 상태로 추가되고, 우선순위에 따라 요소가 제거된다.
+ 최소 heap 또는 최대 heap 구조로 정렬된다.
+ Comparator를 이용해 요소의 우선순위를 결정한다.

## 🌈 Deque
+ 양쪽 끝에서 요소를 추가하거나 제거할 수 있는 Deque(Double-ended-Queue)를 구현한 클래스이다.

### 📌 ArrayDeque
+ Queue와 Stack의 장점을 합친 Deque(Double-ended-Queue)를 구현한 클래스이다.
+ 내부적으로 동적으로 크기가 조정되는 배열을 사용하여 구현된다.