---
---
#python 

+ [[집합]]으로 변환 후 집합 연산을 적용하고 다시 [[리스트]]로 변환한다.
### 합집합
```python
lst1 = ['A','B','C','D'] lst2 = ['C','D','E','F'] # 합집합 
union = list(set(lst1) | set(lst2)) print( union )
# ['C', 'F', 'A', 'E', 'B', 'D']
union = list(set().union(lst1,lst2)) print( union )
# ['C', 'F', 'A', 'E', 'B', 'D']
```

### 교집합
```python
lst1 = ['A','B','C','D'] lst2 = ['C','D','E','F'] # 교집합
intersection = list(set(lst1) & set(lst2)) print( intersection )
# ['C', 'D']
intersection = list(set(lst1).intersection(lst2)) print( intersection )
# ['C', 'D']
```

### 차집합
```python
lst1 = ['A','B','C','D'] lst2 = ['C','D','E','F'] # 차집합
complement = list(set(lst1) - set(lst2)) print( complement )
# ['B', 'A']
complement = list(set(lst1).difference(lst2)) print( complement )
# ['A', 'B']
```

### 대칭차집합
```python
lst1 = ['A','B','C','D'] lst2 = ['C','D','E','F'] # 대칭차집합
sym_diff = list(set(lst1) ^ set(lst2)) print( sym_diff )
# ['F', 'E', 'A', 'B']
sym_diff = list(set(lst1).symmetric_difference(lst2)) print( sym_diff )
# ['F', 'E', 'A', 'B']
```