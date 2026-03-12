#jpa #Annotation 

## @ElementCollection
엔티티 클래스 내의 컬렉션을 매핑할 때 사용된다. 이 컬렉션에는 기본 타입(primitive types)이나 값 타입의 요소들이 포함된다. [[@CollectionTable]]과 함께 쓰인다.

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