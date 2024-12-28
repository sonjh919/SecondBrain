#Redis 

## Streams
- Streams는 **log를 저장하기 가장 좋은 자료 구조**
- append-only 이며 중간에 **데이터가 바뀌지 않는다.**
- 읽어 올때 id값 기반으로 시간 범위로 검색
- tail -f 사용 하는 것 처럼 신규 추가 데이터를 수신한다.

## Streams 명령어
```bash
>>> 127.0.0.1:6379> XADD customer * id "asdfdasf"
>>> "1647231099585-0"

>>> 127.0.0.1:6379> XADD customer * id "asdfdasf"
>>> "1647231112587-0"

>>> 127.0.0.1:6379> xlen customer
>>> (integer) 2

>>> 127.0.0.1:6379> xdel customer 1647231396280-0
>>> (integer) 1
```