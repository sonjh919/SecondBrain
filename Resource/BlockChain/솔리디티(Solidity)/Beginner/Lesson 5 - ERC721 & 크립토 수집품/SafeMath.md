---
---

#블록체인 #솔리디티 

솔리디티에서는 오버플로우와 언더플로우를 막기 위해 컨트랙트에 보호 장치를 두는 것이 좋다.
### SafeMath
+ OpenZeppelin에서 기본적으로 이런 문제를 막아주는 **SafeMath**라는 [[라이브러리]]가 있다.
+ SafeMath 내부의 코드는 다음과 같다

```Java
library SafeMath {  
  
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {  
    if (a == 0) {  
      return 0;  
    }  
    uint256 c = a * b;  
    assert(c / a == b);  
    return c;  
  }  
  
  function div(uint256 a, uint256 b) internal pure returns (uint256) {  
    // assert(b > 0); // Solidity automatically throws when dividing by 0  
    uint256 c = a / b;  
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold  
    return c;  
  }  
  
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {  
    assert(b <= a);  
    return a - b;  
  }  
  
  function add(uint256 a, uint256 b) internal pure returns (uint256) {  
    uint256 c = a + b;  
    assert(c >= a);  
    return c;  
  }  
}

```

+ 이를 이용하면 오버플로우를 막기 위해 다음과 같이 코드를 바꿀 수 있다
```Java
//before
myUint++;

//after
myUint.add(1);
```

> [!attention]+ 
> 해당 라이브러리는 uint256 기준이다. 만약 다른 타입의 계산을 원한다면, **SafeMath32, SafeMath16** 등의 라이브러리를 사용할 수 있다
