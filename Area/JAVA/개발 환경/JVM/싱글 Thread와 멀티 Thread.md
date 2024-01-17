---
title: 싱글 Thread와 멀티 Thread
date: 2024-01-03 00:36
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

## 싱글 Thread와 멀티 Thread
### 싱글 Thread
+ Java 프로그램의 경우 main() 메서드만 실행시켰을때 이것을 싱글 쓰레드라고 한다.
+ Java 프로그램 main() 메서드의 쓰레드를 ‘메인 쓰레드’ 라고 부른다.
+ JVM 의 메인 쓰레드가 종료되면, JVM 도 같이 종료 된다.

### 멀티 Thread
#### 장점
+ Java 프로그램은 메인 쓰레드외에 다른 작업 쓰레드들을 생성하여 **여러개의 실행흐름**을 만들 수 있다.
+ 여러 작업을 동시에 할 수 있기 때문에 성능이 좋아진다.
+ [[Stack Area]]를 제외한 모든 영역에서 메모리를 공유하기 때문에 자원을 효율적으로 사용할 수 있다.
+ 응답 쓰레드와 작업 쓰레드를 분리하여 빠르게 응답을 줄 수 있다. → **비동기**

#### 단점
+ 동기화 문제가 발생할 수 있다.

>프로세스의 자원을 공유 하면서 작업을 처리하기 때문에 자원을 서로 사용하려고 하는 충돌이 발생하는 경우를 의미한다.
{: .prompt-info }

+ 교착 상태(데드락)이 발생할 수 있다.

>둘 이상의 쓰레드가 서로의 자원을 원하는 상태가 되었을 때 서로 작업이 종료되기만을 기다리며 작업을 더 이상 진행하지 못하게 되는 상태를 의미한다.
{: .prompt-info }

## Thread와 Runnable
### Thread 구현
+ 쓰레드 구현을 위해서는 Java에서 제공하는 Thread 클래스를 상속받아야 한다.
+ **run()** 메서드에 작성된 코드가 쓰레드가 수행할 작업이다.

```java
public class TestThread extends Thread {
				@Override
				public void run() {
							// 쓰레드 수행작업
				}
}

...

TestThread thread = new TestThread(); // 쓰레드 생성
thread.start() // 쓰레드 실행
```

### Runnable
+ 쓰레드 구현을 위해 Thread 클래스를 상속받으면 다중 상속을 지원하지 않기 때문에 확장성이 매우 떨어진다.
+ 때문에 Runnable이라는 **인터페이스를 이용해 다른 클래스를 상속받게 할 수 있다.**

```java
public class TestRunnable implements Runnable {
				@Override
				public void run() {
							// 쓰레드 수행작업 
				}
}

...

Runnable run = new TestRunnable();
Thread thread = new Thread(run); // 쓰레드 생성

thread.start(); // 쓰레드 실행
```

### 람다식
+ 람다를 이용한 구현이다.

```java
public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            int sum = 0;
            for (int i = 0; i < 50; i++) {
                sum += i;
                System.out.println(sum);
            }
            // 현재 실행 중인 쓰레드의 이름을 반환한다.
            System.out.println(Thread.currentThread().getName() + " 최종 합 : " + sum);
        };

        Thread thread1 = new Thread(task);
        thread1.setName("thread1");
        Thread thread2 = new Thread(task);
        thread2.setName("thread2");

        thread1.start();
        thread2.start();
    }
}
```

## 멀티 Thread 구현
+ **순서가 정해져 있지 않아** 출력의 형태가 계속해서 변화한다.
+ 즉 2개의 쓰레드는 서로 번갈아가면서 수행된다.
+ 수행 순서나 시간은 **OS의 스케줄러가 처리**한다.

```java
public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.print("$");
            }
        };
        Runnable task2 = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.print("*");
            }
        };

        Thread thread1 = new Thread(task);
        thread1.setName("thread1");
        Thread thread2 = new Thread(task2);
        thread2.setName("thread2");

        thread1.start();
        thread2.start();
    }
}
```
