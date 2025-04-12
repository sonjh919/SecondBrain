#jpa #Annotation 

## @SecondaryTable
+ 잘 사용하지는 않지만 한 엔티티에 여러 테이블을 매핑할 수 있다.
+ 더 많은 테이블을 매핑하려면 @SecondaryTables를 사용한다.

![[secondarytable.png]]

```java
@Entity  
@SecondaryTable(name = "BOARD_DETAIL", // 매핑할 테이블   
pkJoinColumns = @PrimaryKeyJoinColumn(name = "BOARD_DETAIL_ID")) // 매핑할 외래키  
public class Board {  
    @Id  
    @GeneratedValue  
    @Column(name = "BOARD_ID")  
    private long id;  
  
    @Column(name = "title")  
    private String title;  
  
    @Column(table = "BOARD_DETAIL", name = "content") // BOARD_DETAIL 테이블의 컬럼을 매핑  
    private String content;  
}
```

> [!caution]+ 
> @SecondaryTable은 항상 두 테이블을 조회하므로 최적화하기 어렵다. 반면 [[일대일]] 매핑은 원하는 부분만 조회할 수 있고 필요하면 둘을 함께 조회하기 때문에 일대일 매핑하는것을 권장한다.