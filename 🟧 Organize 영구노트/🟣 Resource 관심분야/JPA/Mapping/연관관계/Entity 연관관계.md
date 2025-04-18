#jpa 


**객체의 참조**와 **테이블의 외래 키**를 매핑하여 연관관계를 맺는 것을 목표로 한다.

> [!note]+ 객체 연관관계 vs 테이블 연관관계
> 객체는 필드로 객체와 연관관계를 맺는다. 참조(주소, a.getB())를 통한 연관관계는 언제나 단방향이다. 이렇게 참조를 사용해 연관관계를 탐색하는 것을 **객체 그래프 탐색**이라고 한다. 양쪽에서 서로 참조하는 것을 양방향 연관관계라 하지만, 정확히 이야기하면 이것은 양방향 관계가 아니라 **서로 다른 단방향 관계 2개**이다. 
>
반면 두 테이블은 외래 키로 연관관계를 맺는다. 이것을 [[🟡 Area/Database/RDB/SQL/Join/JOIN|JOIN]]이라 하고, 외래 키 하나로 양방향 JOIN이 가능하다.

## 연관관계 고려사항
### 방향(Direction)
[[DataBase]]에서의 테이블 간의 관계에서는 방향의 개념이 없다. 하지만 JPA [[Entity]]에서는 방향의 개념이 있다. JPA에서는 테이블에 실제 컬럼으로 존재하지는 않지만 Entity 상태에서 다른 Entity를 참조하기 위해 방향의 개념을 도입했다. **서로의 Entity를 참조할 수 있는 관계를 양방향 관계**라 부르며, **한쪽에서만 다른 Entity를 참조하는 것을 단방향 관계**라고 부른다. 양방향 관계 시에는 [[연관관계 편의 메서드]]를 추가하여 간단하게 다룰 수 있다.
### 다중성(Multiplicity)
+ [[일대일]]
+ [[다대일]]
+ [[일대다]]
+ [[다대다]]

### 연관관계의 주인(owner)
객체를 양방향 연관관계로 만들면 [[연관관계의 주인]]을 정해야 한다.

## 객체 조회
연관관계가 있는 엔티티를 조회하는 방법은 크게 2가지이다.

> [!summary]+ 
> 1. 객체 그래프 탐색(객체 연관관계를 사용한 조회)
> 2. 객체지향 쿼리 사용



