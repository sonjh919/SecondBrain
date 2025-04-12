---
title: JWT
date: 2024-01-24 11:54
categories:
  - Spring
  - Security
tags:
  - Spring
  - Security
  - JWT
image: 
path:
---
#Spring #Security #JWT 

## JWT (JSON Web Token)
JWT([[JSON]] Web Token)란 인증에 필요한 정보들을 암호화시킨 토큰을 의미한다.  이 토큰은 JSON 포맷을 이용하여 사용자에 대한 속성을 저장하는 Claim 기반의 Web Token이다. 일반적으로 [[쿠키]] 저장소를 사용하여 JWT를 저장한다. [jwt.io](https://jwt.io/)를 이용하여 JWT를 사용할 수 있다.

## JWT 사용 이유
### 1. 서버가 1대인 경우
하나의 [[세션]](Session) 이 모든 Client의 로그인 정보를 소유하고 있다.

![[jwt1.png]]

### 2. 서버가 2대 이상인 경우
서버의 대용량 트래픽 처리를 위해 서버 2대 이상 운영이 필요할 수 있다. 이럴 경우, Session 마다 다른 Client 로그인 정보를 가지고 있을 수 있다. 만약 Client 1의 로그인 정보는 Server1에 저장되어 있는데, 로그인 정보를 가지고 있지 않은 Sever2 나 Server3 에 API 요청을 하게되면 문제가 발생하지 않을까? 이에 대한 해결 방법은 2가지가 있다.

1. Sticky Session: Client 마다 요청 Server룰 고정한다.
2. 세션 저장소를 생성하여 모든 세션을 저장한다.

![[jwt2.png]]
### 3. 세선 저장소 생성
Session storage 가 모든 Client 의 로그인 정보 소유하고 있기 때문에 모든 서버에서 모든 Client의 API 요청을 처리할 수 있다.

![[jwt3.png]]
### 4. JWT 사용
로그인 정보를 Server 에 저장하지 않고, Client 에 로그인 정보를 JWT 로 암호화하여 저장한 후, JWT를 통해 [[인증과 인가]]를 처리한다. 모든 서버에서 **동일한 Secret Key**를 소유하며, Secret Key를 통한 암호화와 위조 검증 (복호화 시)을 진행한다.

![[jwt4.png]]

![[jwt5.png]]

## JWT의 장단점
### 장점
+ 동시 접속자가 많을 때 서버 측 부하 낮춤

### 단점
- 구현의 복잡도 증가
- JWT 에 담는 내용이 커질 수록 네트워크 비용 증가 (클라이언트 → 서버)
- 기 생성된 JWT 를 일부만 만료시킬 방법이 없음
- Secret key 유출 시 JWT 조작 가능


## JWT 구조
- JWT 는 누구나 평문으로 복호화 가능하다.
- 하지만 **Secret Key** 가 없으면 JWT 수정 불가능하기 때문에, 결국 JWT 는 **Read only 데이터**이다.
+ **Payload**에 실제 유저의 정보가 들어있고, HEADER와 VERIFY SIGNATURE부분은 암호화 관련된 정보 양식이라고 생각하면 된다.
 
![[jwtstructure.png]]