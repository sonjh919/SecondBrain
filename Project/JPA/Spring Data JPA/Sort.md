---
title: Sort
date: 2024-01-26 19:53
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Sort
+ 쿼리 결과를 특정 열을 기준으로 정렬할 때 사용된다.

### Sort.Direction
+ 정렬 방향을 나타내는 열거형(enum)이다. ASC는 오름차순이며, DESC는 내림차순이다.

```java
Sort.Direction direction = isAsc ? Sort.Direction.ASC : Sort.Direction.DESC;  
Sort sort = Sort.by(direction, sortBy);
```