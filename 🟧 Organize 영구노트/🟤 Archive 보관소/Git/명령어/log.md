---
title: log
date: 2023-12-21 12:47
categories:
  - Git
tags:
  - Git
  - Git명령어
image: 
path:
---
#Git

## log
+ 저장소의 history를 볼 수 있다.
+ 저장소의 [[🟡 Area/Git/명령어/commit]] 히스토리를 **시간순**으로 보여준다.
```git
git log
```


## 옵션
### -p
+ 각 commit의 diff 결과를 보여준다.
```
git log -p branch명
```

### -숫자
+ 최근 n개의 결과만 보여준다.
```
git log -p -2
```

### --stat
+ 각 commit의 통계 정보를 조회할 수 있다.
```
git log --stat
```