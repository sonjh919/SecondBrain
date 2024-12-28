#jpa #SpringDataJPA

## Page
+ `Page` 인터페이스는 **페이징된 결과를 표현**하는데 사용된다.
+ 이 인터페이스는 목록과 함께 페이징과 관련된 다양한 메타 정보를 제공한다.
+ 어떤 페이지를 조회할지 결정하는 것은 [[Pageable]]을 사용한다.

+ slice 사용
```java
public interface Page<T> extends Slice<T> {
    int getTotalPages();
    long getTotalElements();
    <U> Page<U> map(Function<? super T, ? extends U> converter);
}

```

- `getTotalPages()`: 전체 페이지 수를 반환한다.
- `getTotalElements()`: 전체 요소 수를 반환한다.
- `map(Function<? super T, ? extends U> converter)`: 페이지 내의 각 요소에 대해 주어진 변환 함수를 적용한 후, 새로운 페이지를 반환한다.

+ Page 인터페이스
```java
public interface Page<T> extends Iterable<T>{

	int getNumber();                // 현재 페이지  
	int getSize();                  // 페이지 크기  
	int getTotalPages();            // 전체 페이지 수  
	int getNumberOfElements();      // 현재 페이지에 나올 데이터 수  
	long getTotalElements();        // 전체 데이터 수  
	boolean hasPreviousPage();      // 이전 페이지 여부  
	boolean isFirstPage();          // 현재 페이지가 첫 페이지인지 여부  
	boolean hasNextPage();          // 다음 페이지 여부  
	boolean isLastPage();           // 현재 페이지가 마지막 페이지인지 여부  
	Pageable nextPageable();        // 다음 페이지 객체, 다음 페이지가 없으면 null
	Pageable previousPageable();    // 다음 페이지 객체, 이전 페이지가 없으면 null 
	List<T> getContent();           // 조회된 데이터  
	boolean hasContent();           // 조회된 데이터 존재 여부  
	Sort getSort();                 // 정렬 정보
}
```
