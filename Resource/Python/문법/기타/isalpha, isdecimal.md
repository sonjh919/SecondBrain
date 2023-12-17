---
---

### isalpha
+ [[문자열]]의 구성이 **알파벳으로만** 이루어져 있으면 True를 반환
```python
Ex1 = 'A'
Ex2 = 'ABC'
Ex3 = "앱피아"
Ex4 = "Hello Appia"
Ex5 = "100Appia"


print(Ex1.isalpha()) # True
print(Ex2.isalpha()) # True
print(Ex3.isalpha()) # True
print(Ex4.isalpha()) # False
print(Ex5.isalpha()) # False
```

### isdecimal
+ 주어진 문자열이 [[숫자형]]인지(**int형으로 변환이 가능**)하면 True를 반환
```python
EX = '12321'
print(EX.isdecimal()) # True
```