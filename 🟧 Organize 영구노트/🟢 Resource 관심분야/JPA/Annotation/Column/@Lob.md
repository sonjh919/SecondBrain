#jpa #Annotation 

## @Lob
데이터베이스의 BLOB, CLOB 타입과 매핑한다. 매핑하는 필드 타입이 문자면 CLOB으로 매핑하고 나머지는 BLOB으로 매핑한다.

> [!note]+ 
> 
> CLOB : String, char[], java.sql.CLOB
> BLOB : byte[], java.sql.BLOB

```java
@Lob
private String lobString;
```