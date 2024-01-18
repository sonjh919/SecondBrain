---
title: 이미 push한 commit 변경하기
date: 2024-01-03 17:32
categories:
  - Error
  - Git
tags:
  - Git
  - Error
image: 
path:
---

## 발생 상황
인텔리제이로 작업을 하던 도중, commit 메시지를 잘못 쓴 것을 발견했다. 하지만 commit and push를 했기 때문에 이미 올라가버린 commit.. 다시 복구할 순 없을까?

## 해결방안
### 1. rebase
먼저, git rebase를 사용하여 재설정 모드에 들어간다. HEAD~1은 첫번째 commit이라는 의미이다. 첫번째가 아니면 그에 맞는 숫자를 넣어주면 된다.

```shell
git rebase HEAD~1 -i   
```

### 1-1.  rebase 오류
그런데, 나는 여기서 다음과 같은 오류가 발생했다.

```shell
error: cannot rebase: You have unstaged changes.
```

이 오류는 마지막 커밋 이후에 작업한 것이 있어서였다!! 그래서 일단 작업했던 것들을 stash를 이용해 임시로 저장한 후 나중에 빼오기로 했다.

일단 변경 사항이 있는지 확인하고,

```shell
git status
```

변경 사항이 있는 것을 확인하여 임시 저장을 진행했다.

```shell
git stash
```

### 2.  pick → reword 변경
이제 다시 rebase를 했더니 안전하게 편집기에 진입할 수 있었다. 수정 모드(i 입력)으로 들어가면, 메시지 제일 앞쪽에 위치한 `pick`이 보일 것이다. 기존에 작성한 commit message는 일단 놔두고, `pick`을 먼저 `reword`로 변경한다.

변경을 완료했다면 `esc -> :wq! -> enter` 순으로 해당 내용을 저장한다.

### 2-2. ESC가 안먹어요!
그런데, 이번엔 또 esc가 먹지 않는 것이었다..!! 에휴..
또 찾아봤더니, **“Switch Focus To Editor” 기능으로 esc 단축키가 할당되어 있기 때문**이었다!

esc 단축키 할당을 해제 또는 변경하기 위해서는 다음과 같은 단계를 거치면 된다.
1. “File -> Settings” 메뉴 선택 후, “Tool -> Terminal” 항목으로 이동한다.
2. 옵션 항목 중 “Override IDE shortcuts” 오른쪽에 있는 “Configure terminal keybindings” 링크를 클릭한다.
3. “Keymap” 옵션 항목으로 이동되었다면, 맨 아래에 “Switch Focus To Editor” 메뉴가 있고 이에 대한 단축키를 해제 또는 변경하면 된다.

### 3. commit message 수정
여차저차 해서 여기까지 왔다면, 드디어 commit message를 수정하면 된다. 수정한 이후에는 마찬가지로 `esc -> :wq! -> enter`를 통해 빠져나온다.

### 4. 강제 push 수행
이제 원격 저장소의 내용이 로컬 저장소의 내용과 일치하도록 원격 저장소의 변경사항들을 강제로 덮어씌운다.

```shell
git push origin master -f
```

### 5. 저장했던거 다시 가져오기
stash로 저장해놨던거를 까먹으면 안된다! 처음부터 다시 할 순 없잖아.. 가져와서 이어서 작업하자.

```shell
git stash pop
```