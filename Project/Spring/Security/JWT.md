---
title: JWT
date: 2024-01-24 11:54
categories:
  - Spring
  - Security
tags:
  - Spring
  - Security
image: 
path:
---
## JWT (JSON Web Token)
JWT([[JSON]] Web Token)란 인증에 필요한 정보들을 암호화시킨 토큰을 의미한다.  이 토큰은 JSON 포맷을 이용하여 사용자에 대한 속성을 저장하는 Claim 기반의 Web Token이다. 일반적으로 [[쿠키]] 저장소를 사용하여 JWT를 저장한다.

## JWT 사용 이유
### 서버가 1대인 경우
+ Session1 이 모든 Client의 로그인 정보를 소유하고 있다.



### 서버가 2대인 경우
+ 서버의 대용량 트래픽 처리를 위해 서버 2대 이상 운영이 필요할 수 있다.
+ 

