#SpringBoot #공식문서 

```cardlink
url: https://docs.spring.io/spring-boot/tutorial/first-application/index.html
title: "Developing Your First Spring Boot Application :: Spring Boot"
host: docs.spring.io
favicon: ../../_/img/favicon.ico
```

> [!summary]+ 
> + Hello World! 만들기!!
> + Maven과 Gradle 2개의 빌드 도구 선택하기!!

### MyApplication 만들기
1. [[build.gradle]]을 이용해 빌드 스크립트 작성하기.
2. `org.springframework.boot:spring-boot-starter-web` 의존성 추가하기.
3. 코드 작성!

```java
package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class MyApplication {

	@RequestMapping("/")
	String home() {
		return "Hello World!";
	}

	public static void main(String[] args) {
		SpringApplication.run(MyApplication.class, args);
	}

}
```

### @RestController, @RequestMapping
#### @RestController
+ MyApplication은 @RestController이므로 Spring은 **들어오는 웹 요청을 처리**할 때 이를 고려한다.
+ Spring에게 결과 문자열을 호출자에게 직접 응답하라고 지시한다.

> [!tip]+ Annotation
> 코드를 읽는 사람들과 Spring에게 이 [[Annotation]]이 특정한 역할을 한다는 힌트를 제공한다.
#### @RequestMapping
+ routing 정보를 제공한다.

> [!example]+ 
> Spring에 `/`path가 있는 모든 HTTP 요청은 `home` 메서드에 mapping된다.


> [!tip]+ 
> `@RestController`와 `@RequestMapping`은 Spring MVC에 정의되어 있다.


### @SpringBootApplication
+ 메타 어노테이션으로, `@SpringBootConfiguration`, `@EnableAutoConfiguration`, `@ComponentScan`을 포함하고 있다.

### @EnableAutoConfiguration
+ 추가한 jar dependencies을 기반으로 스프링을 구성하는 방법을 "추측"하도록 Spring Boot에 알려준다.

> [!example]+ 
> `spring-boot-starter-web`에 Tomcat과 Spring MVC가 추가되었기 때문에 auto-configuration은 사용자가 웹 애플리케이션을 개발 중이라고 가정하고 이에 따라 Spring을 설정한다.

### main
+ main 메서드는 `SpringApplication` 클래스의 `run` 메서드를 이용해 실행 권한을 위임한다.


## Running example
+ 실행 후 `localhost:8080`으로 요청하면, 결과를 얻을 수 있다.
