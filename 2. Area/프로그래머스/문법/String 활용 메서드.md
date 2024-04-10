#코딩테스트  #Java 

알고리즘에서 자주 사용되는 메서드들의 모음집이다. 개념적인 부분은 [[2. Area/Java API/java.lang/String]]을 참고하자.

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

### 문자열 포함 확인
```java
String str1; String str2;
str1.contains(str2);
```

### 문자열 비교
```java
String str1; String str2;
str1.equals(str2);
```

### 문자열을 배열처럼
split을 사용하면 문자열을 배열처럼 사용할 수 있다.
나중에 join을 사용해 다시 합치면 된다.

```java
String[] str = rsp.split("");

for(int i = 0; i < str.length; i++) {
	System.out.println(str[i]);
}

String.join("",str);

```

### 문자열 덧셈
문자열에서 뒤에 문자열을 추가하고 싶다면 + 연산자를 쓸 수 있다.
```java
String answer = "";
answer += "a";
```