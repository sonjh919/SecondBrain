#jpa #JPQL

## SELECT
> [!example]+ 
> ```java
SELECT m FROM Member AS m WHERE m.username = 'Hello'

## 특징
### 1. 대소문자 구분
엔티티와 속성은 대소문자를 구분하지만, JPQL 키워드는 대소문자를 구분하지 않는다.

> [!example]+ 
> + Member, username : 대소문자 구분
> + SELECT, FRAM, AS 등 : 대소문자 구분 X

### 2. 엔티티 이름
JPQL에서 사용한 Member는 클래스 명이 아니라 **엔티티 명**이다. 엔티티 명은 [[@Entity]]에서 name 속성으로 지정할 수 있다. 기본값으로 사용하는 것이 좋다.

### 3. 별칭([[Alias]])은 필수
JPQL은 별칭을 필수로 사용해야 한다. 따라서 코드를 별칭 없이 작성하면 잘못된 문법이라는 오류가 발생한다.

> [!note]+ 
> 사실 JPA 표준 명세는 별칭을 **식별 변수(Identification variable)** 라는 용어로 정의했다. 하지만 별칭이 더 익숙하다..

> [!tip]+ 
> `AS`는 생략 가능하다.

> [!info]+ HQL
> 하이버네이트는 JPQL 표준도 지원하지만 더 많은 기능을 가진 **HQL(Hibernate Query Language)** 를 제공한다. JPA 구현체로 하이버네이트를 사용하면 HQL도 사용할 수 있다. HQL은 별칭 없이도 사용 가능하다.