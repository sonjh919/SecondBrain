---
---
#DataStructure 

### Queue
+ **선입선출(FIFO; First-In-First-Out)**
+ 가장 먼저 들어간 원소가 제일 먼저 나오는 구조
+ **순차적으로 일들을 처리하는 문제**에 적합한 구조이다.

![[Queue.png]]

## 파이썬에서 Queue 사용하기
### list
+ list를 사용할 수도 있지만, 성능 면에서 추천하지 않는다.
+ pop(0)또는 insert() 함수의 [[시간 복잡도]]는 O(n)이기 때문에 데이터가 많아질수록 느려진다.
```python
queue = [1, 2, 3] # init

queue.append(4) # Enqueue
queue.pop(0) # Dequeue

# 반대 방향으로 사용
queue.insert(0, 4) # Enqueue
queue.pop() # Dequeue
```
### queue
```python
from queue import Queue
queue = Queue()
queue.put(4) # Enqueue
queue.get() # Dequeue
```
### deque
```python
from collections import deque
queue = deque([1,2,3])
queue.append(4) # Enqueue
queue.popleft() # Dequeue
```