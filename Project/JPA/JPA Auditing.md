---
title: JPA Auditing
date: 2024-01-20 10:34
categories:
  - JPA
tags:
  - jpa
image: 
path:
---

## JPA Auditing: Timestamped
+ 데이터의 생성(created_at), 수정(modified_at) 시간은 포스팅, 게시글, 댓글 등 다양한 데이터에 매우 자주 활용되지만, 각각의 Entity의 생성 수정 시간을 매번 작성하는건 너무 비효율적이다.
+ Spring Data JPA에서는 시간에 대해서 자동으로 값을 넣어주는 기능인 JPA Auditing을 제공하고 있다.

> `@SpringBootApplication` 이 있는 class에 `@EnableJpaAuditing` 추가!
> JPA Auditing 기능을 사용하겠다는 정보를 전달해주기 위해 `@EnableJpaAuditing` 을 추가해야 한다.
{: .prompt-warning }


## example
```java
@Getter  
@MappedSuperclass  
@EntityListeners(AuditingEntityListener.class)  
public abstract class Timestamped {  
  
    @CreatedDate  
    @Column(updatable = false)  
    @Temporal(TemporalType.TIMESTAMP)  
    private LocalDateTime createdAt;  
  
    @LastModifiedDate  
    @Column    @Temporal(TemporalType.TIMESTAMP)  
    private LocalDateTime modifiedAt;  
}
```
### @MappedSuperclass
+ JPA Entity 클래스들이 해당 추상 클래스를 상속할 경우 createdAt, modifiedAt 처럼 추상 클래스에 선언한 멤버변수를 컬럼으로 인식할 수 있다.

### @EntityListeners(AuditingEntityListener.class)
+ 해당 클래스에 Auditing 기능을 포함시켜 준다.

### @CreatedDate
- Entity 객체가 생성되어 저장될 때 시간이 자동으로 저장된다.
- 최초 생성 시간이 저장되고 그 이후에는 수정되면 안되기 때문에 `updatable = false` 옵션을 추가한다.

### @LastModifiedDate
- 조회한 Entity 객체의 값을 변경할 때 변경된 시간이 자동으로 저장된다.
- 처음 생성 시간이 저장된 이후 변경이 일어날 때마다 해당 변경시간으로 업데이트된다.

### @Temporal
- 날짜 타입(java.util.Date, java.util.Calendar)을 매핑할 때 사용한다.
- DB에는 Date(날짜), Time(시간), Timestamp(날짜와 시간)라는 세 가지 타입이 별도로 존재한다.
    - **DATE : ex) 2023-01-01**
    - **TIME : ex) 20:21:14**
    - **TIMESTAMP : ex) 2023-01-01 20:22:38.771000**