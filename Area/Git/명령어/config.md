---
title: config
date: 2023-12-21 11:57
categories:
  - Git
tags:
  - Git
  - Git명령어
image: 
path:
---

## 🌈 config
+ git은 저장소에 대한 설정값을 저장해놓는 config 파일을 읽어 설정값들을 사용한다.
+ 이 설정파일에 대한 정보를 확인할 경우에 사용한다.
+ git.config 파일에서 직접 설정할 수도 있으나, 추천하지 않는다.

```cs
git config
```

## 🌈 옵션
### 📌 --global
+ 전역으로 git 설정을 변경할 시 사용한다.
```cs
git config --global user.name "Your Name"
```
