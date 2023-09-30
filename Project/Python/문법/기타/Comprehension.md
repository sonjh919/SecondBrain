### List Comprehension

- [[리스트]] 안에 for문을 포함하여 작성할 수 있다.

```python
result = [x*y for x in range(2,10)  # 구구단
              for y in range(1,10)]

point = [[row for row in range(9)] for col in range(9)] # 이중 격자
```
