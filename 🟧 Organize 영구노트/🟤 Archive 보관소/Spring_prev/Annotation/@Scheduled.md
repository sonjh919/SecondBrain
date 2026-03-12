---
title: "@Scheduled"
date: 2024-01-26 14:47
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring #Annotation

## Scheduler
+ 스프링 프레임워크에서 제공하는 스케줄링을 지원하는 어노테이션 중 하나이다. 이 어노테이션은 메서드에 부여하여 특정 주기나 cron 표현식에 따라 주기적으로 메서드를 실행할 수 있도록 한다.

### corn
+ corn 표현식에 따라 특정 주기에 따라 메서드를 실행할 수 있다.
+ [Class CronExpression](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/scheduling/support/CronExpression.html)에서 자세한 방법을 확인할 수 있다.

#### ex

```java
// 초, 분, 시, 일, 월, 주 순서
@Scheduled(cron = "0 0 1 * * *") // 매일 새벽 1시
```




