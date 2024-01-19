---
title: IOC
date: 2024-01-19 10:39
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Spring docs에서의 IoC (Inversion of Controller)
+ [Spring Docs](https://docs.spring.io/spring-framework/reference/core/beans/introduction.html)의 내용이다.

![[ioc.png]]

+ Spring 의 핵심 기술을 소개하는 Docs에서 가장 처음으로 IoC 컨테이너에 대해서 설명하고 있다.
- 그리고 IoC에 대해 ‘**IoC는 DI로도 알려져 있다**’ 라고 소개하고 있다.
- 의역해보자면 ‘**[[DI]] 패턴을 사용하여 IoC 설계 원칙을 구현하고 있다, 의존성 주입을 통해 제어의 주체를 이동시킨다.**’ 라고 이해할 수 있다.

## IoC (제어의 ~~역전~~) 역제어, 제어의 이동
IoC란 **메인 프로그램에서 컨테이너나 프레임워크로 객체와 객체의 의존성에 대한 제어(control)를 옮기는 것**을 말한다. 하지만 나는 IoC에 대한 개념은 알고 있었는데, 그래서 제어의 역전이라는 단어를 보았을 때 매칭이 되지 않는 느낌이 들었다. 왜 역전이지..? 아무리 생각해도 역전이라는 단어는 맞지 않는 것 같다.

### 역전
"역전(逆轉)이란, 정상적으로 가다가 형세가 반대로 뒤집히는 것을 뜻한다." 라고 되어 있다. 하지만 제어가 뒤집힌다..는건 맞지 않다고 생각한다. 뭔가 Inversion을 번역하는 과정에서 역전이라고 된 것 같은데, 막상 또 Inversion은 역전보다는 반전이라는 뜻이 더 어울린다. 차라리 반전이라고 하면 어떻게 이해할 여지가 있을 것 같은데 말이다.

### 이동
나는 IoC는 제어의 역전이 아니라 **제어의 이동**이라는 표현이 더 맞다고 생각한다. 원래 제어를 가지고 있던 객체에서 결합도를 낮추고 응집도를 높이기 위해 **제어를 각 상태를 가지고 있는 객체로 이동시키는 것**으로 이해했기 때문이다.

## IoC 예시 
### 강한 결합
다음 예시를 한번 보자. Controller1이 Service1 객체를 직접 생성하여 사용하고 있고, Service1이 Repository1 객체를 생성하여 사용하고 있다.

```java
public class Controller1 {
	private final Service1 service1;

	public Controller1() {
		this.service1 = new Service1();
	}
}

public class Service1 {
	private final Repository1 repository1;

	public Service1() {
		this.repository1 = new Repository1();
	}
}

public class Repository1 { ... }
```

만약 여기서 Repository1에 변경점이 생긴다면(생성자 변경 등), 그 변경점으로 인해 모든 Controller와 모든 Service의 코드 변경이 필요해지게 된다!

![[ioc2.png]]

### 강한 결합 해결하기
>
>1. 각 객체에 대한 객체 생성은 딱 1번만!
>2. 생성된 객체를 모든 곳에서 재사용!
>3. **생성자 주입**을 사용하여 필요로 하는 객체에 해당 객체 주입! (객체의 불변성을 지킬 수 있다!)


1. Repository1 클래스 선언 및 객체 생성 → repository1

```java
public class Repository1 { ... }

// 객체 생성
Repository1 repository1 = new Repository1();
```

2. Service1 클래스 선언 및 객체 생성 (repostiroy1 사용) → service1

```java
Class Service1 {
	private final Repository1 repitory1;

	// repository1 객체 사용
	public Service1(Repository1 repository1) {
		this.repository1 = new Repository1(); // 삭제!!
		this.repository1 = repository1; // 이렇게 변경
	}
}

// 객체 생성
Service1 service1 = new Service1(repository1);
```

3. Contoller1 선언 ( service1 사용)

```java
Class Controller1 {
	private final Service1 service1;

	// service1 객체 사용
	public Controller1(Service1 service1) {
		this.service1 = new Service1(); // 삭제!!
		this.service1 = service1; // 이렇게 변경
	}
}
```

### 개선 결과
+ **Repository1** 생성자가 변경되어도 **Controller나 Service의 변경이 필요 없다!**
+  **Service1** 생성자가 변경되어도** Controller의 변경이 필요없다!**
결론적으로, **강한 결합에서 느슨한 결합**이 되었다고 말할 수 있다.

![[ioc3.png]]


## 제어의 흐름이 뒤바뀜
강한 결합 상태의 제어 흐름은 Controller ⇒ Service ⇒ Repository 였다. 하지만 [[DI]](의존성 주입) 중에서도 생성자 주입을 통해 **제어의 흐름을 Repository ⇒ Service ⇒ Controller로 역전**함으로써 효율적인 코드로 변경하였다.