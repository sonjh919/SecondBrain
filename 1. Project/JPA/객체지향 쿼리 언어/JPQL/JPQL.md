#jpa 

## JPQL(Java Persistence Query Language)
+ JPQL은 **엔티티 객체를 조회**하는 [[SQL]]을 **추상화**한 객체지향 쿼리 언어이다.
+ 특정 데이터베이스에 의존하지 않는다. 
+ JPQL은 SQL과 문법이 거의 유사하여 그대로 쓸 수 있다. 엔티티 직접 조회, 묵시적 조인, 다형성 지원 등으로 심지어 **SQL보다 간결**하다!
+ JPA는 JPQL을 분석해서 **적절한 SQL을 만들어 DB에서 데이터를 조회**하게 된다.

> [!example]+ 
> SELECT, FROM, WHERE, GROUP BY, HAVING, JOIN 등

> [!tip]+ 
> JPQL은 대소문자를 명확하게 구분한다.
### SQL vs JPQL
+ JPQL은 **엔티티 객체를 대상으로 쿼리**한다. 다시 말해, 클래스와 필드를 대상으로 쿼리한다. **JPQL은 데이터베이스 테이블을 전혀 알지 못한다.**
+ SQL은 데이터베이스 테이블을 대상으로 쿼리한다.

