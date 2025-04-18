#DataStructure 


## 우선순위 큐(Priority Queue)
**큐([[🟧 Organize 영구노트/🟢 Area 장기적인 책임/코딩테스트 준비하기/Algorithm & Data Structure/Data Structure/Queue|Queue]]) 는 먼저 들어오는 데이터가 먼저 나가는 **FIFO(First In First Out)** 형식의 자료구조이다.

**우선순위 큐(Priority Queue)** 는 먼저 들어오는 데이터가 아니라, **우선순위가 높은 데이터**가 먼저 나가는 형태의 자료구조이다.

우선순위 큐는 일반적으로 **힙(Heap)** 을 이용하여 구현한다.

## 힙(Heap)
완전 [[이진 트리(Binary Tree)]]의 일종으로, 우선순위 큐를 구현하기 위해 만들어진 자료구조
부모 노드의 값이 자식 노드의 값보다 항상 크거나 작은 구조의 이진 트리이다.
우선순위, 중요도, K번째의 값을 구하는 문제에 주로 사용된다.

### 시간 복잡도
최대/최소 검색이 많을 때 유리하다.

- 삽입 : O(log n)
- 삭제 : O(log n)
- 최대/최소값 검색 : O(1)
- Heapify(이진 트리를 heap으로 변환): O(n)

### 최대 힙 (Max Heap)
부모 노드의 키 값이 자식 노드보다 크거나 같은 완전이진트리이다.
![[maxheap.png]]
### 최소 힙 (Min Heap)
부모 노드의 키 값이 자식 노드보다 작거나 같은 완전이진트리이다.
![[minheap.png]]