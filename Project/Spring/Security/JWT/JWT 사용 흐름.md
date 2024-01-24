---
title: JWT 사용 흐름
date: 2024-01-24 14:35
categories:
  - Spring
  - Security
tags:
  - Spring
  - Security
  - JWT
image: 
path:
---

## JWT 사용 흐름
### 1. Client 가 username, password 로 로그인 성공 시
1. 서버에서 "로그인 정보"를 Secret Key를 사용하여 [[JWT]]로 암호화한다.
![[jwpex.png]]

2. 서버에서 직접 [[쿠키]]를 생성해 JWT를 담아 Client 응답에 전달한다. JWT 전달 방법은 개발자가 정한다. 주로 응답 Header에 아래 형태로 JWT가 전달된다.

```java
Cookie cookie = new Cookie(AUTHORIZATION_HEADER, token); // Name-Value
cookie.setPath("/");

// Response 객체에 Cookie 추가
res.addCookie(cookie);
```

![[jwpex2 1.png]]

3. 브라우저 쿠키 저장소에 자동으로 JWT가 저장되게 된다.

![[jwpex3.png]]

## 2. Client 에서 JWT를 통한 인증방법
### 1. 서버에서 API 요청 시마다 쿠키에 포함된 JWT를 찾아서 사용
+ 쿠키에 담긴 정보가 여러 개일 수 있기 때문에 그 중 이름이 JWT가 담긴 쿠키의 이름과 동일한지 확인하여 JWT를 가져온다.

```java
// HttpServletRequest 에서 Cookie Value : JWT 가져오기
public String getTokenFromRequest(HttpServletRequest req) {
    Cookie[] cookies = req.getCookies();
    if(cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(AUTHORIZATION_HEADER)) {
                try {
                    return URLDecoder.decode(cookie.getValue(), "UTF-8"); // Encode 되어 넘어간 Value 다시 Decode
                } catch (UnsupportedEncodingException e) {
                    return null;
                }
            }
        }
    }
    return null;
}
```

### 2. Server
1. Client 가 전달한 **JWT 위조 여부 검증** (Secret Key 사용)
2. JWT 유효기간이 지나지 않았는지 검증
3. 검증 성공시, JWT에서 사용자 정보를 가져와 확인
