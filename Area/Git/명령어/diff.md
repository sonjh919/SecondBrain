---
title: diff
date: 2023-12-21 12:57
categories:
  - Git
tags:
  - Git
  - Git명령어
image: 
path:
---

## 🌈 diff
+ [[Git의 3가지 영역|Working Directory]]와 [[Git의 3가지 영역|Staging Area]] 사이의 차이를 확인하기 위한 명령어이다.
+ 변경 사항이 git add를 통해 Staging Area로 넘어갔으면 git diff에는 **아무것도 나타나지 않는다**

```cs
git diff
```

## 🌈 옵션
### 📌 HEAD
+ HEAD는 **가장 최근 commit**을 이야기하는 것으로, 현재 작업 중인 내용이 HEAD commit과 다른 점을 총체적으로 보여주기 위한 명령어이다.
```
git diff HEAD
```
