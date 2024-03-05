#jpa #Annotation 

## @Column
필드를 컬럼에 매핑한다. 만약 어노테이션을 생략하면 **필드명을 사용**하여 컬럼명으로 매핑한다.

```java
@Column(name = "NAME")
private String username;
```

## 속성
> [!note]+ name
> JPA에서 사용할 엔티티 이름을 지정한다. 자바 언어는 관례상 Camel 표기법을 주로 사용하지만, DB는 관례상 언더스코어(\_)를 주로 사용한다. 따라서 name을 명시적으로 사용하여 이름을 지어주자.

> [!tip]+ 
> hivbernate의 naming_strategy 속성을 사용하여 자동으로 이름 매핑 전략을 변경할 수 있다.
> 참고 : [[DB 스키마 자동 생성]]

> [!note]+ nullable
> not null 제약조건을 추가한다.

> [!note]+ length
> 문자의 최대 크기를 지정할 수 있다.