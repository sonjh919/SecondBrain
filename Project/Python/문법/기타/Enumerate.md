### Enumerate()
+ 주어진 입력을 컬렉션 또는 [[튜플]]로 가져와 열거(Enumerate) 객체로 반환한다.
+ [[for]]문에서 유용하게 쓰인다.

```python
>>> for entry in enumerate(['A', 'B', 'C']):
...     print(entry)
...
(0, 'A')
(1, 'B')
(2, 'C')
```

+ 인자 풀기(unpacking)을 통해 각각 다른 변수에 할당할 수  있다.
```python
>>> for i,n in enumerate(['A', 'B', 'C']):
...     print(i,n)
...
0 'A'
1 'B'
2 'C'
```

+ 시작 인덱스 변경
```python
>>> for i, letter in enumerate(['A', 'B', 'C'], start=1):
...     print(i, letter)
...
1 A
2 B
3 C
```

+ 2차원 리스트 loop에서 활용하면 더 깔끔하게 코드를 작성할 수 있다.

```python
for r, row in enumerate(matrix):
...     for c, letter in enumerate(row):
...             print(r, c, letter)
```