---
title: Servlet Container
date: 2024-01-17 15:47
categories:
  - Spring
  - Servlet
tags:
  - Spring
  - Servlet
image: 
path:
---

## Servlet Container
+ **Servlet들을 위한 상자(Container)** 이다. 
+ Servlet들을 관리해주는 컨테이너 역할을 한다.
- Web Server 또는 응용 프로그램 서버의 일부
- Web Server에서 온 요청을 받아 **servlet Class를 관리하는 역할(생명주기)** 을 한다.
- Container의 Servlet에 대한 설정은 Deployment Descriptor(web.xml)파일을 이용
- Servlet들의 생성, 실행, 삭제를 담당한다.
- **대표적으로 Tomcat**이 있다.
- 웹 서버와 소켓을 만들어 통신하며 JSP(java server page)와 Servlet이 작동할 수 있는 환경을 제공한다.
- [[JVM]]이 각 요청을 분리된 자바 스레드 내부에서 처리하도록 하는 것

### Servlet Container의 역할
- 웹 서버와의 통신을 지원한다.
- [[Servlet Life cycle]]을 관리한다.
- Multithread를 지원 및 관리한다.
- 보안과 관련된 내용을 관리한다.

>Servlet Container의 가장 중요한 기능은 요청을 올바른 Servlet에 전달해서 처리되도록 하고, JVM이 해당 요청을 처리한 후에는 생성된 결과를 올바른 장소에 동적으로 반환해주는 것이다.
{: .prompt-info }
