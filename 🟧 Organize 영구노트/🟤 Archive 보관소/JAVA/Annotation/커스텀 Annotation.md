#Java 

```java
@interface 애너테이션이름 {
	타입 요소이름();
	...
}
```

### annotation 요소
+ 반환값이 있고 매개변수는 없는 추상 메서드의 형태를 가지며, 상속을 통해 구현하지 않아도 된다.
+ 다만, 애너테이션을 적용할 때 이 요소들의 값을 빠짐없이 지정해주어야 한다.
+ 순서는 상관없다.

```java
@interface TestInfo {
	int count();
	String testedBy();
	String[] testTools();
	TestType testType(); // enum TestType {FIRST, FINAL}
	DateTime testDate(); // 자신이 아닌 다른 annotation(@DateTime) 포함 가능
}

@interface DateTime {
	String yymmdd();
	String hmmss();
}
```

```java
@TestInfo(
	count = 3, testedBy="Kim",
	testTools = {"JUnit", "AuteTester"},
	testType = TestType.FIRST,
	testDate = @DateTime(yymmdd = "160101", hhmmss = "235959")
)
public class NewClass {...}
```