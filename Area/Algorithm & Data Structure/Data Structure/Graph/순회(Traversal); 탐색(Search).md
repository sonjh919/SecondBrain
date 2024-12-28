#DataStructure #Algorithm 


## 순회(Traversal); 탐색(Search)
+ 이진 트리에 속하는 모든 노드를 한 번씩 방문하여 노드가 가지고 있는 데이터를 목적에 맞게 처리하는 것

> [!info]+ 탐색
> 하나의 정점으로부터 시작하여 차례대로 모든 정점들을 한 번씩 방문하는 것

> [!summary]+ 
> 1. 전회 순회(Preorder traversal) = **깊이 우선 탐색(DFS;Depth First Search)**
> 2. 중위 순회(Inorder traversal)
> 3. 후위 순회(Postorder traversal)
> 4. 레벨 순회(Level traversal) = **너비 우선 탐색(BFS; Breadth First Search)**


### 전회 순회(DFS)
+ 특정 정점에서 시작하여 **한 방향**으로 진행할 수 있을 때까지 계속 진행하다가 더 이상 갈 수 없으면 다시 가장 가까운 정점으로 돌아와 다른 방향으로 탐색을 진행
+ 루트 → 왼쪽 서브 트리 → 오른쪽 서브 트리
+ [[Stack]]을 통해 서브 트리들을 방문한다.
+ 실제 구현시에는 **재귀**방식을 선택한다.

![[dfs.png]]
### 중위 순회
+ 왼쪽 서브 트리 → 루트 → 오른쪽 서브 트리

### 후위 순회
+ 왼쪽 서브 트리 → 오른쪽 서브 트리 → 루트

### 레벨 순회(BFS)
+ 특정 정점에서 **가까운 정점**을 먼저 방문하고 멀리 떨어진 정점을 나중에 순회하는 방법
+ 각 노드를 **레벨 순**으로 검사하는 순회방법
+ [[Area/Algorithm & Data Structure/Data Structure/Queue|Queue]]를 통해 자식 노드들을 방문한다.

![[BFS.png]]

## 순회 예시
![[taversal.png]]
전위(DFS) : A-B-D-H-I-E-J-F-C-G
중위 : H-D-I-B-J-E-A-F-C-G
후위 : H-I-D-J-E-B-F-G-C-A
레벨(BFS) : A-B-C-D-E-F-G-H-I-J