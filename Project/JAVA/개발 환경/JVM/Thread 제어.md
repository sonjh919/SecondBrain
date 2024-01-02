---
title: Thread 제어
date: 2024-01-03 01:09
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

## Thread lifecycle
![[threadcontrol.png]]

## Thread 제어 메서드
### sleep()
+ 현재 쓰레드를 **지정된 시간동안 멈추게한다.**
+ [[Project/JAVA/기본 문법/예외 처리|예외 처리]]가 필요하다.

```java
try {
    Thread.sleep(2000); // 2초
} catch (InterruptedException e) {
    e.printStackTrace();
}
```

### interrupt()
+ **일시정지 상태**인 쓰레드를 **실행대기** 상태로 만든다.
+ 쓰레드가 `start()` 된 후 동작하다 `interrupt()`를 만나 실행하면 interrupted 상태가 true가 된다.
+ `isInterrupted()` 메서드를 사용하여 상태값을 확인할 수 있다.
+ `sleep()` 실행 중 `interrupt()`가 실행되면 예외가 발생한다.

```java
public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            while (!Thread.currentThread().isInterrupted()) {
                try {
                    Thread.sleep(1000);
                    System.out.println(Thread.currentThread().getName());
                } catch (InterruptedException e) {
                    break;
                }
            }
            System.out.println("task : " + Thread.currentThread().getName());
        };

        Thread thread = new Thread(task, "Thread");
        thread.start();

        thread.interrupt();

        System.out.println("thread.isInterrupted() = " + thread.isInterrupted());
        
    }
}
```

### join()
+ 정해진 시간동안 지정한 쓰레드가 작업하는 것을 기다린다.
+ 시간을 지정하지 않았을 때에는 지정한 쓰레드의 작업이 끝날 때까지 기다린다.
+ 예외 처리가 필요하다.

```java
Thread thread = new Thread(task, "thread");

thread.start();

try {
    thread.join();
} catch (InterruptedException e) {
    e.printStackTrace();
}
```

### yield()
+ 남은 시간을 다음 쓰레드에게 양보하고 쓰레드 자신은 실행대기 상태가 된다.

```java
public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            try {
                for (int i = 0; i < 10; i++) {
                    Thread.sleep(1000);
                    System.out.println(Thread.currentThread().getName());
                }
            } catch (InterruptedException e) {
                Thread.yield();
            }
        };

        Thread thread1 = new Thread(task, "thread1");
        Thread thread2 = new Thread(task, "thread2");

        thread1.start();
        thread2.start();

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        thread1.interrupt();

    }
}
```

### synchronized
+ 멀티 쓰레드의 경우 여러 쓰레드가 한 프로세스의 자원을 공유해서 작업하기 때문에 서로에게 영향을 줄 수 있다. 이로 인해서 장애나 버그가 발생할 수 있다.
+ 이러한 일을 방지하기 위해 **한 쓰레드가 진행중인 작업을 다른 쓰레드가 침범하지 못하도록 막는 것**을 '**쓰레드 동기화(Synchronization)**'라고 한다.
+ 동기화를 하려면 다른 쓰레드의 침범을 막아야하는 코드들을 ‘**임계영역**’으로 설정하면 된다.
+ 임계영역에는 Lock을 가진 단 하나의 쓰레드만 출입이 가능하다. 즉, 한번에 한 쓰레드만 사용이 가능하다.

```java
// 메서드 전체를 임계영역으로 지정
public synchronized void asyncSum() {
	  ...침범을 막아야하는 코드...
}

// 특정 영역을 임계영역으로 지정
synchronized(해당 객체의 참조변수) {
		...침범을 막아야하는 코드...
}
```
### wait()
+ 침범을 막은 코드를 수행하다가 작업을 더 이상 진행할 상황이 아니면, `wait()` 을 호출하여 쓰레드가 Lock을 반납하고 기다리게 할 수 있다.

### notify()



### Lock

### Condition
