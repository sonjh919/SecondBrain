---
title: Pageable
date: 2024-01-26 19:46
categories:
  - JPA
tags:
  - Spring
  - jpa
image: 
path:
---
#jpa 


## Pageable
+ 페이징에 관련된 정보를 나타내는 인터페이스로, 주로 메서드 파라미터로 사용되어 페이징된 데이터를 조회할 때 **어떤 페이지를 조회할지**를 결정하는 데에 활용된다.

```java
public interface Pageable {
    int getPageNumber();
    int getPageSize();
    long getOffset();
    Sort getSort();
}

```

- `getPageNumber()`: 현재 페이지 번호를 반환한다. (0부터 시작)
- `getPageSize()`: 페이지당 요소 수를 반환한다.
- `getOffset()`: 현재 페이지의 시작 요소의 오프셋을 반환한다.
- `getSort()`: 정렬 정보를 반환한다.

### PageRequest
+ `PageRequest`는 `Pageable`에서 가장 많이 사용되는 구현체 중 하나로, 생성자를 통해 페이지 번호, 페이지 크기, 정렬 정보를 지정할 수 있다.

```java
Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("fieldName").descending());

```

#### ex
```java
public Page<ProductResponseDto> getProductsInFolder(Long folderId, int page, int size, String sortBy, boolean isAsc, User user) {  
    Sort.Direction direction = isAsc ? Sort.Direction.ASC : Sort.Direction.DESC;  
    Sort sort = Sort.by(direction, sortBy);  
    Pageable pageable = PageRequest.of(page, size, sort);  
  
    Page<Product> productList = productRepository.findAllByUserAndProductFolderList_FolderId(user, folderId, pageable);  
  
    Page<ProductResponseDto> responseDtoList = productList.map(ProductResponseDto::new);  
  
    return responseDtoList;  
  
}
```