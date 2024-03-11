#jpa #JPQL 

## 쿼리의 종류
JPQL 쿼리는 크게 동적 쿼리와 정적 쿼리로 나눌 수 있다.

### 동적 쿼리
+ em.createQuery("select...")처럼 **JPQL을 문자로 완성해서 직접 넘기는 것**
+ 런타임에 특정 조건에 따라 JPQL을 동적으로 구성할 수 있다.

### 정적 쿼리
+ 미리 정의한 쿼리에 이름을 부여해서 필요할 때 사용할 수 있는데, 이것을 **Named 쿼리**라 한다.
+ 한 번 정의하면 변경할 수 없는 정적인 쿼리이다.

> [!note]+ Named쿼리
> + 어플리케이션 로딩 시점에 JPQL 문법을 체크하고 미리 파싱해둔다.
> + 오류를 빨리 확인할 수 있고, 사용 시점에 파싱된 결과를 재사용하므로 성능상 이점이 있다.
> + 변하지 않는 정적 SQL이 생성되므로 데이터베이스 조회 성능 최적화에 도움된다.
> + @NamedQuery를 이용하여 자바 코드에 작성하거나 XML 문서에 작성할 수 있다

## Named 쿼리 : 정적 쿼리
### 자바 코드로 작성
+ [[@NamedQuery]] 참고

### XML 문서에 작성
+ JPA에서 어노테이션으로 작성할 수 있는 것은 XML로도 작성할 수 있다
+ application.properties에 정의하여 사용

```xml
  // META-INF/ormMember.xml
  <?xml version="1.0" encoding="UTF-8"?>
  <entity-mappings xmlns="http://java.sun.com/xml/ns/persistence/orm" version="2.1">
      <named-query name="Member.findByUsername">
          <query><CDATA[
              select m
              from Member m
              where m.username = :username
          ]</query>
      </named-query>

      <named-query name="Member.count">
          <query>select count(m) from Member m</query>
      </named-query>
  </entity-mappings>

  // persistence.xml
  <persistence-unit name="jpabook">
   <mapping-file>META-INF/ormMember.xml</mapping-file>
   ...
```

> [!tip]+ 
> XML과 어노테이션에 같은 설정이 있는 경우 XML이 우선권을 가진다.