
## 🌈 에러 발생 상황
스프링 프로젝트에서 build하기 위해 Dockerfile을 만든 후 다음과 같은 내용을 넣어주었다.

```shell
FROM amazoncorretto:17.0.9  

ARG JAR_FILE=target/*.jar  
COPY ${JAR_FILE} app.jar  

ENTRYPOINT ["java", "-jar", "/app.jar"]
```

이후 build를 하려 했는데, 다음과 같은 오류가 발생했다.
![[Error response from daemon When using COPY with more than one source file.png]]
