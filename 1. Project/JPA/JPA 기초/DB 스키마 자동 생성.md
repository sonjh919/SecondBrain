#jpa 

[[application.properties]]에서 세팅할 수 있다. 자동 생성되는 [[DDL]]은 지정한 [[데이터베이스 방언]]에 따라 달라진다. 스키마 자동 생성 기능이 만든 DDL은 운영 환경에서 사용할 만큼 완벽하지는 않으므로 개발 환경에서 사용하거나 매핑 참고용으로 사용하자.
## spring.jpa.hibernate.ddl-auto
+ create : 기존 table을 전부 삭제한 후에 다시 생성 (**drop + create**)
+ create-drop : create과 같지만 **종료 시점에 table을 drop**한다.
+ update : **변경된 부분**만 반영한다.
+ validate : Entity와 table이 **정상적으로 mapping되었는지만 확인**한다.
+ none : 아무것도 하지 않는다.

> [!caution]+ 
> 운영 서버에서 create, create-drop, update처럼 DDL을 수정하는 옵션은 절대 사용하면 안된다. 오직 개발 서버나 개발 단계에서만 사용하자.

> [!tip]+ 개발 환경에 따른 전략
> + 개발 초기 단계 : create 또는 update
> + 테스트 진행 환경이나 CI 서버 : create 또는 create-drop
> + 테스트 서버 : update 또는 validate
> + 스테이징, 운영 서버 : validate, none
## spring.jpa.properties.hibernate.show_sql
+ true : 콘솔에 실행되는 테이블 생성 DDL을 출력할 수 있다.

## spring.jpa.hibernate.ejb.naming_strategy
+ ImprovedNamingStrategy : 테이블 명이나 컬럼 명이 생략되면 자바의 카멜 표기법을 테이블의 언더스코어 표기법으로 매핑한다.