---
title: Spring MVC
date: 2024-01-17 15:17
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Spring MVC
[https://docs.spring.io/spring-framework/reference/web/webmvc.html](https://docs.spring.io/spring-framework/reference/web/webmvc.html)

Spring Web MVC는 Servlet API를 기반으로 구축된 독창적인 웹 프레임워크로, 처음부터 Spring Framework에 포함되어 왔으며, 정식 명칭인 "Spring Web MVC"는 소스 모듈(spring-webmvc)의 이름에서 따왔으나, "Spring MVC"로 더 일반적으로 알려져 있다.

Spring MVC는 중앙에 있는 **DispatcherServlet**이 요청을 처리하기 위한 공유 알고리즘을 제공하는 **[[Front Controller]] 패턴**을 중심으로 설계되어 있으며 이 모델은 유연하고 다양한 워크 플로우를 지원한다.
쉽게 표현하면 ‘Spring에서 MVC 디자인 패턴을 적용하여 HTTP 요청을 효율적으로 처리하고 있다’ 라고 할 수 있다.

## 3 Layer Architecture
+ 서버 개발자들은 서버에서의 처리과정이 대부분 비슷하다는 걸 깨닫고 처리 과정을 **Controller, Service, Repository** 3개의 계층으로 나누어 처리한다.

### Controller
- 클라이언트의 요청을 받는다.
- 요청에 대한 로직 처리는 Service에게 전담한다.
- Request 데이터가 있다면 Service에 같이 전달한다.
- Service에서 처리 완료된 결과를 클라이언트에게 응답한다.

### Service
- 사용자의 요구사항을 처리 ('비즈니스 로직') 하는 **실세 중에 실세**이다.
+ 따라서 현업에서는 서비스 코드가 계속 비대해지고 있다.
- DB 저장 및 조회가 필요할 때는 Repository에게 요청한다.

### Repository
- DB를 관리 (연결, 해제, 자원 관리) 한다.
- DB **CRUD** 작업을 처리한다.

