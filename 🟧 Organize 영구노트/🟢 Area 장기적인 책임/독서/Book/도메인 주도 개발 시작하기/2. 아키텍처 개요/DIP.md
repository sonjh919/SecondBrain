#Architecture #DDD #Book


## 고수준 모듈과 저수준 모듈
고수준 모듈은 의미 있는 단일 기능을 제공하는 모듈이다.
> [!example]+ 
> 가격 할인 계산

이 고수준 모듈의 기능을 구현하기 위해서는 여러 하위 기능이 필요한데, 이 하위 기능을 저수준 모듈이라고 한다.
> [!example]+ 
> 1. 고객 정보 구하기
> 2. 룰 실행하기

![[dipmodule.png]]

> [!note]+ 
> 고수준 모듈이 제대로 동작하려면 저수준 모듈을 사용해야 한다. 그런데 고수준 모듈이 저수준 모듈을 사용하면 앞서 계층 구조 아키텍처에서 언급했던 두 가지 문제, 즉 구현 변경과 테스트가 어렵다는 문제가 있다.
> 
> **참고** : [[네 개의 영역]]

## DIP
> [!help]+ DIP?
> [[05 객체 지향 설계 5원칙 - SOLID]]

DIP는 이 문제를 해결하기 위해 저수준 모듈이 고수준 모듈에 의존하도록 바꾼다. 이렇게 의존 구조를 바꾸려면 어떻게 해야 할까? 비밀은 **추상화한 인터페이스**에 있다.

> [!question]+ 인터페이스 추상화?
> 오브젝트의 [[04 설계 품질과 트레이드오프]] 부분을 읽어보면 알 수 있다.

> [!important]+ 
> 제일 중요한 사실은 **"인터페이스에 대해 프로그래밍하라[GOF94]"**이다.

### DIP 사용 예시
구조는 다음과 같다.
![[dipex.png]]
+ 추상화한 인터페이스
```java
public interface RuleDiscounter {
	public Money applyRules(Customer customer, List<OrderLine> orderLines);
}
```

+ 실제 사용 로직
```java
public class CalculateDiscountService {
	private CustomerRepository customerRepository;
	private RuleDiscounter ruleDiscounter;

	public Money calculateDiscount(OrderLine orderLines, String customerId) {
		Customer customer = customerRepository.findCusotmer(customerId);
		return ruleDiscounter.applyRules(customer, orderLines);
	}
}
```

```java
public class DroolsRuleDiscounter implements RuleDiscounter{
	private KieContainer kContainer;

	@Override
	public void applyRules(Customer customer, List<OrderLine> orderLines) {
		...
	}
}
```

> [!important]+ 
> 실제 사용할 저수준 객체는 다음 코드처럼 의존 주입을 이용하여 전달받을 수 있다.
> 
> ```java
> // 사용할 저수준 객체 생성
> RuleDiscounter ruleDiscounter = new DroolsRuleDiscounter();
> // 생성자 방식으로 주입
> CalculateDisountService disService = 
> 	new CalculateDiscountService(ruleDiscounter);
> ```
> 
> 구현 기술을 변경하더라도 Service를 수정할 필요가 없다. 다음처럼 사용할 저수준 구현 객체를 생성하는 코드만 변경하면 된다.
> 
> ```java
> // 사용할 저수준 객체 변경
> RuleDiscounter ruleDiscounter = new SimpleRuleDiscounter();
> // 사용할 저수준 모듈을 변경해도 고수준 모듈을 수정할 필요가 없다.
> CalculateDiscountService disService = 
> 	new CalculateDiscountService(SimpleRuleDiscounter);
> ```
> 

+ 테스트 역시 수월하게 할 수 있다. 실제 구현 없이 테스트를 할 수 있는 이유는 DIP를 적용해서 고수준 모듈이 저수준 모듈에 의존하지 않도록 했기 때문이다.
```java
public class CalculateDiscountServiceTest {
	@Test(expect = NoCustomerException.class);
	public void noCusotmer_thenExceptionShouldBeThrown() {
		// 테스트 목적의 대용 객체
		CustomerRepository stubRepo = mock(CustomerRepository.class);
		when(stubRepo.findById("noCustId")).thenReturn(null);

		RuleDiscounter stubRule = (cust, lines) -> null;

		// 대용 객체를 주입받아 테스트 진행
		CalculateDiscountService calDisSvc = 
				new CalculateDiscountService(stubRepo, stubRule);
		calDisSvc.calculateDiscount(someLines, "noCustId");
	}
}
```

## DIP 주의사항
DIP의 핵심은 **고수준 모듈이 저수준 모듈에 의존하지 않도록 하기 위함**이다. DIP를 적용한 결과 구조만 보고 저수준 모듈에서 인터페이스를 추출하지 말자.

> [!example]+ 
> 잘못된 예시 : 도메인 영역이 인프라스트럭처 영역에 의존하고 있는 상태
> 
> ![[dipcaution1.png]]

+ 다음과 같이 하위 기능을 추상화한 인터페이스는 **고수준 모듈에 위치**해야 한다.
![[dipcaution2.png]]


### DIP와 아키텍처
인프라스트럭처 영역은 구현 기술을 다루는 저수준 모듈이고 응용 역영과 도메인 영역은 고수준 모듈이다. 인프라스트럭처 계층의 가장 하단에 위치하는 계층형 구조와 달리 아키텍처에 DIP를 적용하면 아래 그림과 같이 인프라스트럭처 영역이 응용 영역과 도메인 영역에 의존(상속)하는 구조가 된다.

![[dipex2.png]]

> [!tip]+ 
> DIP를 항상 적용할 필요는 없다. 때로는 구현 기술에 의존적인 코드를 도메인에 일부 포함하는 것이 효과적일 때도 있다. 또는 추상화의 대상이 잘 떠오르지 않을 때도 있다. 이럴 때는 무조건 적용하기보다는 DIP의 이점을 얻는 수준에서 적용 범위를 검토해보자.