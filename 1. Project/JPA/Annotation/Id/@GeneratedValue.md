#jpa #Annotation 

## 기본 키 생성 전략
JPA가 제공하는 데이터베이스 기본 키 생성 전략은 다음과 같다.

### 직접 할당
기본 키를 어플리케이션에 직접 할당한다.

### 자동 생성
대리 키 사용 방식

> [!note]+ 자동 생성
> - IDENTITY : 기본 키 생성을 데이터베이스에 위임한다.
> - SEQUENCE : 데이터베이스 시퀀스를 이용하여 기본 키를 할당한다.
> - TABLE : 키 생성 테이블을 이용한다.
> 
> 

> [!caution]+ 
> 키 생성 전략을 사용하기 위해서는 hibernate.id.neew_generator_mappings=true 속성을 추가해야 한다.

> [!check]+ 
> [[복합 키]]에는 @GeneratedValue를 사용할 수 없다. 복합 키를 구성하는 여러 컬럼 중 하나에도 사용할 수 없다.
## 1. IDENTITY
기본 키 생성을 데이터베이스에 위임하는 전략이다. 예를 들어 MySQL의 AUTO_INCREMENT 기능은 데이터베이스가 기본 키를 자동으로 생성해준다.

> [!example]+ 
> MySQL, PostgreSQL, SQL Server, DB2 등

```
@Entity
@Table(name="MEMBER")
public class Member {
	@id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
}
```

> [!tip]+ 
> IDENTITY 전략은 **데이터를 DB에 INSERT한 후에 기본 키 값을 조회**할 수 있다. 따라서 엔티티에 식별자 값을 할당하기 위해서 JPA는 추가로 DB를 조회해야 한다. JDBC3에 추가된 Statement.getGeneratedKeys()를 이용하면 데이터 저장과 동시에 기본 키 값도 얻어올 수 있다. 이때 하이버네이트는 DB와 한 번만 통신한다.

> [!caution]+ 
> 엔티티가 영속 상태가 되려면 식별자가 반드시 필요한데, IDENTITY 전략은 엔티티를 저장해야 식별자를 구할 수 있으므로 [[쓰기 지연 저장소|쓰기 지연]]에서 동작하지 않는다.


## 2. SEQUENCE
유일한 값을 순서대로 생성하는 특별한 데이터베이스 오브젝트이다. IDENTITY와 전략은 같으나 내부 동작 방식은 다른다. SEQUENCE 전략은 먼저 데이터베이스 시퀀스를 이용하여 식별자를 조회한 후 조회한 식별자를 엔티티에 할당한 후 엔티티를 영속성 컨텍스트에 저장한다.

@SequenceGenerator를 이용하여 엔티티별로 시퀀스를 별도로 관리할 수 있다.

> [!example]+ 
> Oracle, PostgreSQL, DB2, H2

```
@Entity
@Table(name="MEMBER")
public class Member {
	@id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, 
	generator = "MEMBER_SEQ_GENERATOR)
	private String id;
}
```

## 3. TABLE
TABLE 전략은 키 생성 전용 테이블을 하나 만들고 이름과 값으로 사용할 컬럼을 만들어 데이터베이스 시퀀스를 흉내내는 전략이다. 테이블을 사용하므로 모든 데이터베이스에 적용할 수 있다.

키 생성 용도의 테이블을 만들고, @TableGenerator를 사용하여 테이블 키 생성기를 등록할 수 있다.

## 4. AUTO
AUTO 전략은 선택한 [[데이터베이스 방언]]에 따라 IDENTITY, SEQUENCE, TABLE 전략 중 하나를 자동으로 선택한다. @Generated의 기본값은 AUTO이기 때문에 생략 가능하다.

```java
@Entity
@Table(name="MEMBER")
public class Member {
	@id @GeneratedValue
	private String id;
}
```

> [!example]+ 
> Oracle을 선택하면 SEQUENCE를, MySQL을 선택하면 IDENTITY를 사용한다.