---
title: assert
date: 2024-01-17 11:19
categories:
  - Test
tags:
  - Test
  - AssertJ
image: 
path:
---

## AssertJ
AssertJ는 많은 assertion을 제공하는 자바 라이브러리이다. `assertThat` 메서드를 중심으로 다양한 **메서드 체이닝**을 지원하여 에러 메세지와 테스트 코드의 가독성을 매우 높여준다.

### 기본 사용
```java
import static org.assertj.core.api.Assertions.*;

// 동등성 검사
assertThat(actual).isEqualTo(expected);

// 부등성 검사
assertThat(actual).isNotEqualTo(notExpected);

```

### 컬렉션 assertion
```java
List<String> names = Arrays.asList("John", "Jane", "Doe");

// 크기 검사
assertThat(names).hasSize(3);

// 포함 여부 검사
assertThat(names).contains("John", "Jane").doesNotContain("Bob");

// 순서 검사
assertThat(names).containsExactly("John", "Jane", "Doe");

```

### 예외 assertion
```java
// 예외 발생 여부 검사
assertThatThrownBy(() -> someMethodThatShouldThrowException())
    .isInstanceOf(MyException.class)
    .hasMessageContaining("expected message");

```

### 숫자 assertion
```java
fint actual = 42;

// 숫자 비교
assertThat(actual).isGreaterThan(30).isLessThanOrEqualTo(50);

```

### 문자열 assertion
```java
String text = "AssertJ is powerful!";

// 문자열 검사
assertThat(text).startsWith("AssertJ").endsWith("powerful!");
assertThat(text).contains("is").doesNotContain("Java");

```

### 객체 필드 비교
```java
// 객체 필드별로 비교
assertThat(person).isEqualToComparingFieldByField(expectedPerson);

```

### 조건 assertion
```java
// 조건을 만족하는지 검사
assertThat(value).isGreaterThan(10).isLessThanOrEqualTo(20);

```


### 커스텀 assertion
```java
// 커스텀 어설션 정의
assertThat(result).satisfies(customAssertion);

```

### 메시지와 메서드 참조
```java
// 실패 메시지 추가
assertThat(result).as("Custom message").isEqualTo(42);

// 메서드 참조를 사용한 어설션
assertThat(result).isEqualToComparingFieldByFieldRecursively(expectedObject);

```
