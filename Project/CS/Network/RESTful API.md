---
title: RESTful API
date: 2024-01-16 23:19
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---

## REST(Representational State Transfer)
+ API 작동 방식에 대한 조건을 부과하는 소프트웨어 아키텍처이다.
+ 네트워크에서 통신을 관리하기 위한 지침으로 만들어졌다.

## REST-API (Representational State Transfer API)
+ REST 아키텍쳐 스타일을 따르는 api를 REST-API라고 한다.
+ **해당 자원의 상태를 주고 받는 모든 것**
+ 웹의 모든 자원에 고유한 id인 **http url**을 부여하고 **HTTP Method(Get, Post, Put, Delete)** 를 통해 해당 자원에 대한 **CRUD 연산**을 적용한다.
- **자원 기반 구조** (ROA : Resource Oriented Architecture)로 설계된 아키텍처를 의미

> 즉, 서버의 api가 적절하게 http를 준수하며 잘 설계되어있으면 RESTful 하게 설계되어 있다!
{: .prompt-info }

---
## REST의 구성

### 1. 자원 (Resource) : URL

- 모든 자원에는 고유한 **ID**가 존재하고, 이 자원은 Server에 존재한다.
- 자원을 구분하는 ID는 URL이다. ex) /orders/order-id/1

### 2. 행위(Verv) : HTTP Method

### GET (SELECT)

- 해당 자원을 조회한다.

### POST (CREATE)

- 해당 URL을 요청하면 자원을 생성한다.

### PUT (UPDATE)

- 해당 자원을 수정한다.

### DELETE

- 해당 자원을 삭제한다.

### 3. 표현 (Representations)

- 하나의 자원은 JSON, XML, TEXT, RSS등 여러 형태로 나타낼 수 있다.
- 최근에는 **JSON**으로 주고받는 것이 대부분이다.

---

## REST의 특징

### 1. Client-Server 구조

### Client

- 사용자 인증이나 로그인 정보 등을 직접 관리하고 책임진다.

### Server

- API를 제공하고, business logic 처리 및 저장을 책임진다.

### 무상태성 (Stateless)

- REST는 Http의 특성을 이용하기 때문에 **무상태성**을 가진다.
- Server에서는 상태정보를 기억할 필요가 없고 들어온 요청에 대한 처리만 한다 → 단순한 구현

### 캐시 처리 기능 (Cacheable)

- Http 명세를 따르기 때문에 **Cache** 사용이 가능하다.
    
- 캐시 사용을 통해 응답 시간이 빨라지고 REST Server transaction이 발생하지 않는다.
    
    → 전체 응답시간, 성능, 서버 자원 이용률이 향상된다.
    

### 자체 표현 구조 (Self - Descriptiveness)

- REST-API의 message만으로 그 요청이 어떤 행위를 하는지 손쉽게 이해할 수 있다.

### 계층화 (Layered System)

- Client와 Server가 분리되어 있기 때문에 Proxy Server, 암호화 layer 등 **중간 매체 사용 가능**
    
    → 높은 자유도
    

### 유니폼 인터페이스 (Uniform Interface)

- Http 표준만 따르면 모든 플랫폼에서 사용 가능
- URL로 지정한 자원에 대한 조작이 가능하게 하는 아키텍쳐 스타일
- 특정 언어나 기술에 종속되지 않는다.