#jpa #Annotation 

## @ManyToOne
다대일([[N대 1 관계]])관계에서 사용하는 매핑이다.

```java
@ManyToOne
@JoinColumn(name="TEAM_ID")
private Team team;
```
## 속성
> [!note]+ optional
> false로 설정하면 연관된 엔티티가 항상 있어야 한다.
> 
> **기본값**
> true

> [!note]+ fetch
> 글로벌 fetch 전략을 설정한다.
> 
> **기본값**
> @ManyToOne=FetchType.EAGER
> @OneToMany=FetchType.LAZY

> [!note]+ cascade
> 영속성 전이 기능을 사용한다.

> [!note]+ targetEntity
> 연관된 엔티티의 타입정보를 설정한다. 거의 사용하지 않는 기능이다.