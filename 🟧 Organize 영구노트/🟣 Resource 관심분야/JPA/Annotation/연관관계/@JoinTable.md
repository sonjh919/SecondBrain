#jpa #Annotation 

## @JoinTable
조인 테이블로 [[연관관계 설계]]를 했을 경우 쓰인다.

## 속성
> [!note]+ name
> 매핑할 조인 테이블 이름

> [!note]+ joinColumns
> 현재 엔티티를 참조하는 외래 키

> [!note]+ inverseJoinColumns
> 반대방향 엔티티를 참조하는 외래 키

## [[일대일]] 조인 테이블
+ 일대일 관계를 만들려면 조인 테이블의 외래 키 컬럼 각각에 총 2개의 unique 제약조건을 걸어야 한다.

![[onetoone 1.png]]
```java
@Entity  
public class Parnet {  
    @Id  
    @GeneratedValue  
    @Column(name = "PARENT_ID")  
    private long id;  
    private String name;  
  
    // 조인 컬럼  
    @OneToOne  
    @JoinColumn(name = "CHILD_ID")  
    private Child child;  
  
    // 조인 테이블   
	@OneToOne  
    @JoinTable(name = "PARENT_CHILD",  
        joinColumns = @JoinColumn(name = "PARENT_ID"), // Parent와 매핑할 외래 키 
        
		inverseJoinColumns = @JoinColumn(name = "CHILD_ID")) // Child와 매핑할 외래 키  
    private Child child;  
}  
  
@Entity  
public class Child {  
    @Id  
    @GeneratedValue  
    @Column(name = "CHILD_ID")  
    private long id;  
}
```

### [[일대다]] / [[다대일]] 조인 테이블

![[ntonone.png]]
```java
import java.util.ArrayList;  
import java.util.List;  
  
@Entity  
public class Parnet {  
    @Id  
    @GeneratedValue  
    @Column(name = "PARENT_ID")  
    private long id;  
  
    // 조인 컬럼  
    @OneToMany  
    @JoinColumn(name = "CHILD_ID")  
    private List<Child> childs = new ArrayList<Child>();  
  
    // 조인 테이블  
    @OneToMany  
    @JoinTable(name = "PARENT_CHILD",  
        joinColumns = @JoinColumn(name = "PARENT_ID"),  
        inverseJoinColumns = @JoinColumn(name = "CHILD_ID"))  
    private List<Child> childs = new ArrayList<Child>();  
  
    // 일대다 양방향 매핑  
    @OneToMany(mappedBy = "parent")  
    private List<Child> childs = new ArrayList<Child>();  
}  
  
@Entity  
public class Child {  
    @Id  
    @GeneratedValue  
    @Column(name = "CHILD_ID")  
    private long id;  
  
    // 조인 테이블 다대일 매핑  
    @ManyToOne(optional = false)  
    @JoinTable(name = "PARENT_CHILD",  
        joinColumns = @JoinColumn(name = "PARENT_ID"),  
        inverseJoinColumns = @JoinColumn(name = "CHILD_ID"))  
    private Parent parent;  
}
```

### [[다대다]] 조인 테이블
+ 다대다 관계를 만드려면 조인 테이블의 두 컬럼을 합해서 하나의 복합 유니크 제약조건을 걸어야 한다.
![[ntom.png]]
```java
import java.util.ArrayList;  
import java.util.List;  
  
@Entity  
public class Parnet {  
    @Id  
    @GeneratedValue  
    @Column(name = "PARENT_ID")  
    private long id;  
  
    // 조인 테이블  
    @ManyToMany  
    @JoinTable(name = "PARENT_CHILD",  
        joinColumns = @JoinColumn(name = "PARENT_ID"),  
        inverseJoinColumns = @JoinColumn(name = "CHILD_ID"))  
    private List<Child> childs = new ArrayList<Child>();  
}  
  
@Entity  
public class Child {  
    @Id  
    @GeneratedValue  
    @Column(name = "CHILD_ID")  
    private long id;  
}
```

> [!caution]+ 
> 조인 테이블에 컬럼을 추가하면 @JoinTable 전략을 사용할 수 없다. 대신 새로운 엔티티를 만들어 조인 테이블과 매핑해야 한다.