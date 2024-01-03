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
### wait() & notify()
+ 침범을 막은 코드를 수행하다가 작업을 더 이상 진행할 상황이 아니면, `wait()` 을 호출하여 쓰레드가 Lock을 반납하고 기다리게 할 수 있다.
+ 추후에 작업을 진행할 수 있는 상황이 되면 `notify()`를 호출해서, 작업을 중단했던 쓰레드가 다시 Lock을 얻어 진행할 수 있게 된다.

```java
class AppleStore {
    private List<String> inventory = new ArrayList<>();

    public void restock(String item) {
        synchronized (this) {
            while (inventory.size() >= Main.MAX_ITEM) {
                System.out.println(Thread.currentThread().getName() + " Waiting!");
                try {
                    wait(); // 재고가 꽉 차있어서 재입고하지 않고 기다리는 중!
                    Thread.sleep(333);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            // 재입고
            inventory.add(item);
            notify(); // 재입고 되었음을 고객에게 알려주기
            System.out.println("Inventory 현황: " + inventory.toString());
        }
    }
```

### Lock
+ synchronized 블럭으로 동기화하면 자동적으로 Lock이 걸리고 풀리지만, 같은 메서드 내에서만 Lock을 걸 수 있다는 제약이 있다. 이런 제약을 해결하기 위해 Lock 클래스를 사용한다.

#### ReentrantLock
+ 재진입 가능한 Lock, 가장 일반적인 배타 Lock
+ 특정 조건에서 Lock을 풀고, 나중에 다시 Lock을 얻어 임계영역으로 진입이 가능하다.

#### ReentrantReadWriteLock
+ 읽기를 위한 Lock과 쓰기를 위한 Lock을 따로 제공한다.
+ 읽기 Lock이 걸려있는 상태에서 쓰기 Lock을 거는 것은 허용되지 않는다. **(데이터 변경 방지)**

#### StampedLock
+ ReentrantReadWriteLock에 **낙관적인 Lock**의 기능을 추가했다.
+ 낙관적인 Lock이란 **데이터를 변경하기 전에 락을 걸지 않는 것**을 말한다. 낙관적인 락은 데이터 변경을 할 때 충돌이 일어날 가능성이 적은 상황에서 사용한다.
### Condition
+ wait() & notify()의 문제점인 waiting pool 내 쓰레드를 구분하지 못한다는 것을 해결한 것이 Condition이다.
+ **wait() & notify() 대신 Condition의 await() & signal() 을 사용**한다.