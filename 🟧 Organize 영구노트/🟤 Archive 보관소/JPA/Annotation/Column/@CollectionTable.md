#jpa #Annotation 

## @CollectionTable
매핑할 컬렉션의 테이블을 지정할 때 사용된다. [[@ElementCollection]]을 사용하여 매핑된 컬렉션은 기본적으로 매핑된 엔티티의 테이블이 아니라 별도의 테이블에 매핑된다. 이 별도의 테이블을 지정하기 위해 `@CollectionTable`을 사용한다.

```java
@Entity
public class Member {
    ...
    @ElementCollection
    @CollectionTable(
        name = "FAVORITE_FOODS",
        joinColumns = @JoinColumn(name = "MEMBER_ID"))
    @Column(name = "FOOD_NAME") // 컬럼명 지정 (예외)
    private Set<String> favoriteFoods = new HashSet<>();

    @ElementCollection
    @CollectionTable(
        name = "ADDRESS",
        joinColumns = @JoinColumn(name = "MEMBER_ID"))
    private List<Address> addressHistory = new ArrayList<>();
    ...
}
```

> [!info]+ 
> @CollectionTable을 생략하면 기본값을 사용해서 매핑한다.
> 
> **기본값**
> {엔티티이름}_{컬렉션 속성 이름}