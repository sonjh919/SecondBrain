#Redis 

## Sorted Sets
- **set에 score라는 필드가 추가된 데이터 형 (score는 일종의 가중치)**
- 일반적으로 set은 정렬이 되어있지않고 insert 한 순서대로 들어간다. 그러나 Sorted Set은 Set의 특성을 그대로 가지며 추가적으로 저장된 member들의 **순서도 관리**한다. 
- 데이터가 저장될때부터 score 순으로 정렬되며 저장
- sorted set에서 데이터는 오름차순으로 내부 정렬
- **value는 중복 불가능, score는 중복 가능**
- 만약 **score 값이 같으면 사전 순으로 정렬**되어 저장

![[sortedset.png]]

## Sorted Sets 명령어
> [!note]+ 
> - **SET**: ZADD
> - **GET**: ZRANGE, ZRANGEBYSCORE, ZRANGEBYLEX, ZREVRANGE, ZREVRANGEBYSCORE, ZREVRANGEBYLEX, ZRANK, ZREVRANK, ZSCORE, ZCARD, ZCOUNT, ZLEXCOUNT, ZSCAN
> - **POP**: ZPOPMIN, ZPOPMAX
> - **REM**: ZREM, ZREMRANGEBYRANK, ZREMRANGEBYSCORE, ZREMRANGEBYLEX
> - **INCR**: ZINCRBY
> - **집합연산**: ZUNIONSTORE, ZINTERSTORE
> - **Enterprise**: ZISMEMBER, ZLS, ZRM, SLEN, SADDS (subquery)

```bash
# ZADD : key에 score-member를 추가
127.0.0.1:6379> zadd fruit 2 apple
(integer) 1

127.0.0.1:6379> zadd fruit 10 banana
(integer) 1

# 복수개의 score-member를 추가할 수 있음
127.0.0.1:6379> zadd fruit 8 melon 4 orange 6 watermelon
(integer) 3

# 이미 추가 된 member를 add 시 score가 업데이트
127.0.0.1:6379> zadd fruit 15 apple
(integer) 0

# ZSCORE : member에 해당하는 score 값 리턴
127.0.0.1:6379> zscore fruit apple
"15"

# ZRANK : member에 해당하는 rank(순위) 값 리턴
127.0.0.1:6379> zrank fruit melon
(integer) 2

# ZRANGE : key에 해당하는 start - stop 내가 출력하고 싶은 요소를 추출
127.0.0.1:6379> zrange fruit 0 -1
1) "orange"
2) "watermelon"
3) "melon"
4) "banana"
5) "apple"
```