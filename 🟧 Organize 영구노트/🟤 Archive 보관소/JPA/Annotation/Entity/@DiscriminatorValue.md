#jpa #Annotation 


## @DiscriminatorValue
엔티티를 저장할 때 구분 컬럼에 입력할 값을 지정한다. [[@DiscriminatorColumn]]의 구분컬럼에 따라 속성값이 저장된다.

```java
@Entity
@DiscriminatorValue("ALBUM")
public class Album extends Item {
	
    private String artist;
}
```