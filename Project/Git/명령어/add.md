---
title: add
date: 2023-12-21 11:57
categories:
  - Git
tags:
  - Git
  - Git명령어
image: 
path:
---

## 🌈 add
+ [[Git의 3가지 영역|Working Directory]]상의 변경 내용을 [[Git의 3가지 영역|Staging Area]]에 추가하기 위해서 사용한다.
+ 다음 commit을 기록할 때 까지 **변경분을 모아놓기 위해 사용**한다.

```cs
git add 파일/디렉토리경로
```

## 🌈 옵션
### 📌 .
+ .은 정확히 옵션은 아니지만, 자주 사용하기 때문에 옵션에 넣었다.
+ **현재 디렉토리**의 모든 변경 내용을 Staging Area로 넘길 때 사용한다.
```cs
git add .
```

### 📌 -A
+ **Working Directory**의 모든 변경 내용을 Staging Area로 넘길 때 사용한다.
```cs
git add -A
```

### 📌 -p
+ 각 변경 사항을 터미널에서 직접 눈으로 하나씩 확인하면서 Staging Area으로 넘기거나 또는 제외할 수있다.
+ 많은 변경 내용을 여러 개의 변경 기록으로 나누어서 남기고 싶을 때 유용하게 사용할 수 있다.
```cs
git add -p
```
