---
---
#DataStructure 

## ADT Stack
+ **후입선출(LIFO; Last-In-First-Out)**
+ 가장 먼저 들어간 원소가 제일 나중에 나오는 구조
+ **어떤 작업의 순서를 되돌아가야 하는 문제**에 적합한 구조이다.

![[Stack.png]]

> [!info]+ ADT(Abstract Data Type)
> 인터페이스만 있고 실제로 구현되지 않은 자료형. 즉, 어떤 데이터의 구체적인 구현 방식은 생략한 채, 데이터의 추상적 형태와 그 데이터를 다루는 방법만을 정해놓은 것을 말한다.

### 연산 정의
Stack에서 정의되는 연산은 다음과 같다.

> [!info]+ 
> 1. push
> 2. pop
> 3. isFull
> 4. isEmpty
> 5. top : 최근 push한 데이터 위치 기록

### Java Stack
```java
import java.uitl.Stack;

Stack<Integer> stack = new Stack<>();
stack.push(1);
stack.isEmpty();
stack.pop();
stack.peek();
stack.size();
```