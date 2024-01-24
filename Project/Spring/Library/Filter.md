---
title: Filter
date: 2024-01-24 21:35
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## Filter
- Filter란 Web 애플리케이션에서 관리되는 영역으로 Client로 부터 오는 요청과 응답에 대해 **최초/최종 단계의 위치**이며 이를 통해 **요청과 응답의 정보를 변경하거나 부가적인 기능을 추가**할 수 있다.
- 주로 범용적으로 처리해야 하는 작업들, 예를 들어 **로깅 및 보안 처리**에 활용한다.
+ 또한 [[인증과 인가]]와 관련된 로직들을 처리할 수도 있다.
+ Filter를 사용하면 **인증, 인가와 관련된 로직을 비즈니스 로직과 분리하여 관리**할 수 있다는 장점이 있다.

![[filter.png]]

## Filter Chain
+ Filter는 한 개만 존재하는 것이 아니라 이렇게 여러 개가 Chain 형식으로 묶여서 처리될 수 있다.

![[filterChain.png]]