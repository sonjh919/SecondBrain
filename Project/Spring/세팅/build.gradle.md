---
title: build.gradle
date: 2024-01-19 16:05
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## build.gradle
- build.gradle은 Gradle 기반의 빌드 스크립트이다.
- 이 스크립트를 작성하면 소스 코드를 빌드하고 라이브러리들의 의존성을 쉽게 관리할 수 있다.
- **groovy** 혹은 kotlin 언어로 스크립트를 작성할 수 있다.

> groovy
> [[JVM]] 위에서 동작하는 동적 타입 프로그래밍 언어이다.
{: .prompt-info }

우리가 개발을 하면서 필요로하는 외부 라이브러리들을 dependencies 부분에 작성하면 Gradle이 해당 라이브러리들을 [Maven Repository](https://mvnrepository.com/) 와 같은 외부 저장소에서 자동으로 다운로드해온다. 또한 **다른 라이브러리들과의 의존성을 자동으로 관리**해 주기 때문에 라이브러리들간의 충돌 걱정없이 개발에만 집중할 수 있다.

> Maven Repository
> 라이브러리들을 모아둔 저장소이다. 이 곳에서 필요한 라이브러리를 검색하여 사용할 수 있다.
{: .prompt-info }

![[buildGradle.png]]

## External Libraries
External Libraries에서 Gradle이 다운로드해온 라이브러리들을 확인할 수 있다.

![[externalLibraries.png]]


---

## build.gradle 의존성들

```
dependencies {  
	// Security  
	implementation 'org.springframework.boot:spring-boot-starter-security'  
	  
	// JWT  
	compileOnly group: 'io.jsonwebtoken', name: 'jjwt-api', version: '0.11.5'  
	runtimeOnly group: 'io.jsonwebtoken', name: 'jjwt-impl', version: '0.11.5'  
	runtimeOnly group: 'io.jsonwebtoken', name: 'jjwt-jackson', version: '0.11.5'
    
    // JPA 구현체인 hibernate
	//  implementation 'org.hibernate:hibernate-core:6.1.7.Final'
    
	// JPA 설정
	implementation 'org.springframework.boot:spring-boot-starter-data-jpa'

	// HATEOAS
	implementation 'org.springframework.boot:spring-boot-starter-hateoas'

	// JDBC
	// implementation 'org.springframework.boot:spring-boot-starter-data-jdbc'  
    
    // MYSQL  
    implementation 'mysql:mysql-connector-java:8.0.28'  

	// thymeleaf
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'  
    
    // Spring Web
    implementation 'org.springframework.boot:spring-boot-starter-web'  

	// Lombok
    compileOnly 'org.projectlombok:lombok'  
    annotationProcessor 'org.projectlombok:lombok'  
    testImplementation 'org.springframework.boot:spring-boot-starter-test'  
}
```