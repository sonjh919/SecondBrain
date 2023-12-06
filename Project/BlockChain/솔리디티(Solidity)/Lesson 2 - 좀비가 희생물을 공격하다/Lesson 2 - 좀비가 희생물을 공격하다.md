#블록체인 #솔리디티 

### 📌 MOC
+ [[mapping과 address]]
+ [[Msg.sender]]
+ [[Require]]
+ [[상속]]
+ [[import]]
+ [[Storage vs Memory]]
+ [[함수 접근 제어자]]
+ [[인터페이스]]
+ [[다수의 반환값 처리]]
+ [[if문]]

+ Lesson 2에서 사용한 코드는 다음과 같다
```Java
pragma solidity ^0.4.19;  
  
import "./zombiefactory.sol";  
  
contract KittyInterface {  
  function getKitty(uint256 _id) external view returns (  
    bool isGestating,  
    bool isReady,  
    uint256 cooldownIndex,  
    uint256 nextActionAt,  
    uint256 siringWithId,  
    uint256 birthTime,  
    uint256 matronId,  
    uint256 sireId,  
    uint256 generation,  
    uint256 genes  
  );  
}  
  
contract ZombieFeeding is ZombieFactory {  
  
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;  
  KittyInterface kittyContract = KittyInterface(ckAddress);  
  
  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {  
    require(msg.sender == zombieToOwner[_zombieId]);  
    Zombie storage myZombie = zombies[_zombieId];  
    _targetDna = _targetDna % dnaModulus;  
    uint newDna = (myZombie.dna + _targetDna) / 2;  
    if (keccak256(_species) == keccak256("kitty")) {  
      newDna = newDna - newDna % 100 + 99;  
    }  
    _createZombie("NoName", newDna);  
  }  
  
  function feedOnKitty(uint _zombieId, uint _kittyId) public {  
    uint kittyDna;  
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);  
    feedAndMultiply(_zombieId, kittyDna, "kitty");  
  }  
  
}
```