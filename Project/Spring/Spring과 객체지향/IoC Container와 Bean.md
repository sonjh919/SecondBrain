---
title: IoC Container
date: 2024-01-19 12:29
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Spring IoC Container
[[DI]]를 이용하기 위해서는 객체 생성이 우선되어야 한다. 그렇다면 언제, 어디서, 누가 객체를 생성하는 걸까? 바로 Spring 프레임워크가 필요한 객체를 생성하고 관리하는 역할을 대신한다.

### 빈(Bean)
+ Spring이 관리하는 객체를 Bean이라고 한다.

### IoC Container
+ Bean을 모아둔 컨테이너

## Bean 등록하기
### @Component
+ ‘Bean’으로 등록하고자하는 클래스 위에 설정한다.
+ 설정된 클래스는 커피콩 모양으로 확인할 수 있다.

```java
@Component
public class MemoService { ... }
```

![[component.png]]

+ Spring 서버가 뜰 때 IoC 컨테이너에 'Bean'을 저장 해준다.

```java
// 1. MemoService 객체 생성
MemoService memoService = new MemoService();

// 2. Spring IoC 컨테이너에 Bean (memoService) 저장
// memoService -> Spring IoC 컨테이너
```

+ Spring Bean 이름은 **클래스의 앞글자만 소문자로 변경**된다.
+ 등록된 이름은 커피콩의 Select in Spring View를 확인하면 된다.

![[BeanName.png]]


### @ComponentScan
+ Spring 서버가 뜰 때 @ComponentScan에 **설정해 준 packages 위치와 하위 packages** 들을 전부 확인하여 @Component가 설정된 클래스들을 ‘Bean’으로 등록해준다.
+ @SpringBootApplication에 의해 default로 설정되어 있다. 

![[springbootapplication.png]]

### @Autowired
+ Spring에서 IoC 컨테이너에 저장된 ‘Bean’을 해당 필드에 DI 즉, 의존성을 주입 해준다.
+ **Spring 4.3 버전 이후로 생성자가 1개일 경우에만 생략 가능**하다.
+ 객체의 불변성을 확보할 수 있기 때문에 일반적으로는 **생성자**를 사용하여 DI하는 것이 좋다.
- set… Method를 만들고 **@Autowired**를 적용하여 DI 할 수도 있다.
+ Spring IoC 컨테이너에 의해 관리되는 클래스에서만 가능하다.
+ Spring IoC **컨테이너에 의해 관리되는 ‘Bean’객체만 DI에 사용될 수 있다.**
+ [[Lombok]]의 @RequiredArgsConstructor를 이용할 수도 있다.
+ [[ApplicationContext]]를 이용하여 수동으로 가져올 수도 있다.

![[autowired.png]]

