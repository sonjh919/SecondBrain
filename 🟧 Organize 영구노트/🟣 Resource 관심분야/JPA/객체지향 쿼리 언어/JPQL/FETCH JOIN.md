#jpa #JPQL

## FETCH JOIN
JPA에서는 기본적으로 [[지연 로딩]] 전략을 사용한다. 이 때, [[N+1 문제]]가 발생할 수 있다. 이를 해결하기 위한 방법 중 하나로 **처음 조회부터 JOIN시켜 데이터를 가져오는 것을 목적**으로 FETCH JOIN이 만들어지게 되었다.

JPQL에서는 성능 최적화를 위해 SQL에는 없는 FETCH JOIN을 지원한다. **연관된 엔티티나 컬렉션을 한 번에 같이 조회**하는 기능으로, `JOIN FETCH` 명령어로 사용 가능하다.

+ JPA 표준 명세에 정의된 문법은 다음과 같다.
```java
페치 조인 ::= [ LEFT [OUTER] | INNER ] JOIN FETCH 조인경로
```

> [!caution]+ 
> + FETCH JOIN은 별칭([[Alias]])을 사용할 수 없다.
> + 하지만 하이버네이트는 FETCH JOIN에도 별칭을 허용한다.
### 엔티티 FETCH JOIN
FETCH JOIN을 사용해서 연관된 엔티티를 같이 조회하는 JPQL을 작성할 수 있다.

```sql
-- JPQL
SELECT m
  FROM Member m JOIN FETCH m.team -- Member 엔티티와 Team 엔티티 같이 조회

-- SQL
SELECT M.*, T.*
  FROM MEMBER T
INNER JOIN MEAN T ON M.TEAM_ID=T.ID
```

![[Entityfetchjoin.png]]

FETCH JOIN을 사용하여 함께 조회했으므로 연관된 엔티티는 [[프록시]]가 아닌 실제 엔티티다. 따라서 **지연 로딩이 일어나지 않는다.** 또한 실제 엔티티이므로 [[영속성 컨텍스트]]에서 분리되어 준영속 상태가 되어도 연관된 엔티티를 조회할 수 있다.

### 컬렉션 FETCH JOIN
[[일대다]] 관계인 컬렉션도 FETCH JOIN할 수 있다.

```sql
--JPQL
SELECT t
  FROM Team t JOIN FETCH t.members
   WHERE t.name = '팀A'

--SQL
SELECT T.*, M.*
  FROM TEAM T
INNER JOIN MEMBER M ON T.ID=M.TEAM_ID
WHERE T.NAME = '팀A'
```

![[COLLECTIONFETCHJOIN.png]]

> [!tip]+ 
> 일대다 JOIN은 결과가 증가할 수 있지만 일대일, 다대일 JOIN은 결과가 증가하지 않는다.


## FETCH JOIN과 DISTINCT
SQL의 DISTINCT는 중복된 결과를 제거하는 명령이다. JPQL의 DISTINCT는 SQL의 DISTINCT를 추가하고 어플리케이션에서 **한 번 더 중복을 제거**한다.

> [!note]+ 
> 직전의 컬렉션 FETCH JOIN의 쿼리에 DISTINCT를 추가해도 각 로우의 데이터가 다르므로 SQL에서는 효과가 없다. 어플리케이션에서는 팀 엔티티인 팀A를 중복으로 보고 하나만 조회하게 된다.
> 
> ```sql
> SELECT DISTINCT t -- 엔티티의 중복 제거
>   FROM Team t JOIN FETCH t.members
>  WHERE t.name = '팀A'
> ```

![[FETCHJOINDISTINCT.png]]

## FETCH JOIN VS 일반 JOIN
JPQL은 결과를 반환할 때 **연관관계까지 고려하지 않는다.** 단지 **SELECT 절에 지정한 엔티티만 조회**한다. 하지만 FETCH JOIN을 사용한다면 연관된 엔티티도 함께 조회한다.

> [!question]+ 일반 JOIN
> + [[지연 로딩]]으로 설정 시 [[프록시]]나 아직 초기화하지 않은 [[컬렉션 래퍼]] 반환
> + 즉시 로딩으로 설정 시 쿼리를 한번 더 실행

## FETCH JOIN의 특징과 한계
> [!note]+ 특징
> + SQL 한 번으로 연관된 엔티티들을 함께 조회할 수 있어서 SQL 호출 횟수를 줄여 성능을 최적화 할 수 있다
> + 엔티티에 직접 적용하는 로딩 전략은 애플리케이션 전체에 영향을 미치므로 글로벌 로딩 전략이라 부른다. FETCH JOIN은 글로벌 로딩 전략보다 우선시한다.
> + **글로벌 로딩 전략은 될 수 있으면 지연 로딩을 사용하고 최적화가 필요하면 FETCH JOIN을 적용하는 것이 효과적**
> + 연관된 엔티티를 쿼리 시점에 조회하므로 준영속 상태에서도 객체 그래프 탐색 가능

> [!info]+ 글로벌 로딩 전략
> `@OneToMany(fetch = FetchType.Lazy) // 글로벌 로딩 전략`
> 
> 참고 : [[@OneToMany]], [[지연 로딩]]

> [!note]+ 한계
> + FETCH JOIN 대상에는 별칭을 줄 수 없다. 하이버네이트에서는 가능하지만 연관된 데이터 수가 달라져 데이터 무결성이 깨질 수 있다.
> + 둘 이상의 컬렉션을 FETCH할 수 없다. 컬렉션 * 컬렉션의 카테시안 곱이 만들어지므로 주의. 하이버네이트에서는 예외 발생(PersistenceException)
> + 컬렉션 페치 조인시 [[페이징]] API(setFirstResult, setMaxResults)를 사용할 수 없다.
> + 단일 값 연관 필드([[일대일]], [[다대일]])들은 페치 조인을 사용해도 페이징 API를 사용할 수 있다.
> + 하이버네이트에서 컬렉션을 페치 조인 하고 페이징 API를 사용하면 메모리에서 페이징 처리를 한다. 성능 이슈와 메모리 초과 예외가 발생할 수 있어 위험하다.

## FETCH JOIN 사용법
FETCH JOIN은 SQL 한 번으로 연관된 여러 엔티티를 조회할 수 있어 **성능 최적화**에 상당히 유용하다. 하지만 모든 것을 FETCH JOIN으로 해결할 수는 없다. 

> [!important]+ 
> FETCH JOIN은 **객체 그래프 모양을 유지**할 때 사용하면 효과적이다. 반면에 여러 테이블을 JOIN하여 엔티티가 가진 모양이 아닌 전혀 다른 결과를 내야 한다면 여러 테이블에서 필요한 필드들만 조회해서 DTO로 반환하는 것이 더 효과적이다.