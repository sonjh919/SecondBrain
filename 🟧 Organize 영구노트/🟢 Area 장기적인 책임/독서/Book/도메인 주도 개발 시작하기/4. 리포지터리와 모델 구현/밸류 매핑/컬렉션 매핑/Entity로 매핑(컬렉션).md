#Architecture #DDD #Book #jpa 

## Entity로 매핑(컬렉션)
개념적으로 밸류인데 구현 기술의 한계나 팀 표준 때문에 @Entity를 사용해야 할 때도 있다. JPA는 @Embeddable 타입의 클래스 [[상속 관계 매핑]]을 지원하지 않는다. 대신 **@Entity를 이용한 상속 매핑으로 처리**해야 한다. 엔티티로 관리되므로 식별자 필드가 필요하고 타입 식별 칼럼을 추가해야 한다.

> [!check]+ 
> 참고 : [[@Inheritance]]