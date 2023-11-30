### 덱 (Deque)
+ **후입선출(LIFO) + 선입선출(FIFO)**
+ 시작 부분(front)와 끝 부분(rear)에서 동시에 입출력이 가능한 형태의 자료구조
+ **데이터의 변동이 많은 문제**에 적합한 구조이다.

![[Deque.png]]

## 파이썬에서 Deque 사용하기
### deque
```python
from collections import deque

dq = deque([1,2,3]) # deque 생성

dq.appendleft(0) # 왼쪽에 삽입
dq.append(4) # 오른쪽에 삽입

dq.popleft() # 가장 왼쪽의 원소 반환
dq.pop() # 가장 오른쪽의 원소 반환

dq.clear() # 모든 원소 제거
dq.copy() # deque 복사
dq.count(x) # x와 같은 원소의 개수를 계산
```
