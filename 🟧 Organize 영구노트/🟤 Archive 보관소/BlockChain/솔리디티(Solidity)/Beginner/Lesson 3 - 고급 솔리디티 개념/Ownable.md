---
---

#블록체인 #솔리디티 
### Ownable
+ **openZeppelin**의 **Ownable** 컨트랙트
+ 컨트랙트를 소유 가능하게 하는 역할을 한다

> [!info]+ 
> 1. 컨트랙트가 생성되면 컨트랙트의 생성자가 owner에 msg.sender(컨트랙트를 배포한 사람)를 대입한다.
> 2. 특정한 함수들에 대해서 오직 소유자만 접근할 수 있도록 제한 가능한 onlyOwner 제어자를 추가한다.
> 3. 새로운 소유자에게 해당 컨트랙트의 소유권을 옮길 수 있도록 한다.


```Java
/**  
 * @title Ownable  
 * @dev The Ownable contract has an owner address, and provides basic authorization control  
 * functions, this simplifies the implementation of "user permissions".  
 */  
contract Ownable {  
  address public owner;  
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);  
  
  /**  
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender  
   * account.  
   */  
  function Ownable() public {  
    owner = msg.sender;  
  }  
  
  /**  
   * @dev Throws if called by any account other than the owner.  
   */  
  modifier onlyOwner() {  
    require(msg.sender == owner);  
    _;  
  }  
  
  /**  
   * @dev Allows the current owner to transfer control of the contract to a newOwner.  
   * @param newOwner The address to transfer ownership to.  
   */  
  function transferOwnership(address newOwner) public onlyOwner {  
    require(newOwner != address(0));  
    OwnershipTransferred(owner, newOwner);  
    owner = newOwner;  
  }  
}
```

> [!example]+ 
```Java
pragma solidity ^0.4.19;  

import "./ownable.sol";  

contract ZombieFactory is Ownable {
	...
}
```