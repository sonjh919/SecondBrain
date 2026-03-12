---
title: 데몬 Thread와 사용자 Thread
date: 2024-01-03 00:37
categories:
  - Java
  - Java개발환경
tags:
  - Java
  - Java개발환경
  - Java문법
  - JVM
image: 
path:
---
#Java #JVM 

## 데몬 Thread와 사용자 Thread
### 데몬 Thread
+ **보이지 않는곳(background) 에서 실행되는 낮은 우선순위를 가진 쓰레드**를 말한다.
+ 대표적인 데몬 쓰레드로는 [[Garbage Collector]]가 있다.
+ 다른 쓰레드가 모두 종료되면 강제종료당한다.
#### 데몬 Thread 설정
```java
public class Main {
    public static void main(String[] args) {
        Runnable demon = () -> {
            for (int i = 0; i < 1000000; i++) {
                System.out.println("demon");
            }
        };

        Thread thread = new Thread(demon);
        thread.setDaemon(true); // true로 설정시 데몬스레드로 실행됨

        thread.start();

        for (int i = 0; i < 100; i++) {
            System.out.println("task");
        }
    }
}
```

### 사용자 Thread
+ 보이는 곳(foregorund) 에서 실행되는 높은 우선순위를 가진 쓰레드를 말한다.
+ 프로그램 기능을 담당하며 대표적인 사용자 쓰레드로는 메인 쓰레드가 있다.
+ 우리가 흔히 이야기하는 Thread는 사용자 Thread이다.

> [!info]+ 
> JVM 은 사용자 쓰레드의 작업이 끝나면 데몬 쓰레드도 자동으로 종료시켜 버린다.
