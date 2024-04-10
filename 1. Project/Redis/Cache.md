#Redis 

## Cache
Cache란 한번 조회된 데이터를 **미리 특정 공간에 저장**해놓고, 똑같은 요청이 발생하게 되면 서버에게 다시 요청하지 말고 **저장해놓은 데이터를 제공해서 빠르게 서비스를 제공**해주는 것을 말한다.

> [!note]+ 
> 미리 결과를 저장하고 나중에 요청이 오면 그 요청에 대해서 DB 또는 API를 참조하지 않고 Cache를 접근하여 요청을 처리하는 기법이다.

## 캐시의 구조 패턴
> [!summary]+ 
> 1. Look aside Cache 패턴
> 2. Write Back 패턴

### Look aside Cache
look aside cache는 캐시를 한 번 접근하여 데이터가 있는지 판단한 후, 있다면 캐시의 데이터를 사용하고 없으면 실제 DB 또는 API를 호출한다.
![[lookaside.png]]