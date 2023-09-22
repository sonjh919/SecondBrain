### for
```python
for 변수 in 리스트(또는 튜플, 문자열):
    수행할_문장1
    수행할_문장2
    ...

>>> test_list = ['one', 'two', 'three'] 
>>> for i in test_list: 
...     print(i)
... 
one 
two 
three

>>> a = [(1,2), (3,4), (5,6)]
>>> for (first, last) in a:
...     print(first + last)
...
3
7
11

>>> add = 0 
>>> for i in range(1, 11):  # 끝 숫자는 포함되지 않음
...     add = add + i 
... 
>>> print(add)
55

marks = [90, 25, 67, 45, 80]
for number in range(len(marks)):
    if marks[number] < 60: 
        continue
    print("%d번 학생 축하합니다. 합격입니다." % (number+1))
```

### List Comprehension

- [[리스트]] 안에 for문을 포함하여 작성할 수 있다.

```python
[표현식 for 항목1 in 반복_가능_객체1 if 조건문1
      for 항목2 in 반복_가능_객체2 if 조건문2
      ...
      for 항목n in 반복_가능_객체n if 조건문n]

>>> result = [x*y for x in range(2,10)  # 구구단
...               for y in range(1,10)]
```


