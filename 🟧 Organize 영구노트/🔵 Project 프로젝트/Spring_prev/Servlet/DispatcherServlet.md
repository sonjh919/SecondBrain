---
title: Dispatcher Servlet
date: 2024-01-17 15:47
categories:
  - Spring
  - Servlet
tags:
  - Spring
  - Servlet
image: 
path:
---
#Spring #Servlet 

## DispatcherServlet과 Front Controller
- 모든 API 요청을 앞서 살펴본 서블릿의 동작 방식에 맞춰 코드를 구현한다면 무수히 많은 Servlet 클래스를 구현해야 한다.
- 따라서 Spring은 **DispatcherServlet을 사용하여 [[Front Controller Pattern]] 방식**으로 API 요청을 효율적으로 처리하고 있다.

### DispatcherServlet의 장점
무수히 많은 Servlet Code를 구현하는 대신 하나의 Controller에서 모든 요청을 처리할 수 있다.

+ Servlet Code

```java
@WebServlet(urlPatterns = "/user/login")  
public class UserLoginServlet extends HttpServlet {  
    @Override  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {  
        // ...   
}    
}
```

+ Controller Code
```java
@Controller  
@RequestMapping("/user")  
public class UserController {  
    @GetMapping("/login")  
    public String login() {  
        // ...  
    }
```

## DispatcherServlet의 동작과정
+ Front Controller Pattern 방식으로 동작한다.
![[🟧 Organize 영구노트/🟤 Archive 보관소/img/Spring/frontController.png]]

1. **Client(브라우저)** 에서 **HTTP 요청**이 들어오면 **DispatcherServlet** 객체가 요청을 분석한다.
2. **DispatcherServlet** 객체는 분석한 데이터를 토대로 **Handler mapping**을 통해 **Controller**를 찾아 요청을 전달해 준다.

> [!example]+ 
> + GET /api/hello → `HelloController` 의 hello() 함수
> + GET /user/login → `UserController` 의 login() 함수
> + GET /user/signup → `UserController` 의 signup() 함수
> + POST /user/signup → `UserController` 의 registerUser() 함수


- **Handler mapping** 에는 API path 와 Controller 메서드가 매칭되어 있다.
- 직접 Servlet을 구현하지 않아도 DispatcherServlet에 의해 간편하게 HTTP 요청을 처리할 수 있다.

    ```java
    @RestController
    public class HelloController {
        @GetMapping("/api/hello")
        public String hello() {
            return "Hello World!";
        }
    }
    ```

3. **Controller** → **DispathcerServlet**    
+ 해당 Controller는 요청에 대한 처리를 완료 후 처리에 대한 결과 즉, 데이터('**Model**')와 '**View' 정보**를 전달한다.
4. **DispatcherServlet** → **Client**
+ ViewResolver 통해 View에 Model을 적용하여 View를 Client에게 응답으로 전달한다.