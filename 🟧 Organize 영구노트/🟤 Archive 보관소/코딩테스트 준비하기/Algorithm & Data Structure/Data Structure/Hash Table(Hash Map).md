#DataStructure 
## Hash Table(Hash Map)
**해시를 사용하는 자료구조**이다.
배열의 색인(index)에 해시값을 사용하는 자료구조로, 정렬을 하지 않고도 빠른 검색, 빠른 삽입이 가능하다.

해시맵은 여러 성분을 저장하기 위해 배열을 사용하는 접근법은 동일하지만, 여기에 색인 개념이 추가되어 있다. 일단 충분히 큰 공간을 할당받은 다음 해시 함수를 이용하여 고유 색인을 생성한다. 그리고 이 고유 색인과 맞는 위치에 데이터를 저장한다.

해시값이 충돌하여 같은 색인이 만들어질 수도 있는데, 이때 보통 두가지 방식을 사용한다.
### 개별 체이닝(Separate Chaining)
충돌 발생 시 연결 리스트로 연결하는 방식을 말한다.

> [!tip]+ 
> 자바는 개별 체이닝 방식을 채택하고 있다.

![[chaining.png]]
### 오픈 어드레싱(Open Addressing)
충돌 발생 시 그림과 같이 탐사를 통해 빈 공간을 찾아나서는 방식이다.
![[addressing.png]]

### 연산 정의
HashMap에서 정의되는 연산은 다음과 같다.

> [!info]+ 
> 1. put
> 2. get
> 3. remove
> 4. containsKey
> 5. clear
> 6. isEmpty
> 7. size

### java HashTable
HashTable 클래스와 HashMap클래스가 있다. 두 클래스는 유사하지만, HashTable클래스는 자바의 초기 버전과 호환성을 위해 남겨두었을 뿐, 최근에는 거의 사용되지 않는다.

```java
HashMap<String, Integer> hashMap = new HashMap<>();  
hashMap.put("a",1);  
hashMap.get("a");
hashMap.remove("a");


for (String s : hashMap.keySet()) {  
    System.out.println("s = " + s);  
}  
  
for (Entry<String, Integer> map : hashMap.entrySet()) {  
    map.getKey();  
    map.getValue();
    map.setValue(1);
}

for (Integer value : map.values()) {  
    System.out.println(value);  
}
```
