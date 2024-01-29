---
title: DSL
date: 2023-12-27 11:54
categories:
  - Docker
tags:
  - Docker
  - DSL
image: 
path:
---
#Docker #DSL 

## DSL(domain specific lanuage)
도커는 [[이미지]]를 만들기 위해 DSL 파일을 사용한다. 이는 **서버 운용 기록**을 코드화한 파일로, **실행 명령어들의 집합**이라고 할 수 있다.

###  FROM
+ FROM은 어떤 이미지로부터 이미지를 생성할지 지정한다. 즉 **베이스 이미지를 지정**하는 것인데, 이미지는 항상 다른 이미지로부터 시작되고, 공식 이미지들은 [[도커 허브]]에 다 저장되어 있다.
+ Dockerfile에서는 필수로 지정해야 한다.
```shell
FROM amazoncorretto:17.0.9
```

### MAINTAINER
+ 관리하는 사람의 이름 또는 이메일 정보를 적는다.
+ 생략이 가능하다.
```shell
MAINTAINER sonjh
```

### WORKDIR
+ 명령어들이 실행될 기본 디렉터리를 설정한다.
+ 각 명령어의 현재 디렉터리는 **한줄마다 초기화**되기 때문에 RUN cd /path를 해도 다음 명령어에서 다시 WORKDIR로 돌아오게 된다.
```shell
WORKDIR /app
```

> [!info]+ 
> **Working Directory** : 이미지 안에서 어플리케이션 소스 코드를 가지고 있을 디렉토리를 의미한다.

### RUN
+ 명령어를 실행하라는 의미이다.
+ 이미지 빌드 과정에서 필요한 커멘드를 실행하기 위해 사용된다.
+ 보통 이미지 안에 특정 소프트웨어를 설치하기 위해 많이 사용한다.
```shell
RUN ls
```

### COPY
+ 파일이나 디렉터리를 이미지로 복사한다. 일반적으로 소스 복사에 사용된다.
+ Working Directory를 설정했다면 Working Directory로 copy된다.
```shell
COPY <src> <dst>
COPY . .
```

### EXPOSE
+ 도커 [[컨테이너]]가 실행되었을 때 요청을 기다리고 있는 포트를 지정한다.
```shell
EXPOSE 3000
```

### ENV
+ **도커 컨테이너 또는 Dockerfile**에서 사용할 환경변수를 정의한다.
```shell
ENV KEY=VALUE
```

### ARG
+ **Dockerfile**에서 사용할 환경변수를 정의한다.
```Shell
ARG KEY=VALUE
```

### ENTRYPOINT
+ [[컨테이너]]가 시작될 때 실행되는 기본 명령어나 스크립트를 지정한다.
+ 이 명령어는 컨테이너가 실행될 때마다 **항상 실행**되는 명령어로 설정된다.
```shell
ENTRYPOINT [<커맨드>, <파라미터1>, <파라미터2>]

# java -jar /app.jar 실행
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

### CMD
+ 해당 이미지를 컨테이너로 띄울 때 디폴트로 실행할 커맨드나, ENTRYPOINT 명령문으로 지정된 커맨드에 디폴트로 넘길 파라미터를 지정할 때 사용한다.
+ CMD는 ENTRYPOINT와 달리 **사용자 파라미터 입력에 따라 변동**된다.
```shell
ENTRYPOINT ["python"]
CMD ["helloworld.py"]
```