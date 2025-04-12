---
title: fetch
date: 2023-12-21 14:02
categories:
  - Git
tags:
  - Git
  - Git명령어
image: 
path:
---
#Git

## fetch
+ 원격저장소에 있는 변경내역들을 로컬저장소로 [[pull]] 하기 전에 **변경된 내역들만  
가져와서 확인**시켜준다.
+  원격저장소에 있는 내용을 pull 하기 전에, 어떠한 변경 내역들이 있는지 변경 내역에 대한 로그를 확인하고 신중히 결정한 후에 pull 할 수 있는 기능이다.

```cs
# 원격저장소에 변동사항만을 가져온다.
git fetch [원격저장소 이름]

# FETCH_HEAD에 업데이트된 원격저장소의 최신 커밋이, 현재 브랜치에 병합된다.
git merge FETCH_HEAD
```

### 👀 FETCH_HEAD?
+ Git에서 Fetch 할 때 마다 업데이트 되는 .git 디렉터리 하위에 위치한 파일
+ 이 파일에는 원격저장소가 병합할 때 마다 생기는 **최신 커밋의 정보**가 들어 있다.