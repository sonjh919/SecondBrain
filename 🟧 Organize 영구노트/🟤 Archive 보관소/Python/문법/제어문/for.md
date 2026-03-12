---
---
#python 
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


### for-else
+ for에도 else를 쓸 수 있다.
+ break로 중간에 for문을 나가게 되면 else문은 실행되지 않는다.
```python
>>> for x in [1, 2, 3, 4]:
...     if x % 3:
...         print(x)  # x가 3의 배수가 아니면 출력
...     else:
...         break  # x가 3의 배수이면 반복문에서 빠져나감
... else:
...     print("리스트의 원소를 모두 출력했어요")
... 
'''
1
2
'''
```
