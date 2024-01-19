---
title: DTO
date: 2024-01-18 11:15
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## DTO (Data Transfer Object)
+ DTO(Data Transfer Object)는 데이터 전송 및 이동을 위해 생성되는 객체를 의미한다.
+ 계층간에 Data를 전달하고 Return받을, Data를 뭉치기 위한 용도의 객체이다.
- Data를 옮기는 역할이기 때문에 전 계층에서 사용 가능하다.
- View에서도 쓸수 있지만 Java의 영향을 받지 않게 하기 위해 쓰지 않는다.

### DTO 사용처
+ Client에서 보내오는 데이터를 객체로 처리할 때
+ 서버의 계층간의 이동
+ 그리고 DB와의 소통을 담당하는 Java 클래스를 그대로 Client에 반환하는 것이 아니라 DTO로 한번 변환한 후 반환할 때

### DTO 클래스 네이밍
Request의 데이터를 처리할 때 사용되는 객체는 **RequestDto**, Response를 할 때 사용되는 객체는 **ResponseDto라는** 이름을 붙여 DTO 클래스를 만들 수 있다. 절대적인 규칙은 아니기 때문에 조직에 따라 규칙이 다를 수 있다.