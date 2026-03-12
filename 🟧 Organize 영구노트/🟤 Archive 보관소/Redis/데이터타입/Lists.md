#Redis 

## Lists
- array 형식의 데이터 구조로, 데이터를 순서대로 저장한다.
- 추가 / 삭제 / 조회하는 것은 O(1)의 속도를 가지지만, **중간의 특정 index 값을 조회할 때는 O(N)**의 속도를 가지는 단점이 있다.
- 즉, 중간에 추가/삭제가 느리다. 따라서 **head-tail에서 추가/삭제 한다. (push / pop 연산)**
- [[Message Queue]]로 사용하기 적절하다.

> [!tip]+ 
> + 소셜네트워크에서 타임라인과 같은 기능을 구현할 때 LPUSH를 통해 제일 첫 부분에 Insert하며 LRANGE 명령어를 통해 일정 크기를 고정적으로 빠르게 반환할 수 있다.
> + LPUSH 명령어와 LTRIM 명령어를 함께 사용하면 Lists의 크기를 항상 일정하게 고정시킬 수 있다.
> + LPUSH와 RPOP을 이용한다면 message를 전달하는 queue로 사용할 수 있다.

![[Lists.png]]

## Lists 명령어

> [!note]+ 
> - **SET (PUSH)**: LPUSH, RPUSH, LPUSHX, RPUSHX, LSET, LINSERT, RPOPLPUSH
> - **GET**: LRANGE, LINDEX, LLEN
> - **POP**: LPOP, RPOP, BLPOP, BRPOP
> - **REM**: LREM, LTRIM
> - **BLOCK**: BLPOP, BRPOP, BRPOPLPUSH
> - **Enterprise**: LREVRANGE, LPUSHS, RPUSHS (subquery)

```bash
# 왼쪽에 삽입
lpush <key> <value>

# 오른쪽에 삽입
rpush <key> <value>

# 삭제
lpop <key>
rpop <key>
```