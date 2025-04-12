---
---
#python 
### Enumerate()
+ 주어진 입력을 컬렉션 또는 [[튜플]]로 가져와 열거(Enumerate) 객체로 반환한다.
+ [[🟢 Resource/Python/문법/제어문/for]]문에서 유용하게 쓰인다.

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

+ enumerate와 2차원 list에서 list의 범위 정하기
```python
for row in range(N-7):  
	for col in range(M-7):
	
		for r,x in enumerate(l[row:row+8]):  
			for c,y in enumerate(x[col:col+8]):
				print(r, c, y)
```

+ list 거꾸로 출력하기
```python
for c,x in reversed(list(enumerate(row))):  
	print(x, end=' ')
```

+ enumerate를 쓰면서 범위 정하기
```python
for i,x in enumerate(l[:len(l)-1]):
	print(x)
```