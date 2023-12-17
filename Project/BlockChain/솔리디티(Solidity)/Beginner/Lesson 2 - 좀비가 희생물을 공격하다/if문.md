---
---

#블록체인 #솔리디티 

### 📌 if문
+ 솔리디티의 if문은 **자바스크립트의 if문**과 동일하다
```JavaScript
function eatBLT(string sandwich) public {  
  // 스트링 간의 동일 여부를 판단하기 위해 keccak256 해시 함수를 이용해야 한다는 것을 기억하자   
if (keccak256(sandwich) == keccak256("BLT")) {  
    eat();  
  }  
}
```