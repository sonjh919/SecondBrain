#jpa #Annotation 

## @Modifying
Spring Data JPA에서 벌크성 수정, 삭제 쿼리는 @Modifying 어노테이션을 이용한다.

```java
@Modifying
@Query("update Product p set p.pirce = p.price * 1.1
	   where p.stockAmount < :stockAmount";)
int bulkPriceUp(@Param("stockAmount") String stockAmount)
```

## 속성
> [!note]+ clearAutoMatically
> true : 벌크성 쿼리를 실행하고 나서 영속성 컨텍스트를 초기화하고 싶을 때 사용
> 
> **기본값**
> false