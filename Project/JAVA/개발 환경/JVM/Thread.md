---
title: Thread
date: 2023-12-29 14:46
categories:
  - Java
  - Java개발환경
tags:
  - Java
  - Java개발환경
  - JVM
image: 
path:
---

## Thread
+ [[Process]] 안에서 실질적으로 작업을 실행하는 단위를 말하며, 자바에서는 [[JVM]]에 의해 관리된다. 
+ Process에는 적어도 한개 이상의 Thread가 있으며, **Main Thread 하나로 시작**하여 Thread를 추가 생성하게 되면 멀티 Thread 환경이 된다. 이러한 스레드들은 프로세스의 리소스를 공유하기 때문에 효율적이긴 하지만 잠재적인 문제점에 노출될 수도 있다.