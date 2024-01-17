---
title: Servlet Life Cycle
date: 2024-01-17 15:41
categories:
  - Spring
  - Servlet
tags:
  - Spring
  - Servlet
image: 
path:
---


## Life Cycle
1. 첫 번째 요청일 경우, **객체를 생성**하며 **init( )** 메소드를 호출한다.
2. 이 후 작업이 실행 될 때마다 **service()** 메소드가 요청한 HTTP Type에 따른 **doGet(), doPost()** 메소드 호출
3. 최종적으로 Servlet이 서비스 되지 않을 때 **destroy()** 메소드가 호출. 서버가 종료되었을 때, Servlet의 내용이 변경되어 재 컴파일 될 때 호출한다.

![[lifecycle.png]]

## Servlet의 구동
- Servlet은 **Web Server와 WAS를 포함**한다.
- Servlet 내에서 **Request를 Web Server → WAS로 전달**해준다.

1. 사용자가 Client(브라우저)를 통해 서버에 HTTP Request 즉, API 요청을 한다.
2. 요청을 받은 Servlet 컨테이너는 HttpServletRequest, HttpServletResponse 객체를 생성한다. 이 객체는 약속된 HTTP의 규격을 맞추면서 쉽게 HTTP에 담긴 데이터를 사용하기 위한 객체이다.
3. 설정된 정보를 통해 어떠한 Servlet에 대한 요청인지 찾는다.
4. 해당 Servlet에서 service 메서드를 호출한 뒤 브라우저의 요청 Method에 따라 doGet 혹은 doPost 등의 메서드를 호출한다.
5. 호출한 메서드들의 결과를 그대로 반환하거나 동적 페이지를 생성한 뒤 HttpServletResponse 객체에 응답을 담아 Client(브라우저)에 반환한다.
6. 응답이 완료되면 생성한 HttpServletRequest, HttpServletResponse 객체를 소멸한다.

![[lifecycle2.png]]