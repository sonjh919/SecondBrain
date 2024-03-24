---
title: HATEOAS
date: 2024-01-21 16:32
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

## HATEOAS (Hypermedia As The Engine Of Application State)
+ Hateoas는 [[REST API]]를 잘 설계하기 위해 나온 개념이다.
+ 잘 설계된 REST API를 구현하기 위한 단계가 존재하는데 , 그 마지막 단계가 Hypermedia Controls (하이퍼미디어 컨트롤) - HATEOAS라는 개념을 통해, 자원에 호출 가능한 API 정보를 자원의 상태를 반영하여 표현하는것이다.

기본적인 아이디어는 **하이퍼미디어를 애플리케이션의 상태를 관리하기 위한 메커니즘**으로 사용한다는 것이다. Hateoas란 REST API를 사용하는 **클라이언트가 전적으로 서버와 동적인 상호작용이 가능하도록 하는 것**을 의미한다. 이러한 방법은 클라이언트가 서버로부터 어떠한 요청을 할 때, **요청에 필요한 URI를 응답에 포함시켜 반환**하는 것으로 가능하게 할 수 있다.

> 정리하자면, Hypermedia (링크)를 통해서 애플리케이션의 상태 전이가 가능해야 한다. 또한 Hypermedia (링크)에 자기 자신에 대한 정보가 담겨야 한다.
{: .prompt-info }

>하이퍼미디어
**문자와 숫자로 이루어진 텍스트 외에도 소리와 그림, 애니메이션 등 다양한 정보매체를 곧바로 접근할 수 있도록 표현하는 기능**을 말한다.
{: .prompt-info }

## HATEOAS의 4 Level
### Level 0
API 구현은 HTTP 프로토콜을 사용하지만 전체 기능을 활용하지는 않는다. 또한 리소스에 대한 고유 주소가 제공되지 않는다.
ex) POST URI: /student
### Level 1
리소스에 대한 고유 식별자가 있지만 리소스에 대한 각 작업에는 고유한 URL이 있다.
ex) POST URI: /student/1/delete
### Level 2
동작을 설명하는 동사 대신 HTTP 메서드를 사용한다. 예를 들어 URL(/delete) 대신 DELETE 메소드를 사용한다.
ex) DELETE URI: /student/1
### Level 3
HATEOAS가 도입된다. 이를 통해 가능한 작업에 대해 알려주는 응답에 링크를 배치할 수 있으므로 API를 통해 탐색할 수 있는 가능성이 추가된다.
ex) link 필드 추가


![[hateoas.png]]


## 상태 전이
여기 게시 글을 조회하는 URI가 있다.

```
GET https://sjhblog.com/article
```

그럼 여기서 해당 글을 조회한 사용자는 다음 행동으로 어떤 행동을 할까? 다음 게시물을 조회하거나, 게시물을 내 피드에 저장하고, 댓글을 다는 것 등의 행동이 있다. 이런 행동들이 바로 상태 전이가 가능한 것들인데, 이 것들을 응답 본문에 Hypermedia (링크)를 통해서 넣는다.

```json
{
  "data": {
    "id": 1,
    "name": "게시글 1",
    "content": "HAL JSON을 이용한 예시 JSON",
    "self": "http://localhost:8080/api/article/1", // 현재 api 주소
    "profile": "http://localhost:8080/docs#query-article", // 해당 api의 문서
    "next": "http://localhost:8080/api/article/2", // 다음 article을 조회하는 URI
    "comment": "http://localhost:8080/api/article/comment", // article의 댓글 달기
    "save": "http://localhost:8080/api/feed/article/1", // article을 내 피드로 저장
  },
}
```

### 상태 전이의 장점
1. API 버전을 명세하지 않아도 된다.
2. 링크 정보를 동적으로 바꿀 수 있다.
3. 링크를 통해서 상태 전이가 쉽게 가능하다.

위와 같은 방식으로 데이터를 담아 클라이언트에게 보낸다면 클라이언트는 해당 링크를 **참조**하는 방식으로, JPA에서 객체 그래프 탐색을 하는 것 처럼 API 그래프 탐색이 가능해진다. 이를 완벽하게 하기 위해서는 [[HAL JSON]]을 이용할 수 있다.

### HAL JSON을 이용한 예시
```
{
  "data": { // HAL JSON의 리소스 필드
    "id": 1,
    "name": "게시글 1",
    "content": "HAL JSON을 이용한 예시 JSON"
  },
  "_links": { // HAL JSON의 링크 필드
    "self": {
      "href": "http://localhost:8080/api/article/1" // 현재 api 주소
    },
    "profile": {
      "href": "http://localhost:8080/docs#query-article" // 해당 api의 문서
    },
    "next": {
      "href": "http://localhost:8080/api/article/2" // article 의 다음 api 주소
    },
    "prev": {
      "href": "http://localhost:8080/api/article/99" // article의 이전 api 주소
    }
  }
}
```

## HATEOAS의 장단점
서버와 클라이언트 간의 느슨한 결합?

일단 다중 도메인에 관한 API는 Swagger 문서를 보고 개발을 하는 것이 더 효과적이라고 판단된다.