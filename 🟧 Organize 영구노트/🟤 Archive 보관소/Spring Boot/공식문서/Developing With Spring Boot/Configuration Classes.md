#SpringBoot #공식문서 


```cardlink
url: https://docs.spring.io/spring-boot/reference/using/configuration-classes.html
title: "Configuration Classes :: Spring Boot"
host: docs.spring.io
favicon: ../../_/img/favicon.ico
```

스프링 부트는 Java 기반 구성을 선호한다. XML 소스와 함께 SpringApplication을 사용할 수 있지만, 일반적으로 기본 소스는 단일 `@Configuration` 클래스로 설정하는 것이 좋다. 일반적으로 주요 메서드를 정의하는 클래스는 기본 `@Configuration`으로 좋은 후보이다.

> [!tip]+ 
> Spring은 xml로 세팅해야 하지만, Spring Boot는 annotation으로 세팅할 수 있어 편하다.


### Importing Additional Configuration Classes
모든 `@Configuration`을 하나의 클래스에 넣을 필요는 없다. `@Import` 주석은 추가 구성 클래스를 가져오는 데 사용할 수 있다. 또는 `@ComponentScan`을 사용하여 `@Configuration` 클래스를 포함한 모든 스프링 구성 요소를 자동으로 픽업할 수 있다.