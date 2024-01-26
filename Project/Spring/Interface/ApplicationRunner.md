---
title: ApplicationRunner
date: 2024-01-26 15:40
categories:
  - Spring
  - Interface
tags:
  - Spring
  - Interface
image: 
path:
---

## ApplicationRunner
+ **애플리케이션이 실행될 때 특정한 코드 블록을 실행**하고자 할 때 사용된다. 
+ 이 인터페이스를 구현하는 클래스는 `run` 메서드를 오버라이드하여 실행하고자 하는 코드를 정의한다.

```java
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

@Component
public class MyApplicationRunner implements ApplicationRunner {

    @Override
    public void run(ApplicationArguments args) throws Exception {
        System.out.println("ApplicationRunner executed with arguments: " + args.getOptionNames());
        // 여기에 실행하고자 하는 코드 추가
    }
}

```

### ApplicationArguments
애플리케이션 실행 시 전달된 명령행 인자들을 포함하는 객체이다. 이 객체를 통해 애플리케이션의 실행 환경에 대한 정보를 더 세밀하게 다룰 수 있다.