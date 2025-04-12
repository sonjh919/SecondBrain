#Architecture #DDD


## Boris Diagram
> [!note]+ Boris Diagram
> 각각의 Aggregate가 어떻게 통신하고 어떤 데이터를 주고 받을 지 설계하는 다이어그램

- 주로 Aggregate를 가지고 Boris Diagram을 그린다.
- Service 사이의 요청을 **동기 방식으로 할지 비동기 방식으로 할지 정의**를 하게 된다. 
- BFF(Backend for frontend)가 필요한 경우 이때 같이 구성한다.

> [!question]+ BFF?
> 프론트엔드를 위한 중간 서버를 구현하는 것으로, 여러 플랫폼을 지원하지 않을 경우 의미가 없을 수 있다. 자세한 내용은 카카오 기술블로그를 참고하자.
> https://fe-developers.kakaoent.com/2022/220310-kakaopage-bff/

> [!info]+ 참고
> + [[동기&비동기 vs Blocking&Non-Blocking]]


> [!example]+ 
> 비동기 방식은 Message Queue를 이용하여 표현하였다.
![[boris2.png]]
![[boris1.png]]


> [!example]+ 
> 빨간줄은 비동기 호출일 경우이고 파란 줄은 동기 호출로 표현하였다.
![[boris3.png]]