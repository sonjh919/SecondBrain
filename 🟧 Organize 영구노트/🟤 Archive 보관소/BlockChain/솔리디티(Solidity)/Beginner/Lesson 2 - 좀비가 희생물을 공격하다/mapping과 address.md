---
---

#블록체인 #솔리디티 
### address
이더리움은 은행 계좌와 같은 계정들로 이루어져 있다. 계정은 이더리움의 통화인 ETH의 잔액을 가지며, 계정을 통해 다른 계정과 이더를 주고 받을 수 있다.

+ 각 계정은 **주소**를 가지고 있다
+ 주소는 특정 계정을 가리키는 **고유 식별자**이고, 주소는 특정 유저(혹은 스마트 컨트랙트)가 소유한다
+ 곧 주소는 **소유권**을 나타내는 고유 ID로 활용할 수 있다

> [!example]+ 
> 0x0cE446255506E92DF41614C46F1d6df9Cc969183

### mapping
+ mapping은 솔리디티에서 구조화된 데이터를 저장하는 또 다른 방법이다
+ mapping은 기본적으로 **key-value** 저장소로, 데이터를 저장하고 검색하는 데 이용된다
```Java
// 금융 앱용으로, 유저의 계좌 잔액을 보유하는 uint를 저장한다:
// key : address, value : uint
mapping (address => uint) public accountBalance;

// 혹은 userID로 유저 이름을 저장/검색하는 데 매핑을 쓸 수도 있다:
mapping (uint => string) userIdToName;

// key를 이용해 value를 활용하는 방법은 다음과 같다:
accountBalance[msg.sender]++;
```

