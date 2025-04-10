#Architecture #DDD 

## Domain Event
도메인에서 발생한 모든 변화로, 어떤 문제나 이슈가 발생한 것을 도메인 관점에서 나열한 것이다.

> [!caution]+ 
> + CRUD의 관점에서 보았을 때, CUD 부분만 도메인 이벤트이다.
> 
> 데이터를 읽는 것은 **변화가 일어나지 않았기 때문에** 이벤트가 아니다.
> 데이터가 생성/수정/삭제되는 것은 **변화가 일어났기 때문에** 이벤트이다.

## Event Storming
> [!info]+ 
> Domain Event + Brain Storming → Event Storming

**도메인에서 발생하는 모든 이벤트를 적고 프로젝트에서 최종적인 어떤 결과물이 나올지를 뽑아내는 작업**이다. 

> [!caution]+ 
> 어떤 설계나 논의할 것이 없을 때까지, 끝까지 진행해야 한다.

## Event Storming하기!
+ 의견 수렴을 위해 디자이너, 프론트, 백앤드 개발자 등이 모두 모여서 진행한다.
+ 기본적인 방식은 [[Component]]를 이용하여 진행한다. 진행 시 기타 주의사항은 다음과 같다.

> [!caution]+ 
> 
> - 완전히 다른 기능이 아니라면 주어를 통합하자.
> - 일어나는 모든 변화를 Domain 관점으로 작성한다.
> - CUD 부분 중 하나가 작성된다면 (ex)수정) 추가와 삭제도 같이 작성한다.
> - 선입견을 가질 수 있는 주어 선택은 지양한다.

