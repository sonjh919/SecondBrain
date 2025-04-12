#jpa #Annotation 

## @Access
JPA가 엔티티 데이터에 접근하는 방식을 지정한다. 설정하지 않으면 @Id의 위치를 기준으로 접근 방식이 설정된다. 두 방식을 동시에 사용할 수도 있다.

## 속성
> [!note]+
> 필드 접근 : AccessType.FIELD로 지정한다. 필드에 직접 접근한다. private이어도 가능하다.
> 프로퍼티 접근 : AccessType.PROPERTY로 지정한다. getter를 사용한다.