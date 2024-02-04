api : 

get post

돌아간다 -> 이제 시작 -> 
## URL 규칙
api(취향차이)/v1(버전)(취향차이)/(도메인)명(복수형)/기능


# user

# 회원가입
이름
비밀번호

## request
### 1. method
post

### 2. url

api/users/signup

### requestheader

### 3. requestbody
@requestbody

이름 : 손준형
비밀번호 : 1234

```json
{
	"name" : "손준형",
	"password": "1234"
}
```

## response
response의 구조

1. 입력받는 문자의 형식이 다를 경우
2. 이미 가입된 이름일 경우
3. 아무것도 안들어올 경우 

4. 회원가입 성공 (성공) -> 구현


### 회원가입 성공!
#### 1. 상태코드
200 (ok)

#### 2. responseheader


#### 3.  responsebody
메세지 : 가입성공!
```json
{
	"message" : "가입성공!"
}
```




회원가입 api 설계 완료!





## 로그인

## 유저 정보 api