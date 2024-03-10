---
title: DROP vs TRUNCATE vs DELETE
date: 2023-12-22 12:42
categories:
  - DataBase
  - SQL
tags:
  - DataBase
  - RDB
  - SQL
image: 
path:
---
#DataBase #RDB #SQL 

## DROP vs TRUNCATE vs DELETE
+ 테이블 삭제 시 [[DROP]], [[TRUNCATE]], [[2. Area/Database/RDB/SQL/DML/DELETE]] 이 세 명령어는 언듯 비슷해 보이지만, 다음과 같은 차이점이 있다.

| 비교          | DELETE      | TRUNCATE      | DROP        |
| ------------- | ----------- | ------------- | ----------- |
| 삭제 범위     | 데이터 삭제 | 테이블 비우기 | 테이블 삭제 |
| 디스크 사용량 | X           | 초기화        | 초기화      |
| COMMIT        | 사용자      | AUTO          | AUTO        |
| 로그          | 남김        | 안남김        | 안남김      |