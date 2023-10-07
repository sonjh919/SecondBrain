### while

```python
while 조건문:
    수행할_문장1 continue # 위로
    수행할_문장2
    수행할_문장3 break # 끝
    ...
```

### while-else
+ while에 else를 쓸 수 있다.
+ break로 중간에 while문을 나가게 되면 else문은 실행되지 않는다.
```python
>>> countdown = 5
>>> while countdown > 0:
...     print(countdown)
...     countdown -= 1
...     if input() == '중단':
...         break
... else:
...     print('발사!')
... 
'''
5
4
3
중단
'''

```