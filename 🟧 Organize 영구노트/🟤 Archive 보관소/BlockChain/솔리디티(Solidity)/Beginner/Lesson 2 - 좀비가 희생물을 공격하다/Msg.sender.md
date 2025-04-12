---
---

#블록체인 #솔리디티 

### msg.sender
솔리디티에서는 모든 함수에서 이용 가능한 특정 전역 변수들이 있다. 그 중의 하나가 **현재 함수를 호출한 사람(혹은 스마트 컨트랙트)의 주소**를 가리키는 **msg.sender**이다.

> [!info]+ 
> 솔리디티에서 함수의 실행은 항상 **외부 호출자**가 시작한다. 컨트랙트는 누군가가 컨트랙트의 함수를 호출할 때까지 블록체인 상에서 아무 것도 안하고 있기 때문에, 항상 msg.sender가 있어야 한다.

+ msg.sender를 이용하여 mapping을 업데이트 하는 예시는 다음과 같다
``` Java
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
	// msg.sender에 대해 _myNumber가 저장되도록 favoriteNumber 매핑을 업데이트한다:
	favoriteNumber[msg.sender] = _myNumber;
	// 데이터를 저장하는 구문은 배열로 데이터를 저장할 때와 동일하다
}

function whatIsMyNumber() public view returns (uint) {
	// sender의 주소에 저장된 값을 불러온다
	// sender가 setMyNumber을 아직 호출하지 않았다면 반환값은 0이 될 것이다
	return favoriteNumber[msg.sender];
}
```

msg.sender를 사용하면 누군가 다른 사람의 데이터를 변경하기 위해서는 **해당 이더리움 주소와 관련된 개인키를 훔치는 것**밖에 없다. 즉, 이더리움의 **보안성**을 이용할 수 있게 된다.