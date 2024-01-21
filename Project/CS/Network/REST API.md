---
title: REST API
date: 2024-01-21 14:56
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---
## REST-API (Representational State Transfer API)
+ [[REST]] 아키텍쳐 스타일을 따르는 [[API]]를 REST-API라고 한다.
+ **해당 자원의 상태를 주고 받는 모든 것**
+ 웹의 모든 자원에 고유한 id인 **http url**을 부여하고 **HTTP Method(Get, Post, Put, Delete)** 를 통해 해당 자원에 대한 **CRUD 연산**을 적용한다.
- **자원 기반 구조** (ROA : Resource Oriented Architecture)로 설계된 아키텍처를 의미한다.

> 즉, 서버의 api가 적절하게 [[http]]를 준수하며 잘 설계되어있으면 RESTful 하게 설계되어 있다!
{: .prompt-info }

---
# REST API 설계
REST API 설계 시 가장 중요한 항목은 2가지이다.

1. **URI는 정보의 자원을 표현해야 한다.**
2. **자원에 대한 행위는 HTTP Method(GET, POST, PUT, DELETE)로 표현한다.**

## 1. REST API 중심 규칙
### 1-1. 자원 (Resource) : URL
+ URL는 정보의 자원을 표현해야 한다. 
+ 리소스명은 동사보다는 **명사를 사용**한다.
- 모든 자원에는 고유한 **ID**가 존재하고, 이 자원은 Server에 존재한다.
- 자원을 구분하는 ID는 URL이다. ex) /orders/order-id/1

### 1-2. 행위(Verv) : HTTP Method
+ POST : 해당 URL을 요청하면 자원을 생성한다.
+ GET : 해당 자원을 조회한다.
+ PUT : 해당 자원을 수정한다.
+ DELETE: 해당 자원을 삭제한다.

### 1-3. 표현 (Representations)
- 하나의 자원은 JSON, XML, TEXT, RSS등 여러 형태로 나타낼 수 있다.
- 최근에는 **JSON**으로 주고받는 것이 대부분이다.

## 2. REST API 설계 시 주의점
### 2-1. 슬래시 구분자(/)는 계층 관계를 나타내는 데 사용한다.
### 2-2. URI 마지막 문자로 슬래시(/)를 포함하지 않는다.
REST API는 분명한 URI를 만들어 통신을 해야 하기 때문에 **혼동을 주지 않도록** URI 경로의 마지막에는 슬래시(/)를 사용하지 않는다.

### 2-3. 하이픈(-)을 사용하고, 밑줄(`_`)은 사용하지 않는다.
긴 URI 경로를 사용하게 된다면, 가독성을 위해 하이픈을 사용하자. 밑줄은 보기 어렵거나 문자가 가려지기도 하여 사용하지 않는 것이 좋다.

### 2-4. URI 경로는 소문자가 적합하다.
URI 경로에 대문자 사용은 피하자. 대소문자에 따라 다른 리소스로 인식하게 되기 때문이다. RFC 3986(URI 문법 형식)은 URI 스키마와 호스트를 제외하고는 대소문자를 구별하도록 규정한다.

### 2-5. 파일 확장자는 URI에 포함시키지 않는다.
REST API에서는 메시지 바디 내용의 포맷을 나타내기 위한 파일 확장자를 URI 안에 포함시키지 않는다. Accept header를 사용하도록 하자.

### 2-6. 행위(method)는 URL에 포함하지 않는다. 단, 컨트롤 자원을 의미하는 URL 예외적으로 동사를 허용한다.


## 3. 리소스 간의 관계 표현
+ REST 리소스 간에는 연관 관계가 있을 수 있고, 이런 경우 다음과 같은 표현방법으로 사용한다.

```
 /리소스명/리소스 ID/관계가 있는 다른 리소스명
 ex) GET : /users/{userid}/devices (일반적으로 소유 ‘has’의 관계를 표현할 때)
```

+ 만약에 관계명이 복잡하다면 이를 서브 리소스에 명시적으로 표현하는 방법이 있다. 예를 들어 사용자가 ‘좋아하는’ 디바이스 목록을 표현해야 할 경우 다음과 같은 형태로 사용될 수 있다.

```
 ex) GET : /users/{userid}/likes/devices (관계명이 애매하거나 구체적 표현이 필요할 때)
```

## 4. Colllection/Document/Store/Controller
### 4-1. Document
Document는 컬랙션 내의 단일 리소스를 말한다. DB에 비유하면 한 **테이블의 레코드**라고 할 수 있다. 일반적으로 **단수**로 이름을 짓는다.

```
/students/3 #파티의 아이디가 3인 경우
/students/sjh #파티의 아이디가 sjh인 경우
```

### 4-2 Collection
Collection은 단일 리소스(Document)들의 묶음이다. DB에 비유하면 테이블이라고 할 수 있다.. 일반적으로 Collection은 **복수**로 이름을 짓는다.

```
/students 복수로 작성한다.
```

### 4-3 Store
클라이언트 입장에서 저장하는 리소스 저장소를 이야기한다. 굳이 예시를 따져 보면 DDD 설계에서의 ReadModel정도가 맞는 것 같다. 클라이언트에서 좀더 자유롭게 다루는 리소스이다. 일반적으로 복수로 이름을 짓는다.

```
/users/3/carts #3번 유저의 장바구니
```

### 4-4 Controller
Controller 리소스 절차, 프로세스의 개념을 규격화한다. 일반적으로 **`Collection/Document/Store`** 의 순서로 설계하는 것을 뜻한다.