---
---

### '구분자'.join(리스트)
매개변수로 들어온 리스트의 요소를 모두 합쳐 하나의 문자열로 바꾸어 반환한다.

```python
l = ['a', 'b', 'c']  
print(" + ".join(l)) # 'a + b + C'
print("".join(l)) # 'abc'
```

리스트가 문자가 아닐 경우 [[Comprehension]]을 이용할 수 도 있다.
```python
l = [1, 2, 3]
" + ".join(str(i) for i in l)
```

+ 반대로는 split함수가 있다.