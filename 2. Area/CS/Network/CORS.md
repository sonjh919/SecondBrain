#CS #Network 


## CORS(Cross-origin resource sharing, 교차 출처 리소스 공유)
브라우저에서는 보안적인 이유로 `cross-origin` HTTP 요청들을 제한합니다. 그래서 `cross-origin` 요청을 하려면 서버의 동의가 필요합니다. 만약 서버가 동의한다면 브라우저에서는 요청을 허락하고, 동의하지 않는다면 브라우저에서 거절합니다.

이러한 허락을 구하고 거절하는 메커니즘을 HTTP-header를 이용해서 가능한데, 이를 CORS(Cross-Origin Resource Sharing)라고 부릅니다.

그래서 브라우저에서 `cross-origin` 요청을 안전하게 할 수 있도록 하는 메커니즘입니다.

> [!question]+ cross-origin
> cross-origin이란 다음 중 한 가지라도 다른 경우를 말합니다.
> 
> 1. 프로토콜 - http와 https는 프로토콜이 다르다.
> 2. 도메인 - domain.com과 other-domain.com은 다르다.
> 3. 포트 번호 - 8080포트와 3000포트는 다르다.
> ![[cors.png]]

## CORS의 필요성
CORS가 없이 모든 곳에서 데이터를 요청할 수 있게 되면, 다른 사이트에서 원래 사이트를 흉내낼 수 있게 됩니다. 예를 들어서 기존 사이트와 완전히 동일하게 동작하도록 하여 사용자가 로그인을 하도록 만들고, 로그인했던 세션을 탈취하여 악의적으로 정보를 추출하거나 다른 사람의 정보를 입력하는 등 공격을 할 수 있습니다. 이렇나 공격을 할 수 없도록 브라우저에서 보호하고, 필요한 경우에만 서버와 협의하여 요청할 수 있도록 하기 위해서 필요합니다.

## CORS의 동작 방식
1. 서버로 요청을 합니다.
2. 서버의 응답이 왔을 때 브라우저가 요청한 `Origin`과 응답한 헤더 `Access-Control-Request-Headers`의 값을 비교하여 유효한 요청이라면 리소스를 응답합니다. 만약 유효하지 않은 요청이라면 브라우저에서 이를 막고 에러가 발생합니다.

> [!question]+ Simple requests
> HTTP method가 다음 중 하나이면서
> 1. GET
> 2. HEAD
> 3. POST
> 
> 자동으로 설정되는 헤더는 제외하고, 설정할 수 있는 다음 헤더들만 변경하면서
> 1. Accept
> 2. Accept-Language
> 3. Content-Language
> 
> Content-Type이 다음과 같은 경우
> 1. application/x-www-form-urlencoded
> 2. multipart/form-data
> 3. text/plain


## CORS 에러 대응하기
1. 서버에서 `Access-Control-Allow-Origin` 응답 헤더 세팅하기
2. 프록시 서버 사용하기