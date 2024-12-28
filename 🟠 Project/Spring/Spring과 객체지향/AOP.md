#Spring 


## AOP(Aspect-Oriented Programming)
Spring AOP(Aspect-Oriented Programming)는 관점 지향 프로그래밍의 한 형태로, 애플리케이션에서 특정 기능을 여러 모듈에 걸쳐서 공통적으로 적용하고 싶을 때 유용한 기술이다. Spring AOP는 [[Proxy Pattern]]를 활용하여 구현된다. 이를 통해 원본 객체를 감싸고, 특정 기능을 추가하거나 수정하여 제어를 캡슐화할 수 있다.

![[AOP.png]]

## AOP 동작
### AOP 사용 전
![[before.png]]

![[before2.png]]

### AOP 사용 후
+ 중간에 프록시 객체를 만들어 넣는다. [[🟠 Project/JPA/트랜잭션/트랜잭션|트랜잭션]]도 같은 방식이다.

![[after.png]]

![[after2.png]]

## AOP의 목적
1. **관심사의 분리 (Separation of Concerns):** 기능의 관심사를 여러 모듈로부터 분리하여 모듈 간의 결합도를 낮추고 유지보수성을 향상시킨다.
2. **코드 재사용 (Code Reusability):** 공통 기능을 하나의 모듈로 추상화하여 필요한 곳에서 재사용할 수 있도록 한다.
3. **클린 코드 유지 (Maintaining Clean Code):** 핵심 비즈니스 로직과 관점 지향 코드를 분리함으로써 코드의 가독성과 유지보수성을 향상시킨다.

## AOP 사용
1. **로깅(Logging):** 메서드 호출 시간, 매개변수, 반환 값 등을 로깅하는 용도로 사용된다.
2. **트랜잭션(Transaction):** 트랜잭션의 시작과 종료 시점을 정의하여 메서드 호출 전후로 트랜잭션을 관리한다.
3. **보안(Security):** 사용자 인증 및 권한 검사와 같은 보안 기능을 추가할 수 있다.
4. **캐싱(Caching):** 메서드의 결과를 캐시하여 성능을 향상시킨다.
5. **예외 처리(Exception Handling):** 예외가 발생할 때 추가적인 로직을 수행하거나 예외를 처리한다.

## Annotation
1. `@Aspect`: 관점 클래스를 정의하는 어노테이션이다. Bean 클래스에만 적용 가능하다. ( = AOP 적용할 것이다.)

### Advice
1. `@Before`: 메서드 실행 전에 실행되는 어드바이스를 정의한다.
2. `@After`: 메서드 실행 후에 실행되는 어드바이스를 정의한다.
3. `@Around`: 메서드 실행 전후에 실행되는 어드바이스를 정의하고, 메서드 호출 전후의 제어를 가져간다. (Before + After)
4. `@AfterFeturning` : '핵심기능' 호출 성공 시 (함수의 Return 값 사용 가능)
5. `@@AfterThrowing` : '핵심기능' 호출 실패 시. 즉, 예외 (Exception) 가 발생한 경우만 동작 (ex. 예외가 발생했을 때 개발자에게 email 이나 SMS 보냄)
6. `@Pointcut`: 어드바이스를 적용할 대상 메서드를 지정한다.

## 포인트컷
AOP에서 포인트컷(Pointcut)은 어디에 관심을 가져야 하는지를 정의하는 표현식이다. 즉 **Advice(어드바이스)가 적용될 대상(시점)을 결정**하는데 사용된다. 포인트컷은 대부분 메서드 실행 지점을 지정하는 것이 일반적이지만, 필드 접근, 생성자 호출, 예외 발생 등 다양한 지점도 포인트컷으로 지정할 수 있다.

AOP에서는 AspectJ 표현식을 사용하여 포인트컷을 정의한다. AspectJ 표현식은 `execution`, `within`, `this`, `target`, `args` 등의 키워드를 사용하여 메서드 실행, 클래스, 인터페이스, 인자 등을 지정한다.

1. **메서드 실행 지점**: 특정 패키지, 클래스, 메서드 이름 또는 메서드 시그니처를 기준으로 메서드 실행 지점을 지정한다.
2. **메서드 호출 지점**: 특정 패키지, 클래스, 메서드 이름 또는 메서드 시그니처를 호출하는 지점을 지정한다.
3. **생성자 호출 지점**: 특정 클래스의 생성자 호출을 지정한다.
4. **필드 접근 지점**: 특정 클래스의 필드에 접근하는 지점을 지정한다.
5. **예외 발생 지점**: 특정 패키지, 클래스, 메서드에서 예외가 발생하는 지점을 지정한다.

### 포인트컷 표현식
+ ?는 생략 가능하다.
```java
execution(modifiers-pattern? return-type-pattern declaring-type-pattern? method-name-pattern(param-pattern) throws-pattern?)
```

+ ex)
```
@Around("execution(public * com.sparta.myselectshop.controller..*(..))")
public Object execute(ProceedingJoinPoint joinPoint) throws Throwable { ... }
```

### modifiers-pattern
+ `public`, `private`, `*`
### return-type-pattern
+ `void`, `String`, `List<String>`, `*`

### declaring-type-pattern
- 클래스명 (패키지명 필요)
- **com.sparta.myselectshop.controller.*** → controller 패키지의 모든 클래스에 적용
- **com.sparta.myselectshop.controller..** → controller 패키지 및 하위 패키지의 모든 클래스에 적용
### method-name-pattern(param-pattern)
- 함수명
    - **addFolders** : addFolders() 함수에만 적용
    - **add*** : add 로 시작하는 모든 함수에 적용
- 파라미터 패턴 (param-pattern)
    - **(com.sparta.myselectshop.dto.FolderRequestDto)** - FolderRequestDto 인수 (arguments) 만 적용
    - **()** - 인수 없음
    - **(*)** - 인수 1개 (타입 상관없음)
    - **(..)** - 인수 0~N개 (타입 상관없음)

### @Pointcut
+ 포인트컷 재사용 가능
+ 포인트컷 결합(combine) 가능

```java
@Component
@Aspect
public class Aspect {
	@Pointcut("execution(* com.sparta.myselectshop.controller.*.*(..))")
	private void forAllController() {}

	@Pointcut("execution(String com.sparta.myselectshop.controller.*.*())")
	private void forAllViewController() {}

	@Around("forAllContorller() && !forAllViewController()")
	public void saveRestApiLog() {
		...
	}

	@Around("forAllContorller()")
	public void saveAllApiLog() {
		...
	}	
}
```