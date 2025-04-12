#Architecture #DDD #Book #jpa 
## AttributeConverter를 이용한 밸류 매핑 처리
구현방식에 따라 밸류 타입의 프로퍼티를 한 개 칼럼에 매핑해야 할 때도 있다.

> [!example]+ 
> Length가 길이 값과 단위의 두 프로퍼티를 갖고 있는데 DB 테이블에는 한 개 칼럼에 '1000mm'와 같은 형식으로 저장할 수 있다.

이와 같은 경우 @Embeddable로는 처리할 수 없는데, 이때 사용할 수 있는 것이 AttributeConverter이다. AttributeConverter를 이용해 **밸류 타입과 칼럼 데이터 간의 변환을 처리**할 수 있다.

```java
package javax.persistence;

public interface AttributeConverter<X,Y> {
	public Y convertToDatacaseColumn(X attribute);
	public X convertToEntityAttribute(Y dbData);
}
```

+ 타입 파라미터 X는 밸류 타입이고, Y는 DB 타입이다.
+ AttributeConverter 인터페이스를 구현한 클래스는 @Converter 어노테이션을 적용한다.
+ @Converter 애노테이션의 autoApply 속성값을 true로 지정했는데 이 경우 모델에 출현하는 모든 Money 타입의 프로퍼티에 대해 MoneyConverter를 자동으로 적용한다.
```java
@Converter(autoApply = true)
public class MoneyConverter implements AttributeConverter<Money, Integer> {

	@Override
	public Integer convertToDatabaseColumn(Money money) {
		if(money == null) return null;
		else return money.getValue();
	}

	@Override
	public Money convertToEntityAttribute(Integer value) {
		if(value == null) return null;
		else return new Money(value);
	}
}
```

+  @Converter의 autoApply 속성이 false인 경우 프로퍼티값을 변환할 때 사용할 컨버터를 직접 지정할 수 있다.
```java
public class Order {

	@Column(name = "total_amounts")
	@Convert(converter = MoneyConverter.class)
	private Money totalAmounts;
	...
}
```
