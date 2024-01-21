---
title: HAL JSON
date: 2024-01-21 18:32
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---

## HAL
Hypertext Application Language 으로 [[JSON]], XMl 코드 내의 외부 리소스에 대한 링크를 추가하기 위한 특별한 데이터 타입이다. HAL은 `application/hal+json`와 `application/hal+xml` 2가지 타입을 가지는데, 이를 이용해 쉽게 [[HATEOAS]]를 달성할 수 있다.

## 리소스와 링크
- 리소스 : 일반적인 data 필드에 해당한다.
- 링크 : 하이퍼미디어로 보통 `_self` 필드가 링크 필드가 된다.

## 예시
```
{
  "data": { // HAL JSON의 리소스 필드
    "id": 1000,
    "name": "게시글 1",
    "content": "HAL JSON을 이용한 예시 JSON"
  },
  "_links": { // HAL JSON의 링크 필드
    "self": {
      "href": "http://localhost:8080/api/article/1000" // 현재 api 주소
    },
    "profile": {
      "href": "http://localhost:8080/docs#query-article" // 해당 api의 문서
    },
    "next": {
      "href": "http://localhost:8080/api/article/1001" // article 의 다음 api 주소
    },
    "prev": {
      "href": "http://localhost:8080/api/article/999" // article의 이전 api 주소
    }
  }
}
```