---
title: 3 layer annotation
date: 2024-01-19 15:18
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## 3 Layer Annotation
- Spring 3 Layer Annotation은 Controller, Service, Repository의 역할로 구분된 클래스들을 ‘Bean’으로 등록할 때 해당 ‘Bean’ 클래스의 역할을 명시하기위해 사용된다.
- Controller는 [[Front Controller]] 패턴의 DispatcherServlet 실행 과정에서 생성되어 사용된다.

1. @Controller, @RestController
2. @Service
3. @Repository

+ Spring 3 Layer Annotation은 모두 @Component가 추가되어있다.

![[layerannotation.png]]