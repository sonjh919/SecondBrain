#코딩테스트 #Java 

## 배열을 List로 변환하기
+ 프로그래머스에서는 배열로 주는 것이 굉장히 많다. 하지만 list로 변환하여 사용하는 것이 훨씬 유용하기 때문에, 최대한 바꿔서 사용해보자.

```java
import java.util.List;
import java.util.Arrays;

//  int[] num_list가 있다고 가정할 때,
Integer[] integerArray = new Integer[num_list.length];  
for (int i = 0; i < num_list.length; i++) {  
	integerArray[i] = num_list[i];  
}  

List<Integer> list = Arrays.asList(integerArray);  

```