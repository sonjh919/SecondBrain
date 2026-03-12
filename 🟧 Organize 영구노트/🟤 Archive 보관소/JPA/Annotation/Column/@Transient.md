#jpa #Annotation 

## @Transient
이 필드는 매핑하지 않는다. 따라서 데이터베이스에 저장하지 않고 조회하지도 않는다. 객체에 임시로 어떤 값을 보관하고 싶을 때 사용한다.

```java
@Transient
private Integer temp;
```