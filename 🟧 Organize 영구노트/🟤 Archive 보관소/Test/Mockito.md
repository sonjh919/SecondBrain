---
title: Mockito
date: 2024-01-17 11:59
categories:
  - Test
tags:
  - Test
  - Mockito
image: 
path:
---
#Test #Mockito 
## Mockito
Mockito는 개발자가 동작을 직접 제어할 수 있는 **가짜 객체를 지원하는 테스트 프레임워크**이다. 일반적으로 Spring으로 웹 애플리케이션을 개발하면, 여러 객체들 간의 **의존성**이 생긴다. 이러한 의존성은 단위 테스트를 작성을 어렵게 하는데, 이를 해결하기 위해 가짜 객체를 주입시켜주는 Mockito 라이브러리를 활용할 수 있다. Mockito를 활용하면 가짜 객체에 원하는 결과를 Stub하여 단위 테스트를 진행할 수 있다. 물론 **프레임워크 도구가 필요없다면 사용하지 않는 것이 가장 좋다.**