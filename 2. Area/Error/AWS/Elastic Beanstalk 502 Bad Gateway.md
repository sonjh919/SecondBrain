#Error #AWS #ElasticBeanstalk 

## 문제 상황
AWS에서 [[Elastic Beanstalk]] 환경을 구성하여 Spring Boot 프로젝트를 배포했는데, API call을 해보니 502 Bad Gateway 오류가 나타나는 문제가 발생했다. 무슨 오류인가 싶어 로그를 확인해보았더니, 다음과 같은 에러가 있었다.

```
*3 connect() failed (111: Connection refused) while connecting to upstream, client: 211.201.107.87, server: , request: "GET / HTTP/1.1", upstream: "http://127.0.0.1:5000/", host: "..."
```

### connect() failed (111 Connection refused)
해당 오류는 Nginx가 업스트림 서버(backend 서버)에 연결을 시도했을 때 연결이 거부되었음을 나타낸다. 연결이 제대로 되기 위해서는 port 번호를 맞추어 설정해 주어야 한다.

### 해결 방법
다음은 Elastic Beanstalk의 구성이다. 보면 처음에 80 port로 연결하고, Nginx라는 프록시 서버를 두어 Spring Boot에 접근한다는 것을 알 수 있다. 따라서 Spring Boot에 접근하기 위해서는 port를 5000으로 변경해 주어야 한다.
![[Pasted image 20240131111925.png]]

이는 공식문서에도 나와 있다.
https://docs.spring.io/spring-boot/docs/current/reference/html/deployment.html
해당 공식문서를 보면, Java SE Platform 사용 시 서버 포트를 5000으로 설정해야 한다고 나와 있다.

![[502_1.png]]

### 바꿔보자!
1. application.yml(또는 [[application.properties]])에서 다음과 같이 세팅해준다.
```yml
server:  
  port: 5000
```

2. 그리고, Elastic Beanstalk의 환경 변수에 다음과 같은 값을 추가한다.

![[502_2.png]]

## 완료!
설정을 해 주고 나니, 정상적으로 api call이 이루어지는 것을 볼 수 있었다.
