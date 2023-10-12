
### IndexError: list assignment index out of range

**Why**

- 빈 리스트에 인덱스를 지정했다.

**Soln**

- append()로 넣거나, 길이만큼의 리스트를 미리 만들어둔다.

```python
# error
a = []
a[1] = 1

# sol
# 1. list를 미리 지정
a = [0,0]
a = [0 for i in range(n)] # list comprehension
a[1] = 1

# 2. append 또는 insert 사용
a = []
a.append('hi') 
a.insert(1, 'hi') # 인덱스 지정 가능

```