---
title: Transaction
date: 2023-12-22 14:13
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

## Transaction

- 한꺼번에 수행되어야 할 논리적 작업 단위
- Logical Unit of Work : LUW
- 하나의 Transaction으로 이루어진 작업은 **반드시 한꺼번에 완료**([[Area/Database/RDB/SQL/TCL/COMMIT]])되어야 한다.
+ 그렇지 않은 경우, **한꺼번에 취소**([[ROLLBACK]])되어야 한다.

## Transaction의 4가지 특징 (ACID)

| 특성                | 설명                                                                        |
| ------------------- | --------------------------------------------------------------------------- |
| 원자성(atomicity)   | 트랜잭션에서 정의된 연산은 모두 성공적으로 실행되던지 전혀 실행되지 않던지  |
| 일관성(consistency) | 트랜잭션 실행 전에 잘못된 내용이 없다면 실행 후에도 없어야 한다             |
| 고립성(isolation)   | 트랜잭션 실행 도중 다른 트랜잭션의 영향을 받아 잘못된 결과를 만들면 안된다. |
| 지속성(durability)  | 트랜잭션이 성공적으로 수행되면 그 DB의 내용은 영구적으로 저장된다.          |

## 트랜잭션 격리성이 낮으면 발생하는 문제점
### Dirty Read(더티 리드)
+ 데이터가 변경되었지만, 아직 커밋되지 않은 상황에서 다른 Transaction이 해당 변경사항을 조회할 수 있는 문제

### Non-Repeatable Read(반복 불가능한 조회)
+ 같은 Transaction 내에서 같은 데이터를 여러번 조회했을 때 읽어온 데이터가 다른 경우

### Phantom Read(팬텀 리드)
+ 같은 쿼리 2번 수행 시 조회 결과의 행이 새로 생기거나 없어지는 현상(유령 레코드 발생)