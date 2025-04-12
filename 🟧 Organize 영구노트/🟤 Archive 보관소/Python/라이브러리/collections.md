---
---
#python 
### collections
+ **덱(deque), 카운터(Counter)** 등의 자료구조를 포함한다.
```python
# counter : 내부의 원소가 몇번씩 등장했는지 알려준다. 
from collections import Counter
counter = Counter(['red', 'blue', 'red', 'greed', 'blue', 'blue'])

print(counter['blue'])
print(dict(counter)) ## 딕셔너리 변환
```