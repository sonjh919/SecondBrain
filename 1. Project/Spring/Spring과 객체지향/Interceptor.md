#Spring 

## Interceptor
스프링 인터셉터(Interceptor)는 Spring MVC에서 HTTP 요청의 처리 과정 중에 필요한 로직을 삽입하거나 제어할 수 있는 기능을 제공하는 인터페이스이다. 인터셉터는 필터(Filter)와 유사한 역할을 하지만, **스프링 컨텍스트 내부에서 동작하며 스프링 빈으로 관리**된다.

### 메서드
1. **preHandle**: 요청 처리 전에 호출되는 메서드로, 컨트롤러 메서드 실행 전에 실행되며, 반환값으로 boolean 값을 반환하여 요청 처리 계속 여부를 결정한다.
2. **postHandle**: 요청 처리 후에 호출되는 메서드로, 컨트롤러 메서드 실행 후에 실행되며, ModelAndView 객체를 가지고 있어서 컨트롤러에서 모델에 데이터를 추가하거나 뷰를 변경할 수 있다.
3. **afterCompletion**: 요청 완료 후에 호출되는 메서드로, 뷰 렌더링이 완료된 후에 실행되며, 예외 정보를 파라미터로 전달 받을 수 있다.

### 인터셉터 구현 단계
1. **HandlerInterceptor 인터페이스 구현**: HandlerInterceptor 인터페이스를 구현하여 preHandle, postHandle, afterCompletion 메서드를 오버라이딩한다.
2. **인터셉터 등록**: 인터셉터를 등록하기 위해 WebMvcConfigurer 인터페이스를 구현하고 addInterceptors 메서드를 오버라이딩하여 인터셉터를 등록한다.
3. **인터셉터 우선순위 조절**: 등록된 인터셉터의 실행 순서를 조절할 수 있다. 인터셉터의 우선순위는 addInterceptors 메서드에서 등록한 순서대로 실행된다.

## HandlerInterceptor
+ 각 메서드의 반환값이 true이면  핸들러의 다음 동작이 실행되지만
false이면 중단되어서 남은 인터셉터와 컨트롤러가 실행되지 않는다.
+ Servlet 3.0 부터 AsyncHandlerInterceptor를 이용한 비동기 요청이 가능하다.

```java
public interface HandlerInterceptor {

    default boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        return true;
    }

    default void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            @Nullable ModelAndView modelAndView) throws Exception {
    }

    default void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
            @Nullable Exception ex) throws Exception {
    }
}
```

### preHandle
preHandle 메서드는 지정된 컨트롤러의 동작 이전에 가로채는 역할로 사용한다. HttpServletRequest, HttpServletResponse, Object handler로 구성된다. 마지막의 Handler는 현재 실행하려는 **메소드 자체**를 의미하는데, 이를 활용하면 **현재 실행되는 컨트롤러를 파악**하거니, **추가적인 메소드를 싱행하는 등의 작업이 가능**하다.

```java
preHandle(request, response, handler)
```

### postHandle
지정된 컨트롤러의 동작 이후에 처리하며, Spring MVC의 [[Front Controller]]인 DispatcherServlet이 **화면을 처리하기 전에 동작**한다.

```java
postHandle(request, response, handler, modelAndView)
```

### afterCompletion
DispatcherSerlvet의 **화면 처리(뷰)가 완료된 상태에서 동작**한다.
```java
afterCompletion(request, response, handler, exception)
```