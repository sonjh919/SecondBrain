#CS #Network 

## HTTP Method
+ POST : 해당 URL을 요청하면 자원을 생성한다.
+ GET : 해당 자원을 조회한다.
+ PUT : 해당 자원을 수정한다. PUT 사용시에는 바뀌지 않는 속성도 같이 보내야 한다.
+ DELETE : 해당 자원을 삭제한다.
+ OPTIONS : 현재 End-point가 제공 가능한 API method를 응답한다.
+ HEAD : 요청에 대한 Header 정보만 응답한다. body가 없다.
+ PATCH : PUT 대신 PATCH method를 사용한다. 자원의 일부를 수정할 때는 PATCH가 목적에 맞는 method다.


**HEAD**, **OPTIONS**, **TRACE**, **CONNECT**

### HEAD
- **용도**: GET과 동일하게 동작하지만, _본문(body) 없이 헤더(header)만_ 반환한다. 리소스의 상태(예: Content-Length, Last-Modified 등)만 확인하고, 실제 데이터를 불러올 필요 없을 때 사용한다.
- **예시**: 파일 다운로드 전에 존재 여부와 용량만 확인할 때.
```
HEAD /image.png HTTP/1.1
Host: example.com
```
    ⇒ 서버의 응답 본문 없이 헤더만 반환.
### OPTIONS

- **용도**: 서버가 지원하는 HTTP 메소드 목록을 확인하거나, 서버와의 통신 옵션(예: CORS 정책)을 확인할 때 사용한다.
- **예시**: 프론트엔드가 백엔드에 실제 요청 전에 CORS 허용 여부를 알아볼 때(프리플라이트 요청).

```
OPTIONS /api/users HTTP/1.1
Host: example.com
```
    ⇒ 응답 헤더에 `Allow: GET, HEAD, POST, OPTIONS` 등으로 지원 메소드 표기.
```
HTTP/1.1 204 No Content
Allow: GET, HEAD, POST, OPTIONS
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization
```    

### TRACE
- **용도**: 진단 및 디버깅을 위해 요청이 서버에 어떻게 도달하는지 “루프백(loop-back)” 테스트를 수행한다. 서버는 받은 요청 메시지를 그대로 본문에 담아 응답한다. 패킷 변조나 프록시, 방화벽 진단에 사용한다.
- **예시**:    
```
TRACE /test HTTP/1.1
Host: example.com
```
    ⇒ 서버가 받은 HTTP 요청 전체를 응답 본문으로 돌려줌(요청이 서버에 어떻게 보이는지 검사).  

```
HTTP/1.1 200 OK
Content-Type: message/http
Content-Length: 154

TRACE /example HTTP/1.1
Host: www.example.com
User-Agent: curl/7.64.1
Accept: */*

```

### CONNECT

- **용도**: 프록시 서버를 통한 터널링에 이용된다. 특히 HTTPS 접속 시, 중계 프록시 서버와 암호화 터널(TCP 스트림)을 설정하는 데 사용한다.
- **예시**:
```
CONNECT www.google.com:443 HTTP/1.1
Host: www.google.com:443
```
    ⇒ 클라이언트와 원격 서버(예: HTTPS 사이트) 사이에 SSL/TLS 터널 생성.
    

> [!question]+ 터널링?
> 클라이언트와 목적지 서버 사이에 프록시 서버를 통해 직접적인 네트워크 연결(터널)을 설정하는 것을 의미

### 정리
- **HEAD**: 리소스 상태/메타데이터 확인, 본문 없이 헤더만 반환
- **OPTIONS**: 서버가 지원하는 메소드·옵션 확인, CORS 등 사전 검사
- **TRACE**: 서버에 도달한 요청 그대로 응답, 네트워크/프록시 진단용
- **CONNECT**: 프록시 서버와 암호화된 터널 생성(주로 HTTPS 프록시)

**참고**: TRACE와 CONNECT는 보안상 위험이 있어 실제 운영 환경에서는 거의 비활성화한다. OPTIONS와 HEAD는 실무에서도 종종 활용한다.