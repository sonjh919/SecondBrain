#Redis 

## HyperLogLogs
- 굉장히 많은양의 데이터를 dump할때 사용
- 중복되지 않는 대용량 데이터를 count할때 주로 많이 사용한다. (오차 범위 0.81%)
- set과 비슷하지만 저장되는 용량은 매우 작다 (저장 되는 모든 값이 12kb 고정)
- 하지만 저장된 데이터는 다시 확인할 수 없다. (데이터 보호에 적절)

> [!question]+ dump?
>  데이터를 백업하거나 저장하는 과정

> [!example]+ 
> 엄청 크고 유니크한 값을 카운팅 할 때 사용한다.
> 웹 사이트 방문 ip 개수 / 크롤링 한 url 개수 / 검색 카운트 등


## HyperLogLogs 명령어
```bash
> PFADD crawled:20171124 "http://www.google.com/"
(integer) 1

> PFADD crawled:20171124 "http://www.redis.com/"
(integer) 1

> PFADD crawled:20171124 "http://www.redis.io/"
(integer) 1

> PFADD crawled:20171125 "http://www.redisearch.io/"
(integer) 1

> PFADD crawled:20171125 "http://www.redis.io/"
(integer) 1

> PFCOUNT crawled:20171124
(integer) 3

> PFMERGE crawled:20171124-25 crawled:20171124 crawled:20171125
OK

> PFCOUNT crawled:20171124-25
(integer) 4
```