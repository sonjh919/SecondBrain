---
title: Git의 3가지 영역
date: 2023-12-21 14:11
categories:
  - Git
tags:
  - Git
  - Git개념
image: 
path:
---
#Git

## Git의 3가지 영역
우리가 [[Area/Git/명령어/commit|commit]]을 진행할 때, 총 3가지 영역을 바탕으로 작동한다.

Untracked Area: Git이 관리하고 있지 않은 영역
Tracked Area : Git의 관리를 받을 수 있는 영역
Staging Area: commit이 가능한 영역

## Git의 3가지 상태
Unmodified : 기존에 Commit 했던 파일을 수정하지 않은 상태
Modified : 기존에 Commit 했던 파일을 수정한 상태. [[add]]를 이용해 이를 Staged로 옮긴다.
Staged : Commit이 가능한 상태. Staged 상태가 되기 위해서는 add를 사용해야 한다.

