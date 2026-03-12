#SoftwarePattern #DesignPattern

## Singleton Pattern
객체를 쓸 때 인스턴스가 2개 이상이면 심각한 문제가 생길 수 있다. 이때 특정 클래스에 객체 인스턴스가 하나만 만들어지도록 해 주는 패턴이다.

> [!note]+ 
> 싱글턴 패턴은 클래스 인스턴스를 하나만 만들고, 그 인스턴스로의 전역 접근을 제공한다.

> [!example]+ 
> 로그, 디바이스 드라이버, 스레드 풀, 캐시, 대화상자, 사용자 설정, 레지스트리 설정 등

### 멀티스레딩 문제
1. `synchronized`로 해결하자.
2. getInstance()의 속도가 중요하지 않다면 그냥 두자.
3. 인스턴스가 필요할 때는 생성하지 말고 처음부터 만든다.
4. DCL을 이용하여 getInstance()에서 동기화되는 부분을 줄인다.

> [!caution]+ 
> 싱글턴은 느슨한 결합 원칙에 위배된다. 결합도가 높아지니 조심하여 사용하자.


## enum과 싱글턴
동기화, 클래스 로딩, 리플렉션, 직렬화와 역직렬화 문제 등은 enum으로 싱글턴을 생성하여 해결할 수 있다.

```java
public enum Singleton{
	UNIQUE_INSTANCE;
	//기타 필요한 필드
}

public class SingletonClient{
	public static void main(String[] args){
		Singleton singleton = Singleton.UNIQUE_INSTANCE;
		// 여기서 싱글턴 사용
	}
}
```