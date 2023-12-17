---
---

### TypeError: sequence item 0: expected str instance, int found

**Why**

- join을 시도할 때 list의 요소가 string이여야 하나 int이여서 join이 되지 않는다.

**Soln**

- map을 활용하여 요소를 string으로 명시적 형변환을 해주자.

```python
ex_list = [1, 2, 3, 4, 5]

# Error
res = ''join(ex_list)

# Solution
res = ''.join(map(str, ex_list))
```