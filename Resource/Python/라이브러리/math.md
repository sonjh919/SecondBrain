---
---
#python 
## math
+ 수학 관련 함수 제공

### 올림 / 내림 / 버림
+ 반올림은 [[내장 라이브러리]]에 round가 있다.
```python
# 올림
math.ceil(3) # 3
math.ceil(3.4) # 4
math.ceil(-3.4) # -3

# 버림
int(-3.4) # -3 실수 -> 정수 형변환은 버림
math.trunc(3) # 3
math.trunc(3.4) # 3
math.trunc(-3.4) # -3 소수점을 그냥 버리는 것

# 내림
math.floor(3) # 3
math.floor(3.4) # 3
math.floor(-3.4) # -4
```
### sqrt
+ 제곱근 구하기
```python
import math
math.sqrt(4) # 2.0
```

### pi, e
```python
math.pi # 3.141592...
math.e # 2.7182818...
```

### log
```python
math.log(math.e) # 1.0
math.log10(10) # 1.0
math.log2(4) # 2
```

### 삼각함수
```python
math.sin(math.pi/2) # 1.0
math.cos(math.pi/2) # 6.123233995736766e-17
```

### 최대공약수(gcd) / 최소공배수(lcm)
```python
import math

math.gcd(21, 14) # 최대공약수
math.lcm(21, 14) # 최소공배수
```

### 팩토리얼
```python
import math

math.factorial(5) # 120

```