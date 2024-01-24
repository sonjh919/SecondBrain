---
title: Bean 수동 등록
date: 2024-01-24 10:31
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Bean 수동 등록?
### Bean 자동 등록의 이점
- @Component를 사용하면 @ComponentScan에 의해 자동으로 스캔되어 해당 클래스를 Bean으로 등록 해준다.
- 일반적으로 @Component를 사용하여 Bean을 자동으로 등록하는 것이 좋다.
+ 프로젝트의 규모가 커질 수록 등록할 Bean들이 많아지기 때문에 자동등록을 사용하면 편리하다.
+ 비즈니스 로직과 관련된 클래스들은 그 수가 많기 때문에 @Controller, @Service와 같은 애너테이션들을 사용해서 Bean으로 등록하고 관리하면 개발 생산성에 유리하다.'

### Bean 수동 등록?
- **기술적인 문제나 공통적인 관심사를 처리할 때 사용하는 객체**들을 수동으로 등록하는 것이 좋다.
+ 공통 로그처리나 암호화 등과 같은 비즈니스 로직을 지원하기 위한 **부가적이고 공통적인 기능**들을 **기술 지원 Bean**이라 부르고 수동등록 한다.
+ 비즈니스 로직 Bean 보다는 그 수가 적기 때문에 수동으로 등록하기 부담스럽지 않다.
+ 또한 수동등록된 Bean에서 문제가 발생했을 때 해당 위치를 파악하기 쉽다는 장점이 있다.

### Bean을 수동 등록하는 방법
- Bean으로 등록하고자하는 객체를 반환하는 메서드를 선언하고 @Bean을 설정한다.
- Bean을 등록하는 메서드가 속한 해당 클래스에 @Configuration을 설정한다.
- Spring 서버가 뜰 때 Spring IoC 컨테이너에 'Bean'으로 저장된다.
- 이때, Bean의 이름은 @Bean이 설정된 메서드명이다.

```java
@Configuration
public class PasswordConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}

// 1. @Bean 설정된 메서드 호출
PasswordEncoder passwordEncoder = passwordConfig.passwordEncoder();

// 2. Spring IoC 컨테이너에 빈 (passwordEncoder) 저장
// passwordEncoder -> Spring IoC 컨테이너
```