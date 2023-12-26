스프링 프로젝트에서 쓰일 Dockerfile을 만든 후 다음과 같은 내용을 넣어준다.

```shell
FROM amazoncorretto:17.0.9  
ARG JAR_FILE=target/*.jar  
COPY ${JAR_FILE} app.jar  
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

이후 build를 하려 했는데, 다음과 같은 오류가 발생했다.
![[dockerbuilderror.png]]

https://velog.io/@nefertiri/%EB%8F%84%EC%BB%A4-%EC%BB%A8%ED%85%8C%EC%9D%B4%EB%84%88%EC%99%80-%EC%9D%B4%EB%AF%B8%EC%A7%80-01

