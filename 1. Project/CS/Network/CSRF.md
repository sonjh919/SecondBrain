---
title: CSRF
date: 2024-01-24 22:31
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---
#CS #Network 

## CSRF(사이트 간 요청 위조, Cross-site request forgery)
- 공격자가 인증된 브라우저에 저장된 [[쿠키]]의 [[세션]] 정보를 활용하여 웹 서버에 사용자가 의도하지 않은 요청을 전달하는 것이다.
- CSRF 설정이 되어있는 경우 html 에서 CSRF 토큰 값을 넘겨주어야 요청을 수신 가능하다.
- 쿠키 기반의 취약점을 이용한 공격 이기 때문에 [[REST API]] 에서는 disable 가능하다.