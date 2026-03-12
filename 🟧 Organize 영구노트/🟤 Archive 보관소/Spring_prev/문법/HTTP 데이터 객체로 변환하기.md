---
title: HTTP 데이터 객체로 변환하기
date: 2024-01-18 09:35
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring 

## @ModelAttribute
RequestParam을 통해 얻은 데이터는 @ModelAttribute를 이용해 바로 객체로 선언하여 받아올 수 있다. 만약 객체에서 정의된 변수명이 다르다면 값을 넣어줄 수 없으므로 null이 들어가게 된다.

**사실 @ModelAttribute는 생략이 가능하다.**

참조 : [[Client에서 데이터 받기]]

### 1. body에서 Query String 형식으로 넘어온 경우

>POST [http://localhost:8080/hello/request/form/model](http://localhost:8080/hello/request/form/model)
{: .prompt-info }


```java
// [Request sample]
// POST http://localhost:8080/hello/request/form/model
// Header
//  Content type: application/x-www-form-urlencoded
// Body
//  name=Robbie&age=95
@PostMapping("/form/model")
@ResponseBody
public String helloRequestBodyForm(@ModelAttribute Star star) {
    return String.format("Hello, @ModelAttribute.<br> (name = %s, age = %d) ", star.name, star.age);
}
```

### 2. Query String 방식으로 넘어온 경우
+ 데이터만 뽑아올 수 있게 String.format으로 지정해준다.

>GET [http://localhost:8080/hello/request/form/param/model?name=Robbie&age=95](http://localhost:8080/hello/request/form/param/model?name=Robbie&age=95)
{: .prompt-info }

```java
// [Request sample]
// GET http://localhost:8080/hello/request/form/param/model?name=Robbie&age=95
@GetMapping("/form/param/model")
@ResponseBody
public String helloRequestParam(@ModelAttribute Star star) {
    return String.format("Hello, @ModelAttribute.<br> (name = %s, age = %d) ", star.name, star.age);
}
```

### 3. body에서 JSON 형식으로 들어오는 경우
+ HTTP Body에 {"name":"Robbie","age":"95"} JSON 형태로 데이터가 서버에 전달되었을 때 @RequestBody를 사용해 데이터를 객체 형태로 받을 수 있다. 얘는 생략 불가!

>POST [http://localhost:8080/hello/request/form/json](http://localhost:8080/hello/request/form/json)
{: .prompt-info }

```java
// [Request sample]
// POST http://localhost:8080/hello/request/form/json
// Header
//  Content type: application/json
// Body
//  {"name":"Robbie","age":"95"}
@PostMapping("/form/json")
@ResponseBody
public String helloPostRequestJson(@RequestBody Star star) {
    return String.format("Hello, @RequestBody.<br> (name = %s, age = %d) ", star.name, star.age);
}
```

> 데이터를 Java의 객체로 받아올 때 주의점
> 해당 객체의 필드에 데이터를 넣어주기 위해 set or get 메서드 또는 오버로딩된 생성자가 필요하다! 만약 없다면 받아온 데이터를 해당 객체의 필드에 담을 수 없다.
{: .prompt-warning }