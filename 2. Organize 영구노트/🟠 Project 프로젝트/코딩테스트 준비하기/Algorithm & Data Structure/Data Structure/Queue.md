---
---
#DataStructure 

## Queue
+ **선입선출(FIFO; First-In-First-Out)**
+ 가장 먼저 들어간 원소가 제일 먼저 나오는 구조
+ **순차적으로 일들을 처리하는 문제**에 적합한 구조이다.

![[Queue.png]]

### 연산 정의
Queue에서 정의되는 연산은 다음과 같다.

> [!info]+ 
> 1. add
> 2. poll
> 3. isFull
> 4. isEmpty
> 5. front : 마지막에 add한 데이터 위치 기록
> 6. rear : 최근에 add한 데이터 위치 기록
> 7. data : 데이터를 관리하는 배열


### java queue
```java
ArrayDeque<Integer> queue = new ArrayDeque<>(); // 양 끝에서 삽입이나 삭제할 수 있는 큐  
queue.addLast(1);  
queue.pollFirst();
```