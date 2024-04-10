#Redis 

## Sets
- **중복된 데이터를 담지 않기 위해 사용하는 자료구조**
- 유니크한 key값
- **정렬되지 않은 집합**

![[sets.png]]

## Sets 명령어
> [!note]+ 
> - **SET**: SADD, SMOVE
> - **GET**: SMEMBERS, SCARD, SRANDMEMBER, SISMEMBER, SSCAN
> - **POP**: SPOP
> - **REM**: SREM
> - **집합연산**: SUNION, SINTER, SDIFF, SUNIONSTORE, SINTERSTORE, SDIFFSTORE
> - **Enterprise**: SLS, SRM, SLEN, SADDS (subquery)

```bash
sadd <key> <item>

# 존재 여부를 체크, 있으면 1 없으면 0 반환
sismember <key> <item>

# 삭제
srem <key> <value>

# key의 모든 item 조회
smembers <key>
```