---
title: pathvariable vs requestparam
date: 2024-01-24 17:43
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
pathvariable
requestparam
언제쓸지 차이

비밀번호 -> 보안이슈 -> 당연히 requestbody

반드시 받아야하는 값과 안받아도되는 값의 차이

requestparam이 required를 안받는다. 생략되도 동일한 api이다.

pathvariable은 생략이 될 수 가 없다. 생략되면 다른 api가 된다.