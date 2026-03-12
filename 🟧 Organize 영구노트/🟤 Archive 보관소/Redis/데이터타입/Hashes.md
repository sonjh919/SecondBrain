#Redis 

## Hashes
- field-value로 구성 되어있는 전형적인 hash의 형태이다.
- key 하위에 subkey를 이용해 추가적인 Hash Table을 제공하는 자료구조
- 메모리가 허용하는 한, 제한없이 field들을 넣을 수가 있다.

![[hashes.png]]

## Hashes 명령어
> [!note]+ 
> **SET**: HSET, HMSET, HSETNX
> **GET**: HGET, HMGET, HLEN, HKEYS, HVALS, HGETALL, HSTRLEN, HSCAN, HEXISTS
> **REM**: HDEL
> **INCR**: HINCRBY, HINCRBYFLOAT

```bash
# 한개 값 삽입 및 삭제
hset <key> <subkey> <value>
hget <key> <subkey>

# 여러 값 삽입 및 삭제
hmset <key> <subkey> <value> <subkey> <value> ...
hnget <key> <subkey> <subkey> <subkey> ... 

# 모든 subkey와 value 가져오기, Collection에 너무 많은 key가 있으면 장애의 원인이 됨
hgetall <key>

# 모든 value값만 가져오기
hvlas <key>
```