---
---

#블록체인 #솔리디티 
### keccak256
+ 이더리움은 **SHA3(암호화 해시 함수)** 의 한 버전인 keccak256를 내장 해시 함수로 가지고 있다
+ 해시 함수는 기본적으로 입력 스트링을 랜덤 256비트 16진수로 매핑한다

```Java
//6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
keccak256("aaaab");

//b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9
keccak256("aaaac");
```
### keccak256를 이용한 난수 발생기
+ 블록체인에서 안전한 난수 발생기는 매우 어려운 문제이다
+ 해당 방법은 정직하지 않은 노드의 공격에 취약하다.

```Java
// Generate a random number between 1 and 100:  
uint randNonce = 0;  
uint random = uint(keccak256(now, msg.sender, randNonce)) % 100;  
randNonce++;  
uint random2 = uint(keccak256(now, msg.sender, randNonce)) % 100;
```
