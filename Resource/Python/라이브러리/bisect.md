### bisect
+ **이진 탐색**을 위한 함수를 제공한다.

### bisect(iterable, value)
+ 어떤 인덱스에 넣어야 할지 계산하는 함수
+ bisect_left(literable, value) : 왼쪽 인덱스를 구하기 (**이진 탐색**)
+ bisect_right(literable, value) : 오른쪽 인덱스를 구하기

```python
from bisect import bisect_left, bisect_right  
  
nums = [0,1,2,3,4,5,6,7,8,9]  
n = 5  
  
print(bisect_left(nums, n)) # 5
print(bisect_right(nums, n)) # 6
```

### bisect.insort
+ 정렬이 될 수 있는 위치를 찾아 삽입까지 진행한다.
+ bisect.insort_right() : 오른쪽에 삽입
```python

import bisect
a = [60, 70, 80, 90]
bisect.insort(a, 85)
print(a) # [60, 70, 80, 85, 90]
```