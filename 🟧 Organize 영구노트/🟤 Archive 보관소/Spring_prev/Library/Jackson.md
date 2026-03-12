---
title: Jackson
date: 2024-01-17 22:28
categories:
  - Spring
  - Library
tags:
  - Spring
  - Library
image: 
path:
---
#Spring #Library 

## Jackson
+ Jackson은 [[JSON]] 데이터 구조를 처리해주는 라이브러리이다.
+ **Object**를 `JSON` 타입의 **String**으로 변환해줄 수 있다.
- 반대로, `JSON` 타입의 **String**을 **Object**로 변환해줄 수도 있다.
+ Spring은 **3.0**버전 이후로 `Jacskon`과 관련된 **API**를 제공함으로써, 우리가 직접 소스 코드를 작성하여 `JSON` 데이터를 처리하지 않아도 자동으로 처리해주고 있다.
    - 따라서 SpringBoot의 `starter-web`에서는 default로 Jackson 관련 라이브러리들을 제공하고 있다.
    - 직접 `JSON` 데이터를 처리해야할 때는 Jackson 라이브러리의 **ObjectMapper**를 사용할 수 있다.

### Object to JSON (직렬화)
- objectMapper의 writeValueAsString 메서드를 사용하여 변환할 수 있다.
    - 파라미터에 `JSON`으로 변환시킬 Object의 객체를 주면 된다.
- **Object**를 `JSON` 타입의 **String**으로 변환하기 위해서는 해당 Object에 get Method가 필요하다.

```java
@Test
@DisplayName("Object To JSON : get Method 필요")
void test1() throws JsonProcessingException {
    Star star = new Star("Robbie", 95);

    ObjectMapper objectMapper = new ObjectMapper(); // Jackson 라이브러리의 ObjectMapper
    String json = objectMapper.writeValueAsString(star);

    System.out.println("json = " + json);
}
```

### JSON to Object (역직렬화)
- objectMapper의 readValue 메서드를 사용하여 변환할 수 있다.
    - 첫 번째 파라미터는 `JSON` 타입의 **String,** 두 번째 파라미터에는 변환할 Object의 class 타입을 주면 된다.
- `JSON` 타입의 **String**을 **Object**로 변환하기 위해서는 해당 Object에 기본 생성자와 get 혹은 set 메서드가 필요하다.

```java
@Test
@DisplayName("JSON To Object : 기본 생성자 & (get OR set) Method 필요")
void test2() throws JsonProcessingException {
    String json = "{\"name\":\"Robbie\",\"age\":95}"; // JSON 타입의 String

    ObjectMapper objectMapper = new ObjectMapper(); // Jackson 라이브러리의 ObjectMapper

    Star star = objectMapper.readValue(json, Star.class);
    System.out.println("star.getName() = " + star.getName());
}
```