---
title: Page
date: 2024-01-26 19:43
categories:
  - JPA
tags:
  - jpa
  - Spring
image: 
path:
---

## Page
+ `Page` 인터페이스는 **페이징된 결과를 표현**하는데 사용된다.
+ 이 인터페이스는 목록과 함께 페이징과 관련된 다양한 메타 정보를 제공한다.
+ 어떤 페이지를 조회할지 결정하는 것은 [[Pageable]]을 사용한다.

```java
public interface Page<T> extends Slice<T> {
    int getTotalPages();
    long getTotalElements();
    <U> Page<U> map(Function<? super T, ? extends U> converter);
}

```

- `getTotalPages()`: 전체 페이지 수를 반환한다.
- `getTotalElements()`: 전체 요소 수를 반환한다.
- `map(Function<? super T, ? extends U> converter)`: 페이지 내의 각 요소에 대해 주어진 변환 함수를 적용한 후, 새로운 페이지를 반환한다.

