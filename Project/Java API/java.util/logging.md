---
title: logging
date: 2023-12-31 14:33
categories:
  - JavaAPI
  - java.util
tags:
  - JavaAPI
  - Java
  - javautil
image: 
path:
---

## logging
+ Java에서 로깅(logging)을 위한 기본적인 기능을 제공하는 패키지인다.
+ 애플리케이션에서 발생하는 이벤트나 정보를 기록하고, 이를 관리하고 분석하는 데 사용된다.

### Logger
+ 로깅 작업을 수행하는 주요 클래스이다.
+ Logger 객체를 얻고, 이를 통해 로깅을 수행한다.
+ log 메서드를 잉요하여 로그 레벨에 따른 로그를 출력한다.

### Handler
+ 로그 레코드를 처리하고 출력하는 데 사용된다.
+ 콘솔, 파일, 데이터베이스 등 다양한 출력 소스로 로그를 전달할 수 있다.

### Formatter
+ 로그 레코드의 형식을 지정하는 데 사용된다.
+ 로그 레코드를 원하는 형식으로 포맷하여 출력한다.

### Level
+ 로깅 메시지에 대한 중요도를 나타낸다.
+ 로그 레벨은 DEBUG, INFO, WARNING, ERROR, CRITICAL 등 다양한 레벨로 구분된다.

```java
import java.util.logging.*;

public class LoggingExample {
    private static final Logger LOGGER = Logger.getLogger(LoggingExample.class.getName());

    public static void main(String[] args) {
        LOGGER.setLevel(Level.INFO); // 로그 레벨 설정

        LOGGER.severe("Severe log message"); // 심각한 에러 레벨의 로그 출력
        LOGGER.warning("Warning log message"); // 경고 레벨의 로그 출력
        LOGGER.info("Info log message"); // 정보 레벨의 로그 출력
        LOGGER.config("Config log message"); // 설정 레벨의 로그 출력
        LOGGER.fine("Fine log message"); // 디버그 레벨의 로그 출력
        LOGGER.finer("Finer log message"); // 더 디테일한 디버그 레벨의 로그 출력
        LOGGER.finest("Finest log message"); // 가장 디테일한 디버그 레벨의 로그 출력
    }
}

``````