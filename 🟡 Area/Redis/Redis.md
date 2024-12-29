#Redis

## Redis (Remote Dictionary Server)
Redis는 **Remote(원격)** 에 위치하고 프로세스로 존재하는 In-Memory 기반의 **Dictionary([[Key-Value]])** 구조 데이터 관리 **Server** 시스템이다.

[[RDB]]와 같이 쿼리 연산을 지원하지는 않지만, 대신 **데이터의 고속 읽기와 쓰기에 최적화**되어 있다.

> [!check]+ 
> 그래서 Redis는 일종의 [[NoSQL]]로 분류되기도 한다.

## Redis 사용처
> [!summary]+ 
> 1. [[Cache]] 솔루션
> 2. 인증 토큰 저장(String or Hash)
> 3. Ranking 보드로 사용(Sorted-Set)
> 4. 유저 API Limit
> 5. 잡큐(list)


## MOC
+ [[Redis의 특징]]
+ [[Redis의 주의사항]]
+ [[Redis 데이터 타입]]