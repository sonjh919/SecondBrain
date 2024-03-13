#jpa #Annotation 

## @Lock
```java
@Lock(LockModeType.PESSIMISTIC_WRITE)
List<Member> findByName(String name);
```