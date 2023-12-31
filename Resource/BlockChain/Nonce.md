---
---

#블록체인

### 논스(Nonce)
비트코인과 이더리움 트랜잭션의 가장 큰 차이는 논스(Nonce)이다. 이더리움 트랜잭션에는 논스가 존재하고, 이 논스는 **이중 지불**을 방지하는 데 사용한다. 비트코인의 경우 UTXO(Unspent Transaction Output), 미사용 트랜잭션 출력값을 사용한다

### 이더리움에서 논스의 활용
**이더리움의 논스는 두 가지 특성**을 가진다. **트랜잭션 시 논스가 1씩 증가**하며, **한 계정 내 논스는 유일**하고 동일한 논스가 존재하지 않는다. 한 계정의 트랜잭션들 또한 각각 고유한 논스를 가지고 있으며, 가장 오래된 순서부터 1씩 증가하는 값을 가진다.

만약 논스가 1인 트랜잭션을 발신한 후 이어서 논스가 2인 트랜잭션을 발신한다면, 두 번째 트랜잭션은 어떤 블록에도 포함되지 않는다. 두 번째 트랜잭션은 멤풀(Mempool)이라는 임시 저장공간에서 논스가 1인 트랜잭션을 기다리며, 논스가 1인 트랜잭션이 발신되면 멤풀에 있던 트랜잭션 역시 처리되고 블록에 포함된다.

같은 논스를 가진 트랜잭션이 다수 발신된 경우에는 가스비가 가장 높은 트랜잭션 하나만 처리되며, 이런 방법으로 이더리움은 이중 지불을 방지한다.