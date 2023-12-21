---
---

#블록체인 #솔리디티 

솔리디티에는 변수를 저장할 수 있는 공간으로 **storage**와 **memory** 두 가지가 있다.

### 📌 storage
+ 블록체인 상에 **영구적으로 저장**되는 변수를 의미한다
### 📌 memory
+ **임시적으로 저장되는 변수**로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워진다
+ 메모리 배열은 반드시 **길이 인수와 함께 생성**되어야 하고, storage의 array.push()처럼 크기가 조절되지 않는다

> [!tip]+ 
> memory는 storage보다 [[가스]] 소모 측면에서 훨씬 저렴하다!


상태 변수(함수 외부에 선언된 변수)는 초기 설정상 storage로 선언되어 블록체인에 영구적으로 저장되는 반면, 함수 내에 선언된 변수는 memory로 자동 선언되어서 함수 호출이 종료되면 사라진다. 대부분의 경우 해당 키워드를 이용할 필요가 없으나, 함수 내의 **구조체**와 **배열**을 처리할 때는 사용해야 한다.

``` Java
contract SandwichFactory {
	struct Sandwich {
		string name;
		string status;
	}

	Sandwich[] sandwiches;
	
	function eatSandwich(uint _index) public {
		// Sandwich mySandwich = sandwiches[_index];
		
		// 꽤 간단해 보이나, 솔리디티는 여기서 
		// storage나 memory를 명시적으로 선언해야 한다는 경고 메시지를 발생한다.
		// 그러므로 storage 키워드를 활용하여 다음과 같이 선언해야 한다:
		Sandwich storage mySandwich = sandwiches[_index];
		// mySandwich는 저장된 sandwiches[_index]를 가리키는 포인터이다.
		
		mySandwich.status = "Eaten!";
		// 이 코드는 블록체인 상에서 sandwiches[_index]을 영구적으로 변경한다.
		// 단순히 복사를 하고자 한다면 memory를 이용하면 된다:
		
		Sandwich memory anotherSandwich = sandwiches[_index + 1];
		// anotherSandwich는 단순히 메모리에 데이터를 복사하는 것이 된다.
		
		anotherSandwich.status = "Eaten!";
		// 임시 변수인 anotherSandwich를 변경하는 것으로
		// sandwiches[_index + 1]에는 아무런 영향을 끼치지 않는다.
		
		// 그러나 다음과 같이 코드를 작성할 수 있다:
		sandwiches[_index + 1] = anotherSandwich;
		// 이는 임시 변경한 내용을 블록체인 저장소에 저장하고자 하는 경우이다.
	}
}
```