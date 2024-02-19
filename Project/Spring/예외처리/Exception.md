#Spring 

## Exception
@RestControllerAdvice를 사용하여 예외처리를 [[AOP]] 방식으로 관리한다.

![[exception.png]]

## ResponseEntity
ResponseEntity는 HTTP response object 를 위한 Wrapper입니다. 다음과 같은 것들을 담아서 response로 내려주면 아주 간편하게 처리가 가능하다.
- HTTP status code
- HTTP headers
- HTTP body

## @ExceptionHandler
- FolderController 의 모든 메서드에 예외처리 적용 (AOP) : `@ExceptionHandler`
    - `@ExceptionHandler` 는 Spring에서 예외처리를 위한 애너테이션이다.
    - 이 애너테이션은 특정 Controller에서 발생한 예외를 처리하기 위해 사용된다.
    - `@ExceptionHandler`가 붙어있는 메서드는 Controller에서 예외가 발생했을 때 호출 되며, 해당 예외를 처리하는 로직을 담고 있다.
    - **AOP**를 이용한 예외처리 방식이기때문에, 위에서 본 예시처럼 메서드 마다 **try catch**할 필요없이 깔금한 예외처리가 가능하다.
