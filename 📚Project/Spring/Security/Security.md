---
title: Security
date: 2024-01-24 22:27
categories:
  - Spring
  - Security
tags:
  - Spring
  - Security
image: 
path:
---
#Spring #Security 

## Security
+ Spring Security는 스프링 기반의 어플리케이션에서 보안을 담당하는 프레임워크로, [[인증과 인가]]를 다룬다.
+ Security는 [[Filter]] 기반으로 동작하며, 동시에 [[세션]] 방식으로 동작한다.

## Filter Chain
- Spring에서 모든 호출은 DispatcherServlet을 통과하게 되고 이후에 각 요청을 담당하는 Controller 로 분배된다.
- 이 때, 각 요청에 대해서 공통적으로 처리해야할 필요가 있을 때 DispatcherServlet 이전에 단계가 필요하며 이것이 Filter 이다.
- Spring Security도 인증 및 인가를 처리하기 위해 Filter를 사용하는데 Spring Security는 **FilterChainProxy**를 통해서 상세로직을 구현하고 있다.

![[filterChainsecurity.png]]

### Security Filter 순서

![[filterorder.png]]

## Form Login 기반의 인증
+ Form Login 기반 인증은 인증이 필요한 URL 요청이 들어왔을 때 **인증이 되지 않았다면 로그인 페이지를 반환**하는 형태이다.

![[FormLogin.png]]

## UsernamePasswordAuthenticationFilter
- UsernamePasswordAuthenticationFilter는 Spring Security의 필터인 AbstractAuthenticationProcessingFilter를 상속한 Filter이다.
- 기본적으로 **Form Login 기반을 사용할 때 username 과 password를 확인하여 인증**한다.
- 인증 과정
    1. 사용자가 username과 password를 제출하면 UsernamePasswordAuthenticationFilter는 인증된 사용자의 정보가 담기는 인증 객체인 Authentication의 종류 중 하나인 UsernamePasswordAuthenticationToken을 만들어 AuthenticationManager에게 넘겨 인증을 시도한다.
    2. 실패하면 SecurityContextHolder를 비운다.
    3. 성공하면 SecurityContextHolder에 Authentication를 세팅한다.

![[upaf.png]]

## SecurityContextHolder
- SecurityContext는 인증이 완료된 사용자의 상세 정보(Authentication)를 저장한다.
- SecurityContext는 SecurityContextHolder 로 접근할 수 있다.

![[securitycontextholder.png]]

```java
// 예시코드
SecurityContext context = SecurityContextHolder.createEmptyContext();
Authentication authentication = new UsernamePasswordAuthenticationToken(principal, credentials, authorities);
context.setAuthentication(authentication); // SecurityContext 에 인증 객체 Authentication 를 저장한다.

SecurityContextHolder.setContext(context);
```
## Authentication
- 현재 인증된 사용자를 나타내며 SecurityContext에서 가져올 수 있다.
- principal : 사용자를 식별한다.
    - Username/Password 방식으로 인증할 때 일반적으로 UserDetails 인스턴스이다.
- credentials : 주로 비밀번호, 대부분 사용자 인증에 사용한 후 비운다.
- authorities : 사용자에게 부여한 권한을 GrantedAuthority로 추상화하여 사용한다.

```java
<UserDetails>
@Override
public Collection<? extends GrantedAuthority> getAuthorities() {
    UserRoleEnum role = user.getRole();
    String authority = role.getAuthority();

    SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(authority);
    Collection<GrantedAuthority> authorities = new ArrayList<>();
    authorities.add(simpleGrantedAuthority);

    return authorities;
}

Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
```

>UsernamePasswordAuthenticationToken는 Authentication을 implements한 AbstractAuthenticationToken의 하위 클래스로, 인증객체를 만드는데 사용된다.
{: .prompt-info }

## UserDetailsService
+ UserDetailsService는 username/password 인증방식을 사용할 때 사용자를 조회하고 검증한 후 UserDetails를 반환한다. 
+ Custom하여 Bean으로 등록 후 사용 가능하다.


## UserDetails
+ 검증된 UserDetails는 UsernamePasswordAuthenticationToken 타입의 Authentication를 만들 때 사용되며 해당 인증객체는 SecurityContextHolder에 세팅된다. 
+ Custom하여 사용가능하다.
