---
title: URI vs URL
date: 2024-01-21 15:04
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---

## URI (Uniform Resource Identifier)
URI는 우리말로 **통합 자원 식별자**라고 한다. Uniform은 리소스를 식별하는 통일된 방식을 말한다. Resource란
URI로 식별이 가능한 모든 종류의 자원(웹 브라우저 파일 및 그 이외의 리소스 포함)을 지칭하며 Identifier는 다른 항목과 구분하기 위해 필요한 정보이다.

> 즉 URI는 인터넷상의 리소스 "**자원 자체**"를 식별하는 고유한 문자열 시퀀스이다.
{: .prompt-info }


## URL (Uniform Resource Locator)
URL은 Uniform Resource Locator, 네트워크상에서 통합 자원(리소스)의 “**위치**”를 나타내기 위한 규약이다. 자원 식별자와 위치를 동시에 보여준다는 뜻이며, 다시 말해 웹 사이트의 주소뿐만 아니라 프로토콜([[HTTP]])을 함께 나타낸다는 뜻이다.

> 웹 사이트 주소 + 컴퓨터 네트워크 상의 자원
{: .prompt-info }

## URN (Uniform Resource Name)
URN은 리소스의 위치, 프로토콜, 호스트 등과는 상관없이 각 자원에 이름을 부여한 것으로, 웹 문서의 물리적인 위치와 상관없이 웹 문서 자체를 나타낸다.

## URI vs URL
> URI= 식별자, URL=식별자+위치
{: .prompt-info }

+ URI가 더 포괄적인 개념이며 URL은 이 안에 포함된다.

![[URIURLURN.png]]

출처 : https://www.elancer.co.kr/blog/view?seq=74