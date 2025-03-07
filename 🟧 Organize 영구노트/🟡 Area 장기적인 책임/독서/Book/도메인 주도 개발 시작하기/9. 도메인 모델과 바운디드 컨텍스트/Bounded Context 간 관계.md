#Architecture #DDD #Book


## Bounded Context 간 관계
바운디드 컨텍스트는 어떤 식으로든 연결되기 때문에 다양한 방식으로 관계를 맺는다.

> [!info]+ 
> 가장 흔한 관계는 한쪽에서 API를 제공하고 다른 한쪽에서 그 API를 호출하는 관계이다. ([[REST API]])

이 관계에서 API를 사용하는 바운디드 컨텍스트는 API를 제공하는 바운디드 컨텍스트에 의존하게 된다.

![[bc12.png]]

## 상류(Upstream) 컴포넌트와 하류(Downstream) 컴포넌트
> [!note]+ 상류 컴포넌트
> + 일종의 서비스 공급자 역할
> + 하류 컴포넌트가 사용할 수 있는 통신 프로토콜을 정의하고 공개한다.
> + 서비스 형태로 하류 컴포넌트에게 제공을 하며 서비스의 일관성을 유지한다. → **호스트 서비스**
> 

> [!example]+ 
> 공개 호스트 서비스의 대표적인 예는 검색이 있다. 블로그, 카페, 게시판과 같은 서비스를 제공하는 포털은 각 서비스별로 구현하기보다는 검색을 위한 전용 시스템을 구축하고 각 서비스와 통합한다.
> 
> 이 때, 검색 시스템은 상류 컴포넌트가 되고 블로그, 카페, 게시판은 하류 컴포넌트가 된다.
> ![[bc13.png]]

> [!note]+ 하류 컴포넌트
> + 서비스를 사용하는 고객 역할
> + 상류 컴포넌트의 서비스는 상류 바운디드 컨텍스트의 도메인 모델을 따르므로 상류 서비스의 모델이 자신의 도메인 모델에 영향을 주지 않도록 보호해주는 완충 지대가 필요하다.

**상류 컴포넌트는 일종의 서비스 공급자 역할을 하며, 하류 컴포넌트는 그 서비스를 사용하는 고객 역할을 한다.**

> [!tip]+ 
> 개발을 원활하게 진행하려면, 상류팀과 하류팀은 개발 계획을 서로 공유하고 일정을 협의해야 한다.

## 컴포넌트 간 모델 변환기
### 완충 지대
RecSystemClient는 외부 시스템과의 연동을 처리하는데 외부 시스템의 도메인 모델이 내 도메인 모델을 침범하지 않도록 막아주는 역할을 한다. (**Anticorruption Layer(안티 코럽션 레이어)** 역할)

참고 : [[직접 통합]]
 ![[bc14.png]]
### 공유 커널
두 바운디드 컨텍스트가 같은 모델을 공유하는 경우도 있다. 공유 커널은 모델의 중복을 줄여준다는 장점을 갖고 있지만, 개발 과정에서 두 모델 모두 고려하여 공유 커널을 개발해야한다는 단점이 있다.

> [!check]+ 
> 정말로 같은 모델을 사용해도 되는지 잘 고려해야 한다.

### 독립 방식
두 바운디드 컨텍스트 통합없이 독립적으로 모델을 발전 시키고 수동으로 통합하는 방법이다. 
![[bc15.png]]

수동 방식도 나쁜 방식은 아니지만 규모가 커진다면 **수동에는 한계가 존재하므로 외부 통합 시스템을 활용하여 수동 통합 방식을 대신할 수 있다.** 통합 시스템은 [[직접 통합]]과 [[간접 통합]]을 이용할 수 있다.

![[bc16.png]]