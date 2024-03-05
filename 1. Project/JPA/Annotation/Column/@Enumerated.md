#jpa #Annotation 

## @Enumerated
Java의 [[enum]] 타입을 매핑할 때 사용한다.

```java
enum RoleType{
	ADMIN, USER
}
```

```java
@Enumerated(EnumType.String)
private RoleType roleType;
```
## 속성
+ ORDINAL은 데이터 크기가 작지만 순서가 바뀔 시 값이 달라질 수 있으니 STRING을 사용하자.

> [!note]+ value
> EnumType.ORDINAL : enum **순서**를 데이터베이스에 저장(순서대로 0,1...로 저장)
> EnumType.STRING : enum **이름**을 데이터베이스에 저장(문자 자체가 저장)
> 
> **기본값**
> EnumType.ORDINAL
> 