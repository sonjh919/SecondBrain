---
title: Entity
date: 2024-01-19 15:46
categories:
  - JPA
tags:
  - jpa
image: 
path:
---

## Entity
+ JPA에서 엔티티란 **DB 테이블에 대응하는 하나의 클래스**라고 생각하면 된다. 
+ @Entity 가 붙은 클래스는 JPA가 관리하며 DB의 테이블과 자바 클래스가 매핑이 된다.

## Entity 예시
```java
@Entity // JPA가 관리할 수 있는 Entity 클래스 지정
@Table(name = "memo") // 매핑할 테이블의 이름을 지정
public class Memo {
    @Id
    private Long id;

    // nullable: null 허용 여부
    // unique: 중복 허용 여부 (false 일때 중복 허용)
    @Column(name = "username", nullable = false, unique = true)
    private String username;

    // length: 컬럼 길이 지정
    @Column(name = "contents", nullable = false, length = 500)
    private String contents;
}
```


## Annotation
### @Entity
+ @Entity(name = "Memo") : JPA가 관리할 수 있는 Entity 클래스로 지정할 수 있다. (default: 클래스명)
+ JPA가 Entity 클래스를 인스턴스화 할 때 **기본 생성자를 사용**하기 때문에 반드시 현재 Entity 클래스에서 기본 생성자가 생성되고 있는지 확인해야 한다.

### @Table
+ @Table(name = "memo") : 매핑할 테이블의 이름을 지정할 수 있다. (default: Entity 명)

### @Column
- **@Column(name = "username") :** 필드와 매핑할 테이블의 컬럼을 지정할 수 있다. (default: 객체의 필드명)
- **@Column(nullable = false) :** 데이터의 null 값 허용 여부를 지정할 수 있다. (default: true)
- **@Column(unique = true) :** 데이터의 중복 값 허용 여부를 지정할 수 있다. (default: false)
- **@Column(length = 500) :** 데이터 값(문자)의 길이에 제약조건을 걸 수 있다. (default: 255)

### @Id
- 이 기본 키는 영속성 컨텍스트에서 Entity를 구분하고 관리할 때 사용되는 **식별자** 역할을 수행한다.
- 따라서 기본 키 즉, 식별자 값을 넣어주지 않고 저장하면 오류가 발생한다.

### @GeneratedValue
- **@Id** 옵션만 설정하면 기본 키 값을 개발자가 직접 확인하고 넣어줘야 하는 불편함이 발생하는데, 이 옵션을 이용하면 기본 키 생성을 DB에 위임할 수 있다.

#### IDENTITY 전략
- `id bigint not null auto_increment` : **auto_increment** 조건이 추가된 것을 확인할 수 있다.
- 해당 옵션을 추가해주면 개발자가 직접 id 값을 넣어주지 않아도 자동으로 순서에 맞게 기본 키가 추가된다.

```java
@GeneratedValue(strategy = GenerationType.IDENTITY)
```

