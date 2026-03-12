#jpa #Annotation 


## @PrimaryKeyJoinColumn
[[상속 관계 매핑]]에서 기본값으로 자식 테이블은 부모 테이블의 ID 컬럼명을 그대로 사용하는데, 만약 자식 테이블의 기본 키 컬럼명을 변경하고 싶을 때 사용한다.

```java
```java
@Entity
@DiscriminatorValue("ALBUM")
@PrimaryKeyJoinColumn(name = "ALBUM_ID")
public class Album extends Item {
	
    private String artist;
}
```
```