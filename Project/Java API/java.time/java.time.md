---
title: java.time
date: 2023-12-31 14:45
categories:
  - JavaAPI
  - java.time
tags:
  - JavaAPI
  - Java
  - javatime
image: 
path:
---

## java.time
+ Java 8에서 추가된 날짜와 시간을 다루는 클래스들을 포함한 패키지이다.
+ java.util.Date나 java.util.Calender 클래스보다 훨씬 향상된 API를 제공한다.

## 자주 쓰이는 클래스 및 기능
### 날짜, 시간 정보
+ **LocalDate** : 날짜 정보를 나타내는 클래스이다.
+ **LocalTime** : 시간 정보를 나타내는 클래스이다.
+ **LocalDateTime** : 날짜와 시간 정보를 보두 가지고 있는 클래스이다.

### 기간 정보
+ **Instant** : 에포크 시간(UNIX 시간)을 기반으로 한 시점을 나타낸다.
+ **Duration** : 시간 간격을 나타낸다.
+ **Period** : 날짜 간격을 나타낸다.

### Timezone
+ ZoneId : 시간대(Timezone)을 나타내는 클래스이다.
+ ZonedDateTime : 특정 시간대에 해당하는 날짜와 시간 정보를 가지고 있는 클래스이다.

### 날짜 및 시간 연산
+ 날짜와 시간에 대한 연산을 지원한다.
+ plusDays(), minusHours() 등의 메서드를 사용하여 날짜와 시간을 조작할 수 있다.

### 서식화 및 파싱
+ DateTimeFormatter 클래스를 사용하여 날짜와 시간을 원하는 형식으로 출력하거나 파싱할 수 있다.

```java
import java.time.*;

public class DateTimeExample {
    public static void main(String[] args) {
        // 현재 날짜와 시간
        LocalDateTime now = LocalDateTime.now();
        System.out.println("Current date and time: " + now);

        // 특정 날짜
        LocalDate date = LocalDate.of(2023, Month.DECEMBER, 25);
        System.out.println("Christmas date: " + date);

        // 날짜 연산
        LocalDate nextWeek = date.plusWeeks(1);
        System.out.println("Next week from Christmas: " + nextWeek);

        // 서식화
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDate = now.format(formatter);
        System.out.println("Formatted date: " + formattedDate);
    }
}

```