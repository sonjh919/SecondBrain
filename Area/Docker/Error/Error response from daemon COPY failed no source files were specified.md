---
title: Error response from daemon COPY failed no source files were specified
date: 2023-12-26 23:19
categories:
  - Docker
  - Spring
tags:
  - Docker
  - Gradle
  - Maven
  - DockerError
image: 
path:
---

## 에러 발생 상황
스프링 프로젝트에서 build하기 위해 Dockerfile을 만든 후 다음과 같은 내용을 넣어주었다.

```shell
FROM amazoncorretto:17.0.9  

ARG JAR_FILE=target/*.jar  
COPY ${JAR_FILE} app.jar  

ENTRYPOINT ["java", "-jar", "/app.jar"]
```

이후 build를 하려 했는데, 다음과 같은 오류가 발생했다.

## 에러 로그 확인
```shell
Step 4/5 : COPY ${JAR_FILE} app.jar
Error response from daemon: COPY failed: no source files were specified
Failed to deploy '<unknown> Dockerfile: Dockerfile': Can't retrieve image ID from build stream

```
![[Error response from daemon COPY failed no source files were specified.png]]
COPY할 파일을 찾지 못했다고 나온다.

## 원인
Maven build할 때에는 target 폴더에, Gradle build할 때에는 build 폴더에, Intellij에서 빌드할 때에는 out 폴더에 빌드 파일이 생성되게 된다. 나는 지금 Gradle로 build했는데, Maven에서 쓰던 방식을 그대로 가져와서 target 폴더를 못찾아 생긴 오류이다.

## 해결
폴더의 위치를 build/lib으로 변경한다.
```shell
FROM amazoncorretto:17.0.9  

ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar  

ENTRYPOINT ["java", "-jar", "/app.jar"]
```