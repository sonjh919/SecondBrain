---
title: commit
date: 2023-12-21 11:57
categories:
  - Git
tags:
  - Git
  - Git명령어
image: 
path:
---

## commit
+ 저장소의 변경 내역을 git에 저장한다.
+ 코드에 변경이 있더라도 해당 commit 시점으로 되돌릴 수가 있다.

```cs
git commit
```

## 옵션
### -m
+ commit 시 메세지를 작성할 수 있다.
+ commit 메세지 작성에 대한 자세한 방법은 [[Commit 종류]]를 확인하자.
```cs
git commit -m 메세지
```

### --amend
+ commit의 내용을 덮어쓴다.
```cs
git commit --amend
```
