---
title: Servlet
date: 2024-01-17 15:21
categories:
  - Spring
  - Servlet
tags:
  - Spring
  - Servlet
image: 
path:
---
#Spring #Servlet 

## Servlet
- Server + Applet(Application + let)
- **서버 안에서 동작하는 작은 프로그램** 이라는 뜻
- **사용자의 요청을 받아 처리하고 그 결과를 다시 사용자에게 전송**하는 역할의 **class 파일**
- 웹에서 동적인 페이지를 java로 구현한 서버측 프로그램

## Servlet이 수행하는 역할
+ **[[MVC]]에서 Controller로 이용된다.**
- **요청 받기** (HttpMethod GET/POST 요청에 따른 parameter로 전달받은 data를 꺼내 올 수 있다.)
- 비지니스 로직 처리 (DB 접속과 CRUD에 대한 logic 처리는 서비스를 호출하는 것으로 해결([[Spring MVC]])
- **응답하기** (문자열로 동적인 웹(HTML 태그) 페이지를 만들고 stream을 이용하여 내보내기)

## Servlet 설계 규약
- 모든 Servlet은 **javax.servlet.Servlet 인터페이스를 상속** 받아 구현한다.
- Servlet 을 구현 시 Servlet 인터페이스와 ServletConfig 인터페이스를 javax.servlet.GenericServlet에 구현한다.
- HTTP 프로토콜을 사용하는 Servlet은 javax.servlet.http.HttpServlet 클래스는 javax.servlet.GenericServlet를 상속한 클래스로 Servlet 은 httpServlet클래스를 상속받는다.
- Servlet의 Exception을 처리하기 위해서는 javax.servlet.ServletException을 상속 받아야 한다.
+ HttpServlet.class < GenericServlet.class(abstract class)< Servlet.interface
+ **결합 관계를 낮추고 타입/구현 은닉을 위해 해당 방식을 사용한다.**

## Servlet 동작 구조
- html을 사용하여 요청에 응답한다.
![[servletstructure.png]]

