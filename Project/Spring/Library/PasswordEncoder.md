---
title: 암호화
date: 2024-01-24 10:43
categories:
  - Spring
  - Security
tags:
  - Spring
  - Security
image: 
path:
---
#Spring #Library 

## PasswordEncoder
+ Spring Security에서 지원하는 보안 관련 인터페이스이다.
+ BcryptPasswordEncoder, BCrypt, SCrypt, Argon2 등의 알고리즘을 지원한다.

### BCryptPasswordEncoder
+ BCrypt 해시 알고리즘은 비밀번호와 같은 비밀 정보를 안전하게 저장하기 위한 해시 함수 중 하나이다.
+ Blowfish라는 대칭형 블록 암호화 알고리즘을 기반으로 하며, 비밀번호를 안전하게 저장하기 위한 목적으로 설계되었다.

```java
@Configuration
public class PasswordConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

## password 확인
```java
// 사용예시
// 비밀번호 확인
if(!passwordEncoder.matches("사용자가 입력한 비밀번호", "저장된 비밀번호")) {
		   throw new IllegalAccessError("비밀번호가 일치하지 않습니다.");
 }
```