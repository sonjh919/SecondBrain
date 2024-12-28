---
title: Spring에서의 JSON 변환
date: 2024-01-21 18:25
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring 

## Spring에서의 [[JSON]] 반환
+ **Spring에서는 객체를 반환할 때 내부에서 JSON으로 변환 후 반환된다.**
```java
// [Response header]  
//   Content-Type: text/html  
// [Response body]  
//   {"name":"Robbie","age":95}  

@GetMapping("/json/string")  
public String helloStringJson() {  
    return "{\"name\":\"Robbie\",\"age\":95}";  
}  
  
// [Response header]  
//   Content-Type: application/json  
// [Response body]  
//   {"name":"Robbie","age":95}  

@GetMapping("/json/class")  
public Star helloClassJson() {  
    return new Star("Robbie", 95);  
}
```

>Content-Type
 보내는 자원의 형식을 명시하기 위해 헤더에 실리는 정보로, 표준 mime-type중의 하나이다.
{: .prompt-info }