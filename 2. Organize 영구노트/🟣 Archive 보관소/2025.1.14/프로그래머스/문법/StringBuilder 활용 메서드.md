#코딩테스트 #Java 

알고리즘에서 자주 사용되는 메서드들의 모음집이다. 개념적인 부분은 [[StringBuffer & StringBuilder]]를 참고하자.


### StringBuilder 생성
```java
StringBuilder sb = new StringBuilder(my_string); 
sb.toString();
```
### 문자열 뒤집기
```java
sb.reverse();
```

### 문자열 추가
```java
sb.append()
```

### 문자열 바꾸기
```java
sb.setCharAt(int index, char ch);
```