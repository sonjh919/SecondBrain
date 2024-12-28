#Redis 

## Strings
+ 일반적인 문자열이다.
+ 값은 최대 **512 MB**이다.
+ string-string 매핑을 이용하여 연결되는 자료 매핑을 할 수도 있다.

![[Strings.png]]
## Strings 명령어

> [!note]+ 
> - **SET**: SET, SETNX, SETEX, SETPEX, MSET, MSETNX, APPEND, SETRANGE
> - **GET**: GET, MGET, GETRANGE, STRLEN
> - **INCR**: INCR, DECR, INCRBY, DECRBY, INCRBYFLOAT
> - **Enterprise**: SETS, DELS, APPENDS (subquery)

```bash
set <key> <value>
set hello "world!"

# 한개 조회
get <key> <value>
get hello
-> "world!"
```