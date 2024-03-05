#jpa #Annotation 

## @ManyToOne
이름 그대로 다대일([[N대 1 관계]])관계에서 사용하는 매핑이다.

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