---
---
#python 
### TypeError: list indices must be integers or slices, not str

**Why**

- 리스트의 인덱스를 정수형이 아닌 문자열으로 사용했다.
- 주로 리스트를 for in 반복문에서 사용할 때 발생한다.

**Soln**

- range와 len을 활용하여 인덱스가 정수형이 되게 바꾸자

```python
ex_list = ['a', 'b', 'c', 'd', 'e']
  
# Error
for i in ex_list:
  print(ex_list[i])

# Solution
for i in range(len(ex_list)):
  print(ex_list[i])
```