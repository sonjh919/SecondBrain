---
title: HTTP Headers
date: 2024-01-21 16:36
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---

## Content-Location
post 요청은 대부분 idempotent(반환되는 응답 리소스의 결과가 항상 동일하다)하지 않다. 따라서 요청의 응답헤더에 새로 생성된 리소스를 식별할 수 있는 Content-Location 속성을 이용한다. [[HATEOAS]]로 대체할 수 있다.

```http
HTTP/1.1 200 OK
Content-Location: /users/1
```

## Content-Type
**application/json**을 우선으로 제공한다.

## Retry-After
비정상적인 방법(DoS, Brute-force attack)으로 API 서버를 이용하려는 경우 `429 Too Many Requests` [[HTTP 상태 코드]]로 오류 응답과 함께 일정 시간 뒤 요청할 것을 나타낸다. id, password를 이용한 로그인 작업 시, 서버 과부하를 목적으로 post 반복 호출 시 등이 있다. n시간동안 n회만 요청 가능 같은 제약을 걸 수 있다.

## Link
페이징 처리를 위해 사용한다. 자세한 내용은 github 방법을 따른다.
https://developer.github.com/v3/#pagination