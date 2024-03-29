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
  - Java문법
image: 
path:
---
#Java #JVM 

## Thread
+ [[Process]] 안에서 실질적으로 작업을 실행하는 단위를 말하며, 자바에서는 [[JVM]]에 의해 관리된다. 
+ **Process가 할당받은 자원을 이용하는 실행의 단위**

### Thread의 특징
+ Process에는 적어도 한개 이상의 Thread가 있으며, **Main Thread 하나로 시작**하여 Thread를 추가 생성하게 되면 멀티 Thread 환경이 된다. 이러한 스레드들은 프로세스의 리소스를 공유하기 때문에 효율적이긴 하지만 잠재적인 문제점에 노출될 수도 있다.
+ Thread 작업의 중요도에 따라 [[Thread 우선순위]]를 부여할 수 있다.
+ 서로 관련이 있는 Thread들을 [[Thread 그룹]]으로 묶어서 다룰 수 있다.
### Thread의 생성
+ 프로세스가 작업중인 프로그램에서 실행요청이 들어오면 쓰레드(일꾼)을 만들어 명령을 처리하도록 한다.
### Thread의 자원
+ 프로세스 안에는 여러 쓰레드(일꾼)들이 있고, 쓰레드들은 실행을 위한 프로세스 내 주소공간이나 메모리공간(Heap)을 공유받는다.
- 추가로, 쓰레드(일꾼)들은 각각 명령처리를 위한 자신만의 메모리공간(Stack)도 할당받는다.

![[thread.png]]

## Thread의 분류
+ [[싱글 Thread와 멀티 Thread]]
+ [[데몬 Thread와 사용자 Thread]]

## Thread 상태
![[threadstate.png]]
+ 쓰레드는 실행과 대기를 반복하며 `run()` 메서드를 수행한다.
+ `run()` 메서드가 종료되면 실행이 멈춘다.
+ 쓰레드가 다시 실행 상태로 넘어가기 위해서는 우선 일시정지 상태에서 실행대기 상태로 넘어가야 한다.
+ 각 상태에 따른 [[Thread 제어]] 메서드를 제공한다.

| 상태     | Enum          | 설명                                                    |
| -------- | ------------- | ------------------------------------------------------- |
| 객체생성 | NEW           | 쓰레드 객체 생성, 아직 start() 메서드 호출 전의 상태    |
| 실행대기 | RUNNABLE      | 실행 상태로 언제든지 갈 수 있는 상태                    |
| 일시정지 | WAITING       | 다른 쓰레드가 통지(notify) 할 때까지 기다리는 상태      |
| 일시정지 | TIMED_WAITING | 주어진 시간 동안 기다리는 상태                          |
| 일시정지 | BLOCKED       | 사용하고자 하는 객체의 Lock이 풀릴 때까지 기다리는 상태 |
| 종료     | TERMINATED    | 쓰레드의 작업이 종료된 상태                             |

