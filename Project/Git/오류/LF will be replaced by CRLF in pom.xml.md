---
title: LF will be replaced by CRLF in pom.xml
date: 2023-12-21 14:30
categories:
  - Git
tags:
  - Git
  - Git오류
image: 
path:
---

## 🌈 오류

나에게는 상당히 자주 등장하던 오류다.
이 메세지는 다음과 같다.

```cs
warning: LF will be replaced by CRLF in pom.xml
The file will have its original line endings in your working directory
```

해석하면 LF는 CRLF로 대체된다는 뜻인데..
쉽게 말하자면 **플랫폼(OS)마다 줄바꿈을 바라보는 문자열이 다르기에 형상관리를 해주는 Git이 바라볼 땐 둘 중 어느 쪽을 선택할지 몰라 경고 메세지를 띄워준 것**이다.

## 🌈 해결방안
```cs
# Window, Dos
git config --global core.autocrlf true

# Linux, Mac
git config --global core.autocrlf input
```