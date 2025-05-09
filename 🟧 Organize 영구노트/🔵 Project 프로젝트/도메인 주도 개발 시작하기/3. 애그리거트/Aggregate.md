#Architecture #DDD #Book

## Aggregate

**도메인 개념 간의 관계를 파악하기 어렵다**는 것은 곧 **코드를 변경하고 확장하는 것이 어려워진다**는 것을 의미한다. 상위 수준에서 모델이 어떻게 엮여 있는지 알아야 전체 모델을 망가뜨리지 않으면서 추가 요구사항을 모델에 반영할 수 있는데 세부적인 모델만 이해한 상태로는 코드를 수정하기 어렵다.

+ 개별 객체 수준에서 모델을 바라보면 상위 수준에서 관계를 파악하기 어렵다
![[aggregateorder1.png]]

복잡한 도메인을 이해하고 관리하기 쉬운 단위로 만들려면 상위 수준에서 모델을 조율할 수 있는 방법이 필요한데, 그 방법이 바로 애그리거트이다. 수많은 객체를 애그리거트로 묶어서 바라보면 **좀 더 상위 수준에서 도메인 모델 간의 관계를 파악**할 수 있다.

+ 애그리거트는 **복잡한 모델을 관리하는 기준을 제공**한다.
![[aggregateorder2.png]]

애그리거트는 관련된 모델을 하나로 모은 것이기 때문에 **한 애그리거트에 속한 객체는 유사하거나 동일한 라이프사이클**을 갖는다.

## Arrgregate 경계
**한 애그리거트에 속한 객체는 다른 애그리거트에 속하지 않는다.** 애그리거트는 **독립된 객체 군**이며, 각 애그리거트는 자기 자신을 관리할 뿐 다른 애그리거트를 관리하지 않는다.

흔히 'A가 B를 가진다'는 요구사항이 있다면 A와 B를 한 애그리거트로 묶어 생각하기 쉽다. 하지만 반드시 그런 것은 아니다.

> [!example]+ 
> Product가 Review를 갖는 것으로 생각할 수 있다. 하지만, 상품과 리뷰는 함께 생성되거나 변경되지 않고 변경 주체도 다르기 때문에 서로 다른 애그리거트에 속한다.
> ![[aggregateline.png]]

> [!attention]+ 
> 처음 도메인 모델을 만들기 시작하면 큰 애그리거트로 보이는 것들이 많지만 도메인에 대한 경험이 생기고 도메인 규칙을 제대로 이해할수록 실제 애그리거트의 크기는 줄어들게 된다. (필자는 다수의 경험을 빗대어 보아 **대부분의 애그리거트가 한 개의 엔티티 객체만 갖는 경우가 많으며** 두 개 이상의 엔티티로 구성되는건 드물었다고 한다)