#블록체인 #솔리디티 
### 📌 Require
+ require를 활용하면  **특정 조건이 참이 아닐 때** 함수가 에러 메시지를 발생하고 실행을 멈춘다

``` Java
function sayHiToVitalik(string _name) public returns (string) {
	// _name이 "Vitalik"인지 비교한다. 참이 아닐 경우 에러 메시지를 발생하고 함수를 벗어난다
	require(keccak256(_name) == keccak256("Vitalik"));
	
	// 참이면 함수 실행을 진행한다:
	return "Hi!";
}
```

> [!warning]+ 
> 솔리디티는 고유의 **스트링 비교** 기능을 가지고 있지 않기 때문에 **스트링의 keccak256 해시값을 비교**하여 스트링 값이 같은지 판단한다