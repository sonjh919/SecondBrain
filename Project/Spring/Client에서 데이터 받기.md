---
title: Client에서 데이터 받기
date: 2024-01-18 00:01
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Client에서 데이터 받기
- Client 즉, 브라우저에서 서버로 HTTP 요청을 보낼 때 데이터를 함께 보낼 수 있다.
- 서버에서는 이 데이터를 받아서 사용해야하는데 데이터를 보내는 방식이 여러 가지가 있다.

## @PathVariable
>GET [http://localhost:8080/hello/request/star/Robbie/age/95](http://localhost:8080/hello/request/star/Robbie/age/95)
{: .prompt-info }

+ 서버에 보내려는 데이터를 URL 경로에 추가할 수 있다.

```java
// [Request sample]
// GET http://localhost:8080/hello/request/star/Robbie/age/95
@GetMapping("/star/{name}/age/{age}")
@ResponseBody
public String helloRequestPath(@PathVariable String name, @PathVariable int age)
{
    return String.format("Hello, @PathVariable.<br> name = %s, age = %d", name, age);
}
```

- 데이터를 받기 위해서는 `/star/{name}/age/{age}` 이처럼 URL 경로에서 데이터를 받고자 하는 위치의 경로에 {data} 중괄호를 사용한다.
- `(@PathVariable String name, @PathVariable int age)`
    - 그리고 해당 요청 메서드 파라미터에 @PathVariable 애너테이션과 함께 {name} 중괄호에 선언한 변수명과 변수타입을 선언하면 해당 경로의 데이터를 받아올 수 있다.

## @RequestParam (=Query String)

### GET

> GET [http://localhost:8080/hello/request/form/param?name=Robbie&age=95](http://localhost:8080/hello/request/form/param?name=Robbie&age=95)
{: .prompt-info }

+ 서버에 보내려는 데이터를 URL 경로 마지막에 `?` 와 `&` 를 사용하여 추가할 수 있다.

```java
// [Request sample]
// GET http://localhost:8080/hello/request/form/param?name=Robbie&age=95
@GetMapping("/form/param")
@ResponseBody
public String helloGetRequestParam(@RequestParam String name, @RequestParam int age) {
    return String.format("Hello, @RequestParam.<br> name = %s, age = %d", name, age);
}
```

- 데이터를 받기 위해서는 `?name=Robbie&age=95` 에서 key 부분에 선언한 name과 age를 사용하여 value에 선언된 Robbie, 95 데이터를 받아올 수 있다.
- `(@RequestParam String name, @RequestParam int age)`
    - 해당 요청 메서드 파라미터에 @RequestParam 애너테이션과 함께 key 부분에 선언한 변수명과 변수타입을 선언하면 데이터를 받아올 수 있다.

### POST
> POST [http://localhost:8080/hello/request/form/param](http://localhost:8080/hello/request/form/param)
{: .prompt-info }

+ HTML의 form 태그를 사용하여 POST 방식으로 HTTP 요청을 보낼 수 있다.
- 이때 해당 데이터는 HTTP Body에 `name=Robbie&age=95` 형태로 담겨져서 서버로 전달된다.

```html
<form method="POST" action="/hello/request/form/model">
  <div>
    이름: <input name="name" type="text">
  </div>
  <div>
    나이: <input name="age" type="text">
  </div>
  <button>전송</button>
</form>
```

```java
// [Request sample]
// POST http://localhost:8080/hello/request/form/param
// Header
//  Content type: application/x-www-form-urlencoded
// Body
//  name=Robbie&age=95
@PostMapping("/form/param")
@ResponseBody
public String helloPostRequestParam(@RequestParam String name, @RequestParam int age) {
    return String.format("Hello, @RequestParam.<br> name = %s, age = %d", name, age);
}
```

## RequestParam의 특징
+ 생략이 가능하다.
+ required 옵션을 false로 설정하면 Client에서 전달받은 값들에서 해당 값이 포함되어있지 않아도 오류가 발생하지 않는다. default는 true이다. (PathVariable도 가능!)
+ 이 때, Client로 부터 값을 전달 받지 못한 해당 변수는 **null로 초기화**된다.
