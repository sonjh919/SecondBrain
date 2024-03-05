#jpa #Annotation 

## @Column
필드를 컬럼에 매핑한다. 만약 어노테이션을 생략하면 **필드명을 사용**하여 컬럼명으로 매핑한다.

```java
@Column(name = "NAME")
private String username;
```

## 속성
### name
필드를 컬럼에 매핑한다.
