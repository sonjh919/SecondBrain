---
---

#블록체인 #솔리디티 

### 📌 payable 제어자
+ 이더를 받을 수 있는 특별한 함수 유형이다
```Java
contract OnlineStore {  
  function buySomething() external payable {  
    // 함수 실행에 0.001이더가 보내졌는지 확실히 하기 위해 확인:  
    require(msg.value == 0.001 ether);  
    // 보내졌다면, 함수를 호출한 자에게 디지털 아이템을 전달하기 위한 내용 구성:  
    transferThing(msg.sender);  
  }  
}
```

> [!tip]+ 
> msg.value : 컨트랙트로 이더가 얼마나 보내졌는지 확인하는 방법
> ether : 기본적으로 포함되어 있는 단위

여기서 일어나는 일은 누군가 web3.js(DApp의 프론트엔드)에서 다음과 같은 함수를 실행할 때 발생한다
``` Java
// OnlineStore는 이더리움 상의 컨트랙트를 가리킨다고 가정한다:
OnlineStore.buySomething({from: web3.eth.defaultAccount, value: web3.utils.toWei(0.001)})
```
