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
2000년도에 로이 필딩 (Roy Fielding)의 박사학위 논문에서 최초로 소개되었다. 로이 필딩은 HTTP의 주요 저자 중 한 사람으로 그 당시 웹([[HTTP]]) 설계의 우수성에 비해 제대로 사용되어지지 못하는 모습에 안타까워하며 웹의 장점을 최대한 활용할 수 있는 아키텍처로써 REST를 발표했다. API 작동 방식에 대한 조건을 부과하는 소프트웨어 **아키텍처**이며, 네트워크에서 통신을 관리하기 위한 지침으로 만들어졌다.


## REST의 특징
대부분의 REST 아키텍처 조건은

**1)서버-클라이언트 구조의 웹서비스 아키텍처에서**
**2)REST 가이드에 따라 자원 중점적 URL 패턴을 사용하고**
**3)HTTP 프로토콜을 사용한다면**

만족하게 된다.

### 1. Client-Server 구조
Client는 사용자 인증이나 로그인 정보 등을 직접 관리하고 책임진다. REST Server는 API를 제공하고, business logic 처리 및 저장을 책임진다. 이로 인해 개발 내용이 명확해지고 서로의 의존성이 줄어들게 된다.

### 2. 무상태성 (Stateless)
REST는 Http의 특성을 이용하기 때문에 **무상태성**을 가진다. 즉 작업을 위한 상태정보(세션 정보나 쿠키 정보 등)를 따로 저장하고 관리하지 않는다. 이로 인해 [[Server]]에서는 상태정보를 기억할 필요가 없고 들어온 요청에 대한 처리만 한다. 이는 **구현이 단순**해진다는 장점이 있다.

### 3. 캐시 처리 기능 (Cacheable)
HTTP라는 기존 웹표준을 그대로 사용하기 때문에, 웹에서 사용하는 기존 인프라를 그대로 활용이 가능하다. 따라서 HTTP가 가진 캐싱 기능이 적용 가능하다. HTTP 프로토콜 표준에서 사용하는 Last-Modified태그나 E-Tag를 이용하면 캐싱 구현이 가능하다. 캐시 사용을 통해 응답 시간이 빨라지고 REST Server transaction이 발생하지 않으며 전체 **응답시간, 성능, 서버 자원 이용률이 향상**된다. 보통 [[HTTP Headers]]에 `cache-control` 헤더를 이용한다.

### 4. 자체 표현 구조 (Self - Descriptiveness)
- REST-API의 message만으로 그 요청이 어떤 행위를 하는지 손쉽게 이해할 수 있다.

### 5. 계층화 (Layered System)
REST 서버는 다중 계층으로 구성될 수 있으며 보안, 로드 밸런싱, 암호화 계층을 추가해 구조상의 유연성을 둘 수 있고 PROXY, 게이트웨이 같은 네트워크 기반의 중간매체를 사용할 수 있게 한다. 이는 Client와 Server가 분리되어 있기 때문에 가능하며, 높은 자유도를 가질 수 있다는 장점이 있다.

### 6. 유니폼 인터페이스 (Uniform Interface)
 URI로 지정한 리소스에 대한 조작을 통일되고 한정적인 인터페이스(**일관된 인터페이스**)로 수행하는 아키텍처 스타일을 말한다. Http 표준만 따르면 모든 플랫폼에서 사용 가능하며, 특정 언어나 기술에 종속되지 않는다. Uniform Interface가 [[REST API]]를 구분짓는 핵심 중 하나인데, 조금 더 자세히 알아보자.

## 유니폼 인터페이스 (Uniform Interface)
### 유니폼 인터페이스의 4가지 제약조건
#### 1. Resource-Based
+ URI로 리소스 식별
#### 2. Manipluation Of Resources Through Representations
+ 클라이언트의 요청 해당 시점의 리소스를 클라이언트와 호환가능한 표준화된 representation으로 변환하여 전송
#### 3. Self-Descriptive Message
- 메세지는 스스로를 설명해야한다. 즉, API 문서가 REST API 응답 본문에 존재해야 한다는 것이다.
물론 API 문서 전체를 응답에 넣는 것은 불가능하지만, 적어도 API 문서가 어디 있는지는 알려줘야 한다.
#### 4. [[HATEOAS]] (**H**ypermedia **A**s **T**he **E**ngine **o**f **A**pplication **S**tate)
+ - 애플리케이션의 상태는 Hyperlink를 이용해 전이되어야 한다.