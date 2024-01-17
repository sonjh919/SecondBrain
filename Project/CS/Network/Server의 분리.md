---
title: Server의 분리
date: 2024-01-16 23:36
categories:
  - CS
  - Network
tags:
  - CS
  - Network
  - Spring
image: 
path:
---

## Web Server와 Web Application Server(WAS)

## Web Server
+ 브라우저에서 URL을 입력하여 어떠한 페이지를 요청했을 때 HTTP의 요청을 받아들여 HTML 문서와 같은 **정적인 콘텐츠를 사용자에게 전달해주는 역할**을 하는 것이 Web Server이다.
+ 종류로는 **Apache**, Nginx 등이 있다.

### Web Server의 역할
+ 정적인 콘텐츠 즉, 이미 완성이 되어있는 HTML과 같은 문서를 브라우저로 전달한다.
+ 브라우저로부터 ‘로그인하여 MyPage를 요청’과 같은 동적인 요청이 들어왔을 때 웹 서버 자체적으로 처리하기 어렵기 때문에 해당 요청을 WAS에 전달한다.

## WAS(Web Application Server)
### WAS
+ WAS는 웹 서버와 똑같이 HTTP 기반으로 동작이 된다.
+ 웹 서버에서 할 수 있는 기능 대부분을 WAS에서도 처리할 수 있다.
+ WAS를 사용하면 로그인,회원가입을 처리하거나 게시물을 조회하거나 정렬하는 등의 다양한 로직들을 수행하는 프로그램을 동작시킬 수 있다.
+ 종류로는 **Tomcat(Servlet+JSP)**, JBoss 등이 있다.


## Web Server VS WAS
![[wswas.png]]


---

## Apache Tomcat이란?
+ Tomcat은 동적인 처리를 할 수 있는 웹 서버를 만들기 위한 **웹 컨테이너**이다.
+ Tomcat은 Java Servlet, JavaServer Pages (JSP), 그리고 Java 서버 사이드 컴포넌트들을 실행하기 위한 웹 컨테이너로 자주 사용된다.
+ Apache Tomcat이란 Apache와 Tomcat이 합쳐진 형태로 정적인 데이터 처리와 동적인 데이터 처리를 효율적으로 해줄 수 있다. (WAS만 쓰는 것 보다 효율적!)
![[apacheTomcat.png]]

### 웹 컨테이너
+ 웹 응용 프로그램을 실행하기 위한 환경을 제공하는 소프트웨어 패키지이다. 
+ 일반적으로 웹 서버와 관련된 기능들을 포함하며, 웹 어플리케이션의 배포, 실행, 관리를 쉽게 만들어준다.
+ 일반적으로 정적 콘텐츠를 처리하는 웹 서버와 동적인 콘텐츠를 처리하는 웹 컨테이너를 함께 사용하여 웹 어플리케이션을 호스팅하는 경우가 많다. 즉, **Web Server + WAS**