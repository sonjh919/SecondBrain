---
tistoryBlogName: sonjh919
tistoryTitle: checkout
tistoryTags: Git, Git명령어
tistoryVisibility: "3"
tistoryCategory: "1206689"
tistorySkipModal: true
tistoryPostId: "24"
tistoryPostUrl: https://sonjh919.tistory.com/24
---
#Git 
## 🌈 checkout
+ 다양한 기능을 수행할 수 있으나, 주로 **branch 전환**과 **파일 복원**에 사용된다.

```cs
git checkout branch명
```

## 🌈 옵션
### 📌 -b
+ branch를 전환할 때 해당 branch가 없다면 새로운 branch를 생성한 후 전환한다.
```cs
git checkout -b branch명
```

### 📌 -- filename
+ 파일 하나를 대상으로 변경 내역을 통째로 원래대로 (변경 직전의 최종 커밋 시점으로) 되돌릴 때 사용한다.
```cs
git checkout -- filename
```


