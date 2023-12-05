#블록체인 #솔리디티 

+ [[컨트랙트]]
+ [[Version Pragma]]
+ [[변수와 정수]]
+ [[수학 연산]]
+ [[구조체]]
+ [[배열]]
+ [[Project/BlockChain/솔리디티(Solidity)/Course 1 - 좀비 공장 만들기/함수|함수]]
+ [[Keccack256]]
+ [[형 변환]]
+ [[이벤트]]

+ Course 1에서 사용한 코드는 다음과 같다
```Java
pragma solidity ^0.4.19;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

```