#jpa #JPQL

## FETCH JOIN
JPQL에서는 성능 최적화를 위해 SQL에는 없는 FETCH JOIN을 지원한다. **연관된 엔티티나 컬렉션을 한 번에 같이 조회**하는 기능으로, `JOIN FETCH` 명령어로 사용 가능하다.

+ JPA 표준 명세에 정의된 문법은 다음과 같다.
```java
페치 조인 ::= [ LEFT [OUTER] | INNER ] JOIN FETCH 조인경로
```

> [!caution]+ 
> FETCH JOIN은 별칭([[Alias]])을 사용할 수 없다.
### 엔티티 FETCH JOIN
FETCH JOIN을 사용해서 연관된 엔티티를 같이 조회하는 JPQL을 작성할 수 있다.

```sql
SELECT m
  FROM Member m JOIN FETCH m.team
```