#DataStructure 

Set 인터페이스의 구현 클래스이다. 그렇기에 Set의 성질을 그대로 상속받는다. Set은 객체를 중복해서 저장할 수 없고 하나의 null 값만 저장할 수 있다. 또한 저장 순서가 유지되지 않는다. 만약 요소의 저장 순서를 유지해야 한다면 JDK 1.4부터 제공하는 LinkedHashSet 클래스를 사용하면 된다.

Set 인터페이스를 구현한 클래스로는 Hash Set과 Tree Set이 있는데 Hash Set의 경우 정렬을 해주지 않고 Tree Set의 경우 자동정렬을 해준다.

### 중복을 걸러내는 과정
> [!info]+ 
> 1. 객체의 hashCode()메소드를 호출
> 2. 저장되어 있는 객체들의 해시 코드와 비교
> 3. 같은 해시 코드가 있다면 다시 equals() 메소드로 두 객체를 비교
> 4. true가 나오면 동일한 객체로 판단하고 중복 저장을 하지 않는다.

```java
HashSet<Integer> set = new HashSet<Integer>(Arrays.asList(1,2,3));//HashSet생성
set.add(4);
set.contains(1);
set.remove(1);
set.clear();
```