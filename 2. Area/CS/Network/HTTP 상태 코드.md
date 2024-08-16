#CS #Network 

## HTTP 상태 코드
+ HTTP 상태 코드(Status Code)를 통해 브라우저와 서버간의 요청, 응답 과정에서 발생할 수 있는 상황들을 표현할 수 있다.
+ HTTP 상태 코드는 3자리 숫자로 이루어져 있다.
+ 첫 번째 자리 숫자는 상태 코드의 분류를 나타내는 용도로 사용되며, 나머지 두 자리는 세부적인 정보를 나타낸다.

# [[REST API]] 관점에서의 상태 코드
## 1xx (Informational)
1xx 상태 코드는 요청이 수신 되었으며 처리가 계속되고 있음을 나타낸다. 주로 웹 브라우저와 같은 클라이언트가 서버와의 연결 상태를 확인하기 위해 사용된다.

## 2xx (Successful)
2xx 상태 코드는 클라이언트의 요청이 성공적으로 처리 되었음을 나타낸다.

### 200 : OK
**클라이언트의 요청을 서버가 정상적으로 처리했다는 뜻**이다. 성공에 대한 모든 상태 코드를 `200`으로 응답해도 크게 상관없다. 하지만, 클라이언트에게 더 정확하고 세부적인 정보를 제공하기 위해서는 알맞는 상태 코드를 보내는 것이 좋다고 생각한다.

### 201 : Created
**클라이언트의 요청을 서버가 정상적으로 처리했고 새로운 리소스가 생겼다**는 뜻이다. `201` 상태 코드는 `POST`, `PUT` 요청에 대한 응답에 주로 사용된다. 클라이언트의 요청이 성공적으로 이뤄졌다는 의미까지는 `200`과 동일하지만, 성공과 동시에 새로운 리소스가 생성되었다는 의미를 포함한다.

> HTTP 헤더의 [Content-Location](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Location)를 이용하여 만들어진 리소스 생성된 위치를 알려주면 더욱 좋다.

```http
POST /users HTTP/1.1
Content-Type: application/json
{
    "name": "sjh"
}

HTTP/1.1 201 Created
Content-Location: /users/1
{
    "id" : 1,
    "name" : "sjh"
}

```

### 202 : Accepted
**클라이언트의 요청은 정상적이나, 서버가 아직 요청을 완료하지 못했다**는 뜻이다. **비동기**와 관련된 개념이다. 클라이언트의 요청이 정상적이면 서버에선 작업의 성공 또는 실패로 응답하는 게 일반적이나, 작업 완료를 위한 일련의 작업들이 오래 걸리기 때문에 나중에 알려주겠다는 의미다.

### 204 : No Content
**클라이언트의 요청은 정상적이다. 하지만 컨텐츠를 제공하지 않는다.** 이는 `204` 상태 코드가 자원의 `DELETE` 요청에 응답한다는 것으로 생각할 수 있다. `200`에서 body에 `null`, `{}`, `[]`, `false` 등으로 응답하는 것과 다르게 `204`의 경우 [HTTP Response body](https://en.wikipedia.org/wiki/HTTP_message_body)가 아예 존재하지 않는 경우다.


## 3xx (Redirection)
+ 3xx 상태 코드는 클라이언트가 추가적인 조치를 취해야 함을 나타낸다.
+ 이 상태 코드는 주로 페이지 이동, redirection 등에 사용된다.

참조 : [[Forward와 Redirect]]

## 4xx (Client Error)
+ 4xx 상태 코드는 클라이언트에 오류가 있음을 나타낸다.
- 이 상태 코드는 주로 클라이언트의 잘못된 요청, 인증 오류 등에 사용된다.

### 400 : Bad Request
**클라이언트의 요청이 유효하지 않아 더 이상 작업을 진행하지 않는 경우**이다. API 서버는 클라이언트 요청이 들어오면 바로 작업을 진행하지 않고 요청이 서버가 정의한 유효성에 맞는지 검증 후 진행한다. 이 검증은 데이터의 범위나 패턴, 존재 여부 등 여러 가지가 있다. 유효성 검증 없이 진행하면 `5xx` 서버 오류가 발생할 수 있기 때문에 대부분 사전에 막는 로직을 추가한다.

그러나, `400` 상태 코드로 응답하는 것만으로는 부족하다.    
오류 발생 시 **파라미터의 위치(`path`, `query`, `body`), 사용자 입력 값, 에러 이유를 꼭 명시하는 것이 좋다.**

```http
HTTP/1.1 400 Bad Request
{
    "errors": {
        "message": "'name'(body) must be String, input 'name': 123",
        "detail": [
            {
            "location": "body",
            "param": "name",
            "value": 123,
            "error": "TypeError",
            "msg": "must be String"
            }
        ]
    }   
}

```


### 401 : Unauthorized
클라이언트가 **인증**이 되지 않았기 때문에 작업을 진행할 수 없는 경우이다. **인증이 안돼 자원을 이용할 수 없는 상태**를 말한다.

### 403 : Forbidden
`401` 의 상태 코드명이 `Unauthorized`라 혼동의 여지가 있으나, **권한**에 대한 내용이다. **인증된 클라이언트가 권한이 없는 자원에 접근할 때 응답하는 상태 코드**다.

### 404 : Not Found
**클라이언트가 요청한 페이지나 리소스를 서버에서 찾을 수 없음**을 의미한다. 크게 2가지 경우에 `404` 코드를 응답하는데, **경로가 존재하지 않거나 자원이 존재하지 않음**을 뜻한다. 경로 자체가 존재하지 않는 것은 쉽게 `404` 코드로 응답할 수 있지만, 자원의 경우는 존재 유무에 대해 개발자가 처리해 주어야 한다. 만약 오류가 발생한다면 `5xx` 오류로 이어질 수 있다.

### 405 : Method Not Allowed
**클라이언트의 요청이 허용되지 않는 메소드인 경우**를 의미한다. 메소드란 `POST, GET, PUT, DELTE` 등 [HTTP Method](https://developer.mozilla.org/ko/docs/Web/HTTP/Methods)를 말한다. 즉, **자원**(`URI`)은 존재하지만 해당 자원이 지원하지 않는 메소드일 때 응답하는 상태 코드다.

**`405` 상태 코드는 [OPTIONS](https://developer.mozilla.org/ko/docs/Web/HTTP/Methods/OPTIONS) 메소드와 HTTP header의 [Allow](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Allow)와 연관되어있다.** `OPTIONS`는 API가 허용하는 메소드가 어떤 것들이 있는지 확인하는 메소드다. `405`오류를 사전에 방지하기 위한 용도에 주로 쓰인다.   
이 때 응답 HTTP header의 `Allow`에  지원하는 메소드를 나열하여 응답한다.

```http
OPTIONS /users/1 HTTP/1.1

HTTP/1.1 200 OK

Allow: POST, GET,PUT,DELETE,OPTIONS,HEAD
```

### 409 : Conflict
**클라이언트의 요청이 서버의 상태와 충돌이 발생한 경우**를 뜻하는데, 충돌이라는 것은 매우 추상적이다. 따라서 나름의 정의를 가지고 응답해야 한다. 예를 들면 해당 요청의 처리 중 비지니스 로직상 불가능하거나 모순이 생긴 경우가 있다.

### 429 : Too Many Requests
**클라이언트가 일정 시간 동안 너무 많은 요청을 보낸 경우**를 의미한다. 비정상적인 방법(DoS attack, Brute-force attack)방법으로 자원을 요청하는 경우 응답한다. 서버가 감당하기 힘든 요청이 지속적으로 들어오면 서버는 해당 요청을 처리하기 위해 다른 작업을 처리하지 못할 수 있다.

`429` 상태 코드는 이러한 경우 일정 시간 뒤 요청할 것을 나타내는 것이다. 따라서 다음과 같이 HTTP hearder [Retry-After](https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Retry-After)을 이용한다.


### 5xx (Server Error)
+ 5xx 상태 코드는 서버에 오류가 발생했음을 나타낸다.
+ 주로 서버의 오류, 서버 과부하 등에 사용된다.
+ 대부분 **개발자의 실수**이다. 완벽한 예외처리를 통해 `5xx`를 보지 말도록 하자.








참고 : [https://sanghaklee.tistory.com/61](https://sanghaklee.tistory.com/61) [이상학의 개발블로그:티스토리]