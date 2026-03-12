#SpringBoot #공식문서 


```cardlink
url: https://docs.spring.io/spring-boot/reference/using/structuring-your-code.html
title: "Structuring Your Code :: Spring Boot"
host: docs.spring.io
favicon: ../../_/img/favicon.ico
```

### "default" Package 지양하기
+ 클래스에 패키지 선언이 포함되지 않은 경우, 해당 클래스는 "기본 패키지"에 포함된 것으로 간주된다. "기본 패키지"의 사용은 일반적으로 권장되지 않으며 피해야 한다. 

> [!warning]+ 
> 모든 클래스가 모든 jar에서 읽히기 때문에 `@ComponentScan`, `@ConfigurationPropertiesScan`, `@EntityScan` 또는 `@SpringBootApplication` 주석을 사용하는 SpringBoot 애플리케이션에 특정한 문제를 일으킬 수 있다.

> [!info]+ 
> 일반적으로 다른 클래스보다 상위 루트 패키지에 메인 애플리케이션 클래스를 두는 것이 좋다.

```java
com
 +- example
     +- myapplication
         +- MyApplication.java
         |
         +- customer
         |   +- Customer.java
         |   +- CustomerController.java
         |   +- CustomerService.java
         |   +- CustomerRepository.java
         |
         +- order
             +- Order.java
             +- OrderController.java
             +- OrderService.java
             +- OrderRepository.java

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyApplication {

	public static void main(String[] args) {
		SpringApplication.run(MyApplication.class, args);
	}

}

```