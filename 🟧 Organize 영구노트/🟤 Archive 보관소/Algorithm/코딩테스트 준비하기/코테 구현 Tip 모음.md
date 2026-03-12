
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

### Map Value 정렬
```java
Map<Integer, Double> fail = new HashMap<>();

int[] answer = fail.entrySet().stream()
                .sorted(((o1, o2) -> Double.compare(o2.getValue(), o1.getValue())))
                .mapToInt(Map.Entry::getKey)
                .toArray();
```

### Map 채우기
```java
for(String s : completion){
	map.put(s, map.getOrDefault(string, 0)+1);
}

Map<String, Long> participantMap = Arrays.asList(participant).stream()  
        .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

```

### Map value 수정
```java
// hashmap.compute(K key, BiFunction remappingFunction)

HashMap<String, Integer> prices = new HashMap<>();
prices.put("Shoes", 200);

// 10% 할인된 가격으로 업데이트
prices.compute("Shoes", (key, value) -> value - value * 10/100);
// 결과: Shoes의 값이 180으로 변경됨

```