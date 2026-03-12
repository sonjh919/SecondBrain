---
title: 스프링 프로젝트 Docker Build 하기
date: 2023-12-27 14:27
categories:
  - Openur
tags:
  - Spring
  - Docker
  - setting
  - Gradle
  - Project
image: 
path:
---
스프링 프로젝트를 만들고 그 다음 단계는 Ec2 설정을 할 수 있게 Docker로 Build하여 올리는 것이다.

## Docker Build 과정
### 1. Branch 생성
Docker 설정을 하기 전에, 회의로 정했던 Branch 규칙에 따라 Jira에서 해당 이슈에 대한 카드를 만들고, 그 카드 이름으로 Branch를 생성하였다.

### 2. Dockerfile 생성
그동안 항상 Maven으로 해서 그런지 Gradle로 하는 것은 너무 힘들었다.. 어떤 오류인지, 어떻게 해결해야 할지 막막했어가지고 이참에 Docker 공부를 좀 해보기로 했다. 그동안 프로젝트하면서 그때그때 필요한 개념만 찾아 해결했었는데, 오전에 Docker에 대한 정리를 했다. 기본 개념은 얼추 정리가 끝난 것 같아 이를 기반으로 Docker에 대한 지식도 늘려가기로 했다. 해서 Dockerfile 생성을 마치고 성공적으로 Build를 완료했다. 

Build 중 생긴 오류는 다음과 같다.
+ [[Error response from daemon COPY failed no source files were specified]]
+ [[Error response from daemon When using COPY with more than one source file]]

### 3. commit & push & pr
commit과 pr 메세지에 대한 전략도 다 세워놓아서 그걸 적용해보면서 github에 올렸는데, 확실히 처음엔 오래 걸렸지만 체계적으로 한다는 사실이 너무 깔끔하고 좋게 느껴졌다. 그렇게 첫 PR을 완료했다.
