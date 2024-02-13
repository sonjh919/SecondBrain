#프로그래머스 #Java 

알고리즘에서 자주 사용되는 메서드들의 모음집이다. 개념적인 부분은 [[String]]을 참고하자.

### 문자열 바꾸기
```java
String res = str.replaceAll("a", ""); // regex, replacement
```

### index로 접근하기
```java
for (int i = 0; i < str.length(); i++) {  
    System.out.println(str.charAt(i)); 
}
```