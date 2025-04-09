---
title: DataBase
date: 2023-12-22 11:26
categories:
  - DataBase
tags:
  - DataBase
image: 
path:
---
#DataBase 

## Database의 필요성
응용프로그램들은 RAM에서 동작하기 때문에 data를 영구히 저장할 곳이 필요하다.
→ **database와 파일로 data를 관리한다.**

그러나 사용자가 파일에 직접적으로 접근하여 사용하면?

> [!info]+ 
> - 권한 관리에 문제가 생긴다.
> - 문제가 생겼을 때 수정, 백업 등 관리가 어렵다.
> - 동기화, 공유가 어렵다.

결국 database는 **파일처리에서 진화된 단계**라고 할 수 있다.

## DBMS (database management system)
- DB를 control할 수 있게 중간에서 도와주는 프로그램

## RDB vs NoSQL
+ [[RDB]]
+ [[NoSQL]]



1. NoSQL은 **key-value**이고, RDB는 PK를 이용해 데이터를 찾는다.
2. RDBMS는 수직 확장 -> 단일 서버 성능 향상, NoSQL은 수평 확장 -> 여러 서버에 데이터를 분산하여 처리
3. RDB는 B+tree이고, NoSQL은 Log-structured merge-tree 방식을 사용한다.
4. NoSQL이 RDBMS에 비해 트랜잭션에 더 유연하다.
5. RDBMS는 테이블을 사용하지만 NoSQL은 테이블이 필요없다.
6. RDBMS은 고정된 스키마를 가져 데이터의 구조가 사전에 정의되고        변경되기 어렵다. 하지만 NoSQL은 유연한 스키마를 가지며, 데이터 구조는 유연하게 조정될 수 있다.
RDBMS는 구조화된 데이터와 업무용 응용프로그램에 적합하고, NoSQL은 **대규모의 유연한 데이터 모델과 확장성을 필요로 하는 다양한 응용프로그램에 적합**하다.

**분산 인덱싱 및 캐싱**: NoSQL 시스템은 분산 인덱싱 및 캐싱을 통해 데이터에 빠르게 접근할 수 있도록 지원합니다. 이는 대규모 데이터셋에서도 빠른 조회를 가능하게 합니다.
**비정형 데이터 모델**: NoSQL 데이터베이스는 유연한 데이터 모델을 사용합니다. 특히 문서 지향(Document-oriented) 데이터베이스는 비정형 데이터를 저장하고 쿼리하는 데 효율적입니다. 이는 응용프로그램의 요구 사항에 맞게 데이터 모델을 유연하게 조정할 수 있으며, 조인이 필요 없는 경우에는 데이터를 단일 문서로 저장하여 조회 성능을 향상시킵니다.

LSM tree?
key-value로, 로그 형식으로 기록한다. 최신 정보를 찾기 좋다.

### Log-Structured Storage Engine

log file
로그 파일 기반으로 작동하는 방식. Log 파일은 Append-only(한번 쓰여진 정보는 바뀌지 않고 새로운 내용은 항상 파일의 끝에 추가)

-> db 추가는 쉽지만 조회는 어렵다. 조회할 때 마다 db 파일 전체를 스캔해야함
-> index를 만들어 read 퍼포먼스를 올린다. 하지만 인덱스를 만들면 write 시 index도 업데이트해줘야 하기 때문에 write 퍼포먼스가 안좋아질 수 있다.

-> in-memory-hash-map을 index로 이용

-> update가 많아질수록 쓸데없는 데이터가 차지하고 있는 용량이 많아지게 된다.
낭비되는 용량을 줄이기 위해 Segment file과 compaction 개념 추가

segment file : database 파일을 하나로 가지고 있는 게 아니라 일정 사이즈가 되면 새로운 파일을 만드는 개념
compaction : 겹치는 key 삭제

단점 : 해쉬 인덱스가 메모리에 들어갈 수 있어야 함, range 쿼리 하기가 어려움

### lsm tree
sorted string table은 segment file과 비슷한데 파일 안에 key로 sort되어 있음(유저가 쓴 순서 x)

-> 데이터를 끝에만 추가하는건?
새로운 key/value를 추가할 때 sstable에 넣는게 아니라 메모리에 있는 binary tree에 추가한다.(이걸 memtable)

메모리에 memtable을 keep하고 있다가 일정 사이즈가 넘어가면 sstable에 옮김.
key가 worted된 순서대로 write하기 때문에 빠름

sstable에 쓰기 전에 db가 crash하면? 간단한 log file을 같이 추가해놓음

**READ 할 때**
1. key가 memtable에 있는지 확인 -> 있으면 리턴
2. 없으면 SSTable을 차례로 확인

READ 성능 향상을 위해 index는 메모리에 존재
![[Pasted image 20240327095507.png]]![[Pasted image 20240327095530.png]]

![[Pasted image 20240327095613.png]]
** 조인**

**스키마 빡빡함 vs 일단 때려넣고 본다, 클러스터링단위**