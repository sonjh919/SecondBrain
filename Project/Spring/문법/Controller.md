---
title: Controller
date: 2024-01-17 17:00
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## @Controller
+ @Controller는 해당 클래스가 Controller의 역할을 수행할 수 있도록 등록해줄 수 있다.

### html 반환
@Controller Class에서 문자열, 객체 등이 반환된다면, resources/templates에서 해당 문자열의 이름을 가진 html 파일을 찾아 그 html을 반환하게 된다. 순수하게 문자열을 반환하고 싶다면 응답의 body 부분에 문자열을 추가한다는 뜻으로 @ResponseBody annotation을 추가한다.

참고 : [[Front Controller]]

### API 예시

```java
@Controller
@RequestMapping("/api")
public class HelloController {
    @GetMapping("/hello")
    @ResponseBody
    public String hello() {
        return "Hello World!";
    }

    @GetMapping("/get")
    @ResponseBody
    public String get() {
        return "GET Method 요청";
    }

    @PostMapping("/post")
    @ResponseBody
    public String post() {
        return "POST Method 요청";
    }

    @PutMapping("/put")
    @ResponseBody
    public String put() {
        return "PUT Method 요청";
    }

    @DeleteMapping("/delete")
    @ResponseBody
    public String delete() {
        return "DELETE Method 요청";
    }
}
```


---

## annotation
+ @Controller : 해당 클래스가 Controller라는 뜻이다.
+ @RequestMapping : 중복되는 경로를 하나로 처리할 수 있다.
+ @ResponseBody : http요청의 본문(body)에서 응답을 처리할 수 있다.
+ @RestController : @Controller + @ResponseBody
+ @GetMapping : Get 방식의 api를 처리할 수 있다.
+ @PostMapping : Post 방식의 api를 처리할 수 있다.
+ @PutMapping : Put 방식의 api를 처리할 수 있다.
+ @DeleteMapping : Delete 방식의 api를 처리할 수 있다.
