---
title: o.s.b.d.LoggingFailureAnalysisReporter
date: 2023-12-27 12:38
categories:
  - Spring
tags:
  - Spring
  - SpringError
image: 
path:
---
## 🌈 에러 로그 확인
```java
ERROR 21496 --- [           main] o.s.b.d.LoggingFailureAnalysisReporter

Description:

Failed to configure a DataSource: 'url' attribute is not specified and no embedded datasource could be configured.

Reason: Failed to determine a suitable driver class


Action:

Consider the following:
	If you want an embedded database (H2, HSQL or Derby), please put it on the classpath.
	If you have database settings to be loaded from a particular profile you may need to activate it (no profiles are currently active).
```


## 🌈 원인
JDBC dependency를 추가한 상태에서 dataasource를 설정해주지 않아서 발생한 경우

