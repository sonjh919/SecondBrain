
### 배열 <-> 리스트
```java
private static int[] solution(int[] arr) {  
    return Arrays.stream(arr)  
            .distinct()  
            .boxed()  // stream<Integer>
            .sorted(Collections.reverseOrder())  
            .mapToInt(Integer::intValue)  // int[]
            .toArray();  
}
```

### 배열 -> queue
```java
ArrayDeque<String> card1 = new ArrayDeque<>(Arrays.asList(cards1));
```

### 배열 내 최대값
```java
// 배열
int max = Arrays.stream(score)
	.max()
	.getAsInt();

// 리스트
int max = list.stream()
	.max(Integer::compareTo)
	.get();
```

## 정렬
### Map Value 정렬
```java
int[] answer = fail.entrySet().stream()
                .sorted(((o1, o2) -> Double.compare(o2.getValue(), o1.getValue())))
                .mapToInt(Map.Entry::getKey)
                .toArray();
```