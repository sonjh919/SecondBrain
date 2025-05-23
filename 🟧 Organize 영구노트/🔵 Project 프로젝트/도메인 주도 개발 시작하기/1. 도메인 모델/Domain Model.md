#Architecture #DDD #Book

## Domain Model
도메인 모델에는 다양한 정의가 존재하는데, 기본적으로는 **특정 [[Domain]]을 개념적으로 표현한 것**이다.
도메인 모델을 사용하면 여러 관계자들이 동일한 모습으로 도메인을 이해하고 도메인 지식을 공유하는 데 도움이 된다. 도메인 모델을 만드는 방식은 여러 가지가 있다. 표현 방식은 중요하지 않고, 상황에 따라 만들면 된다.

> [!caution]+ 
> '도메인 모델'이라는 용어는 도메인 자체를 표현, 이해하는 개념적인 모델을 의미하지만, 도메인 계층을 구현할 때 사용하는 객체 모델을 언급할 때에도 '도메인 모델'이라는 용어를 사용한다. 하지만 구현쪽을 조금 더 자세히 보려면 [[Domain Model Pattern]]을 참고하자.


> [!example]+ 
> **객체를 이용한 도메인 모델**
> 도메인 이해를 위해 도메인이 제공하는 기능과 주요 데이터 구성을 파악하는 면에서 객체 모델이 적합하다.
> ![[domainmodel1.png]]

> [!example]+ 
> **상태 다이어그램을 이용한 도메인 모델**
> ![[domainmodel2.png]]

## 하위 도메인과 모델
도메인은 다수의 하위 도메인으로 구성된다. 이때, 각 하위 도메인이 다루는 영역은 서로 다르기 때문에 같은 용어라도 하위 도메인마다 의미가 달라질 수 있다.

> [!example]+ 
> + 카탈로그 도메인의 **상품** : 상품 가격, 상세 내용을 담고 있는 **정보**
> + 배송 도메인의 **상품** : 고객에게 실제 배송되는 **물리적인 상품**
> 

도메인에 따라 용어 의미가 결정되므로 **여러 하위 도메인을 하나의 다이어그램에 모델링하면 안된다.** 카탈로그와 배송을 한 다이어그램에 함께 표시한다고 가정하면, 상품이 두가지 의미를 제공하기에 이해하는데 방해가 된다.

> [!important]+ 
> 모델의 각 구성요소는 특정 도메인으로 한정할 때 비로소 의미가 완전해지기 때문에 각 하위 도메인마다 별도로 모델을 만들어야 한다.

