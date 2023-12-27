스프링 프로젝트에서 쓰일 Dockerfile을 만든 후 다음과 같은 내용을 넣어준다.

```shell
FROM amazoncorretto:17.0.9  
ARG JAR_FILE=target/*.jar  
COPY ${JAR_FILE} app.jar  
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

이후 build를 하려 했는데, 다음과 같은 오류가 발생했다.
![[dockerbuilderror.png]]

3번째 줄 COPY에서 막혔다고 나왔다.

## 🌈 원인
Maven build할 때에는 target 폴더에, Gradle build할 때에는 build 폴더에, Intellij에서 빌드할 때에는 out 폴더에 빌드 파일이 생성되게 된다. 나는 지금 Gradle로 build했는데, Maven에서 쓰던 방식을 그대로 가져와서 target 폴더를 못찾아 생긴 오류이다.

## 🌈 해결