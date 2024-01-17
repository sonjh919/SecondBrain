---
title: Forward와 Redirect
date: 2024-01-17 00:55
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---

웹은 현재 작업중인 페이지에서 다른 페이지로 이동하기 위해 2가지 페이지 전환 기능을 제공한다. 그 두가지 방법에는 Forward와 Redirect가 있다.

## Forward (전달)
Web Container 차원에서 페이지의 이동만 존재한다. 실제로 웹 브라우저는 다른 페이지로 이동했음을 알 수 없다. 그렇기 때문에 웹 브라우저에는 최초에 호출한 URL이 표시되고, 이동한 페이지의 URL 정보는 확인할 수 없다. 또한 현재 실행중인 페이지와 forward에 의해 호출될 페이지는 Request 객체와 Response 객체를 공유한다. **Foward는 다음으로 이동 할 URL로 요청정보를 그대로 전달**하기 때문에 사용자가 최초로 요청한 요청정보는 다음 URL에서도 유효하다.

시스템에 변화가 생기지 않는 단순 조회 요청의 경우 forward가 바람직하다.
## Redirect (재지정)
Redirect는 Web Container로 명령이 들어오면, 웹 브라우저에게 다른 페이지로 이동하라고 명령을 내린다. 그러면 웹 브라우저는 **URL을 지시된 주소로 바꾸고 해당 주소로 이동**한다. 다른 웹 컨테이너에 있는 주소로 이동하며 새로운 페이지에서는 Request와 Response객체가 새롭게 생성된다.

시스템에 변화가 생기는 요청(회원가입, 글쓰기 등)의 경우에는 redirection을 사용하는 것이 바람직하다.
