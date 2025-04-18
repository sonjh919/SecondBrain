#Architecture #MSA 

## MSA
> [!Summary]+ 
> 기능 별로 필요한 부분에만 영향을 끼칠 수 있을 정도로 작은 단위로 나눈다.

사이드 이펙트를 최소화하기 위한 아키텍쳐로 MSA가 등장하게 된다. 도메인 서비스 단위로 분리한 모델이다. 도메인 단위로 분리하기 때문에 [[🟡 Area/Architecture/DDD/DDD|DDD]]와 잘 어울린다.

> [!caution]+ 
> 일단 Mono를 잘 만들 수 있는 능력이 중요하다. 상황마다 최적화 된 아키텍쳐가 다르기 때문이다. 개발기간을 고려하여 아키텍쳐 모델을 정하자.

> [!note]+ 장단점
> **장점**
> + **하나의 변화는 단 하나의 기능에서만 영향을 끼친다.** 
> + 서비스별로 DB가 나누어져있기 때문에 **하나의 서비스에서 오류가 발생하더라도 다른 서비스에 영향을 주지 않는다.**
> + 서비스가 다양해지고, 기능이 많아지니 외부적인 기능(모니터링 등)이 강해진다.
> 
> **단점**
> + 기능들이 잘게 나눠질수록 속도는 느려진다.
> + 개발 속도가 느리고, 개발자가 많이 필요하다.


> [!check]+ 
> 내 서비스에 무언가를 추가 했을 때 영향을 받는 서비스가 무엇이 있는지 생각해보면 잘된 것인지 아닌지 알 수 있다. 


## Monolithic vs MSA
제일 중요한 차이점은 **DB의 관리**이다. Mocolithic은 DB가 한곳에 있지만, MSA는 DB가 나누어져 있다. 이로 인해 MSA는 **DB의 오염이 되지 않는다**는 점이 크다. 그렇다면 **DB 를 어떻게 쪼갤 것이냐**가 제일 중요한 문제가 된다. 

> [!question]+ MSA와 DB 구조
> MSA 구조로 갈 경우 RDB에 대한 부담이 낮아지지만 DB에 대한 이해가 필요하다.

