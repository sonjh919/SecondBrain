
## 🌈 add
+ [[Working directory]]상의 변경 내용을 [[Staging Area]]에 추가하기 위해서 사용한다.
+ 다음 commit을 기록할 때 까지 **변경분을 모아놓기 위해 사용**한다.

```git
git checkout branch명
```

## 🌈 옵션
### 📌 -b
+ branch를 전환할 때 해당 branch가 없다면 새로운 branch를 생성한 후 전환한다.
```
git checkout -b branch명
```

### 📌 -- filename
+ 파일 하나를 대상으로 변경 내역을 통째로 원래대로 (변경 직전의 최종 커밋 시점으로) 되돌릴 때 사용한다.
```
git checkout -- filename
```


