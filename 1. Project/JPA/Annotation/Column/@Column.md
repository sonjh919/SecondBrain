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
> 
> **기본값**
> 객체의 필드 이름

> [!tip]+ 
> hivbernate의 naming_strategy 속성을 사용하여 자동으로 이름 매핑 전략을 변경할 수 있다.
> 참고 : [[DB 스키마 자동 생성]]

> [!note]+ nullable
> not null 제약조건을 추가한다. 
> 
> **기본값**
> @Column 어노테이션 자체를 생략 할 시 nullable=true가 기본으로 지정된다.

> [!note]+ length
> 문자 길이에 대한 제약조건을 걸 수 있다.

> [!note]+ unique
> 한 컬럼에 unique 제약조건을 걸 때 사용한다.

> [!note]+ precision, scale
> BigDecimal 타입에서 사용한다. double이나 float는 적용되지 않으며, 아주 큰 숫자나 정밀한 소수를 다룰 때 사용한다.
> 
> precision : 소수점을 포함한 전체 자릿수
> scale : 소수의 자릿수
> 
> 