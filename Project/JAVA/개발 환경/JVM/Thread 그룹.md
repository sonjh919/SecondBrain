---
title: Thread 그룹
date: 2024-01-03 00:49
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

## Thread 그룹
+ 서로 관련이 있는 Thread들을 그룹으로 묶어서 다룰 수 있다.
+ 쓰레드들은 기본적으로 그룹에 포함되어 있는데, JVM이 시작되면 기본적으로 **system 그룹**에 포함된다.
+ 메인 쓰레드는 system 그룹 하위에 있는 main 그룹에 포함된다.
+ 모든 쓰레드들은 반드시 하나의 그룹에 포함되어 있어야 한다.
+ **그룹을 지정하지 않으면 자동으로 main 그룹에 포함**된다.

## Thread 그룹 생성
+ ThreadGroup 클래스로 객체를 만들어 Thread 객체 생성 시 첫번째 매개변수로 넣어준다.

```java
// ThreadGroup 클래스로 객체를 만듭니다.
ThreadGroup group1 = new ThreadGroup("Group1");

// Thread 객체 생성시 첫번째 매개변수로 넣어줍니다.
// Thread(ThreadGroup group, Runnable target, String name)
Thread thread1 = new Thread(group1, task, "Thread 1");

// Thread에 ThreadGroup 이 할당된것을 확인할 수 있습니다.
System.out.println("Group of thread1 : " + thread1.getThreadGroup().getName());
```

### 실행 대기
+ `interrupt()` 메서드를 이용해 해당 그룹의 쓰레드를 실행대기 상태로 변경할 수 있다.

```java
// ThreadGroup 클래스로 객체를 만듭니다.
ThreadGroup group1 = new ThreadGroup("Group1");

// Thread 객체 생성시 첫번째 매개변수로 넣어줍니다.
// Thread(ThreadGroup group, Runnable target, String name)
Thread thread1 = new Thread(group1, task, "Thread 1");
Thread thread2 = new Thread(group1, task, "Thread 2");

// interrupt()는 일시정지 상태인 쓰레드를 실행대기 상태로 만듭니다.
group1.interrupt();
```