### List Comprehension

- [[리스트]] 안에 for문을 포함하여 작성할 수 있다.

```python
result = [x*y for x in range(2,10)  # 구구단
              for y in range(1,10)]

point = [[row for row in range(9)] for col in range(9)] # 이중 격자
```

+ range를 넣을 수도 있다.
```python
l = list(range(10))
# 0 1 2 3 4 5 6 7 8 9
```