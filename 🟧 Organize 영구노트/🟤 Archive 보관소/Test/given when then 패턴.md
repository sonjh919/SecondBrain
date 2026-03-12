---
title: given when then 패턴
date: 2024-01-17 11:54
categories:
  - Test
tags:
  - Test
image: 
path:
---
#Test 

## given-when-then 패턴이란?
단위테스트는 거의 given-when-then 패턴으로 작성하는 경우가 많다. given-when-then 패턴이란 1개의 단위 테스트를 3가지 단계로 나누어 처리하는 패턴으로, 각각의 단계는 다음을 의미한다.

> [!note]+ 
> - **given**(준비): 어떠한 데이터가 준비되었을 때
> - **when**(실행): 어떠한 함수를 실행하면
> - **then**(검증): 어떠한 결과가 나와야 한다.

추가적으로 어떤 메소드가 몇번 호출되었는지를 검사하기 위한 verify 단계도 사용하는 경우가 있지만, 선택 사항이다.