---
title: RestTemplate
date: 2024-01-25 10:55
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## RestTemplate
### Server To Server
지금까지는 Client 즉, 브라우저로부터 요청을 받는 서버의 입장에서 개발을 진행해왔다. 서비스 개발을 진행하다보면 라이브러리 사용만으로는 구현이 힘든 기능들이 무수히 많이 존재한다. 예를 들어 우리의 서비스에서 회원가입을 진행할 때 사용자의 주소를 받아야 한다면? 주소를 검색할 수 있는 기능을 구현해야하는데 직접 구현을 하게되면 많은 시간과 비용이 들어간다. 이 때, 카카오에서 만든 [주소 검색 API](https://postcode.map.daum.net/guide)를 사용한다면 해당 기능을 간편하게 구현할 수 있다. 이럴 때 **우리의 서버는 Client의 입장이 되어 Kakao 서버에 요청을 진행**해야합니다. Spring에서는 **서버에서 다른 서버로 간편하게 요청할 수 있도록 RestTemplate 기능을 제공**하고 있다.

