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
#Spring 

## PathVariable vs RequestParam
데이터를 받는 과정에서, 방식만 다르고 하는 역할은 똑같은 두 가지가 있다. PathVariable 방식과 RequestParam 방식인데, 과연 이 둘은 어떻게 다를까?

### 보안이슈
일단, 둘의 차이를 떠나서 비밀번호같은 보안 이슈는 당연히 URL에 들어가면 안된다. 보안과 밀접한 데이터들은 모두 RequestBody에 담아 보내자.

### 반드시 받아야 하는 값 vs 안받아도 되는 값
둘의 차이는 require의 여부이다. Spring에서도 나오듯이, RequestParam은 require을 True/False로 선택할 수 있다. 그렇다면, 왜 RequestParam은 안받아도 되며, 반대로 PathVariable은 왜 꼭 받아야 할까?

### API가 달라진다.
PathVariable은 생략하면 다른 api가 되기 때문이다. 예를 들자면, GET api/students/{id}가 있다고 하자. 그런데 id를 만약 생략한다면, 이는 GET api/students라는 다른 api를 호출하게 되므로 상당히 위험하다고 할 수 있다. 하지만 RequestParam은 생략해도 동일한 api이기 때문에 생략해도 상관없는 것이다.
