## Inbox

+ 리뷰어의 주관이 궁금한 이유 생각하기?


```cardlink
url: https://mvnrepository.com/artifact/io.spring.dependency-management/io.spring.dependency-management.gradle.plugin
title: "Maven Repository: io.spring.dependency-management » io.spring.dependency-management.gradle.plugin"
host: mvnrepository.com
```

스프링이 뭔지부터 알아보자.

---

웹 클라이언트 : 사용자가 웹을 이용할 수 있도록 해주는 프로그램이다. 웹 브라우저가 해당된다. 사용자가 웹 페이지를 요청하고 결과를 확인하는 역할을 한다. 웹 클라이언트가 웹 서버에 요청(Request)을 보낸다.
웹 서버 :  클라이언트로부터 온 요청을 받아, 결과를 응답(Response)하는 시스템이다. 요청에 따라 정적 파일을 직접 제공하거나, 동적 처리가 필요한 경우 웹 애플리케이션 서버(WAS)와 연동해 동적으로 결과를 생성한다.

둘은 http 프로토콜을 사용해 통신한다. 
http 요청 : 요청 메서드, url, 헤더, body 등의 정보가 포함된다.
http 응답 : 상태 코드, 헤더, body 등의 정보가 포함된다.

화면 렌더링 과정
url 입력 -> dns 조회 -> tcp 연결 -> http 요청 전송 -> 서버 요청 처리 -> http 응답 전송 -> 브라우저 렌더링 -> 화면 표시

---

템플릿 엔진 : 서버에서 데이터를 주입하여 동적으로 html 생성 가능하다.
단순 html :  정적으로만 생성 가능하다.

클라이언트 사이드 렌더링 : 브라우저에서 JS 실행 후 DOM을 생성한다. 초기 로딩 속도가 느리지만 서버 부하는 낮다.
서버 사이드 렌더링 : 서버에서 html을 완성시켜 전송한다. 때문에 로딩 속도가 빠르지만 서버에 부하가 생길 가능성이 높다.

즉 실시간 업데이트나 초기 로딩에 대한 성능 개선이 필요한 경우 서버 사이드 렌더링이 좋고, 복잡한 사용자 상호작용이 필요하다면 클라이언트 사이드 렌더링이 더 적합하다.