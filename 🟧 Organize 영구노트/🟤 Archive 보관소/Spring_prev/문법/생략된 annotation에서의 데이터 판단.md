---
title: 생략된 annotation에서 데이터 판단
date: 2024-01-18 09:50
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring 

## 생략된 annotation에서의 데이터 판단
http 정보를 받아올 때, @RequestParam으로 받아올 수도 있고, @ModelAttribute로 받아올 수도 있다. 두 annotation 모두 생략이 가능한데, Spring에서는 어떻게 구분할 수 있을까?

바로 **파라미터의 Type을 기준으로 구분**한다. 해당 파라미터가 SimpleValueType이면 @RequestParam으로 간주하고, 만약 그렇지 않으면(객체이면) @ModelAttribute가 생략이 되었다고 판단한다.

참조 : [[Client에서 데이터 받기]], [[HTTP 데이터 객체로 변환하기]]

> SimpleValueType은 원시타입(int), Wrapper타입(Integer), Date등의 타입을 의미한다.
{: .prompt-tip }