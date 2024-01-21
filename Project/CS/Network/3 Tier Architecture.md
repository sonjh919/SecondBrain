---
title: 3 Tier Architecture
date: 2024-01-17 14:37
categories:
  - CS
  - Network
tags:
  - CS
  - Network
image: 
path:
---


[[Server의 분리]] 방식에 따라 3,2,1 Tier Architecture로 나눈다.
## 3 Tier Architecture
- Server에 관한 부분을 **Web Server, WAS, DB Server** 3가지로 나누어 서로 네트워크 통신을 하도록 하는 것
- 장점 : 사용자에 따라 필요한 부분만 server를 확장하여 사용할 수 있다.
- 단점 : DB Server로의 통신 간에 병목 현상이 발생할 수 있으므로 query문의 중요도가 올라간다.

## 2 Tier Architecture
- **Web Server와 WAS를 합치고**, DB Server와 분리하여 2단계로 나눈 Architecture
- 네트워크 통신보다는 로컬 통신을 하여 속도가 더 빠르다.
- 확장 시 Web Server와 WAS를 합쳐 확장해야 하기 때문에 불필요한 부분도 확장을 해야 하며, 컴퓨터의 성능도 중요한 요소가 된다.

## 1 Tier Architecture
- 사실상 확장이 불가능하다.
- 로컬 통신이기 때문에 속도는 더더욱 올라간다.
- 작은 규모의 서버에서 사용한다.