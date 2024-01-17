---
title: Thread 우선순위
date: 2024-01-03 00:43
categories:
  - Java
  - Java개발환경
tags:
  - Java
  - JVM
  - Java문법
  - Java개발환경
image: 
path:
---

## Thread 우선순위
+ 쓰레드 작업의 중요도에 따라서 쓰레드의 우선순위를 부여할 수 있다.
+ 쓰레드는 생성될때 우선순위가 정해지는데, 이 순위는 우리가 직접 지정하거나 [[JVM]]에 의해 지정될 수 있다.

### 우선순위의 종류
+ 다음과 같이 3가지의 우선순위로 나뉜다.
+ 더 자세하게 나눈다면 1~10 사이의 숫자로 지정 가능하고, 이 범위는 JVM에서 설정한 우선순위이다.
+ 기본 값은 보통 우선순위이다.

| 우선순위 종류 | 지정숫자 |
| ---- | ---- |
| 최대 우선순위(MAX_PRIORITY) | 10 |
| 보통 우선순위(NROM_PRIORITY) | 5 |
| 최소 우선순위(MIN_PRIORITY) | 1 |

### 우선순위 설정
+ `setPriority()` 메서드로 설정한다.

```java
Thread thread1 = new Thread(task1);
thread1.setPriority(8);
```

### 우선순위 확인
+ `getPriority()` 메서드로 우선순위를 반환하여 확인할 수 있다.

```java
int threadPriority = thread1.getPriority();
System.out.println("threadPriority = " + threadPriority);
```


> 우선순위가 높다고 반드시 쓰레드가 먼저 종료되는 것은 아니다.
> 확률이 높은거지 반드시 먼저 종료가 되는 것은 아니다.
{: .prompt-warning }
