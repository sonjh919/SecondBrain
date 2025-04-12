---
title: TDD
date: 2024-01-17 11:42
categories:
  - Test
tags:
  - Test
  - TDD
image: 
path:
---
#Test #TDD 

## TDD(Test Driven Development)
 + **테스트 주도 개발**로, 테스트 코드를 먼저 만들고 이후에 프로덕션 코드를 만드는 개발 방법
 + 작은 단위의 테스트 케이스를 작성하고 이를 통과하는 코드를 추가하는 단계를 반복하여 구현한다.

### 기존의 개발 프로세스
![[notTDD.png]]

### TDD 개발 프로세스
![[TDD.png]]


### TDD 개발 사이클
+ Red-Green-Refactor라고 불린다.

1. Red : 실패하는 테스트를 구현한다.
2. Green : 테스트가 성공하도록 프로덕션 코드를 구현한다.
3. Refactor : 프로덕션 코드와 테스트 코드를 리팩토링한다.
![[TDDLifeCycle.png]]

---
### TDD를 사용하는 이유?
1. 리팩토링을 편하게 할 수 있다.
2. 버그가 줄어들고 코드가 간결해진다.
3. 설계에 대한 피드백이 빠르다
4. TDD는 코드의 재사용 보장을 명시하므로 TDD를 통한 소프트웨어 개발 시 기능 별 철저한 모듈화
5. 텍스트 문서의 대체가 가능하다
