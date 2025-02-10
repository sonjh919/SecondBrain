#jpa #Annotation 

## @Temporal
날짜 타입(java.util.Date, java.util.Calendar)를 매핑할 때 사용한다.

```java
@Temporal(TemporalType.DATE)
private Date date;
```
## 속성
Java의 Date 타입에는 년월일시분초가 있지만 데이터베이스에는 date(날짜), time(시간), timestamp(날짜와 시간)이라는 3가지 타입이 별도로 존재한다.

> [!note]+ value
>+ TemporalType.DATE : **날짜**를 데이터베이스 date타입과 매핑 (ex)2024-03-05)
>+ TemporalType.TIME : **시간**을 데이터베이스 time 타입과 매핑 (ex)11:11:11)
>+ TemporalType.TIMESTAMP : **날짜와 시간**을 데이터베이스 timestamp 타입과 매핑
> (ex)2024-03-05 11:11:11)
> 
>  **기본값**
>  TemporalType.TIMESTAMP
