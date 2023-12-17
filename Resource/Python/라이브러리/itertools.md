---
---

### itertools
+ 반복되는 형태의 데이터 처리
+ **순열/조합, 완전탐색 유형**
```python
product() # 순열, 중복 허용
permutations()
combinations()
combinations_with_replacement() # 같은거 2번 꺼내는 조합 포함
```

### product
+ 여러 iterable의 데카르트곱 리턴
```python
from itertools import product  
  
l = list(map(int, input().split()))  
  
for i in product(l,l, repeat=1):  
print(i)
```
``
### permutations
+  iterable에서 원소 개수가 r개인 순열 뽑기
```python
from itertools import permutations  
  
l = list(map(int, input().split()))  
  
for i in permutations(l, 2):  
print(i)
```
### combination
+ iterable에서 원소 개수가 r개인 조합 뽑기
```python
from itertools import combinations  
  
l = list(map(int, input().split()))  
  
for i in combinations(l, 2):  # l에서 순서 상관없이 2개
print(i)
```

### combinations_with_replacement
+  iterable에서 원소 개수가 r개인 중복 조합 뽑기
```python
from itertools import combinations_with_replacement  
  
l = list(map(int, input().split()))  
  
for i in combinations_with_replacement(l, 2):  
print(i)
```
