---
---
#DataStructure 

### Stack
+ **후입선출(LIFO; Last-In-First-Out)**
+ 가장 먼저 들어간 원소가 제일 나중에 나오는 구조
+ **어떤 작업의 순서를 되돌아가야 하는 문제**에 적합한 구조이다.

![[Stack.png]]

## 파이썬에서 Stack 사용하기
### list
```python
stack = [1, 2, 3] # init

stack.append(4) # push
stack.pop() # pop
top = stack[-1] # top
```

### deque
```python
from collections import deque

queue = deque([1,2,3])

queue.append(4) # Enqueue
queue.pop() # Dequeue
```
