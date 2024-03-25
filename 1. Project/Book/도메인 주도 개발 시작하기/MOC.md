#Architecture #DDD #개발서적 

## 1. 도메인 모델
[[Domain]]
[[Domain Model]]
[[Domain model 도출]]
[[Domain Model Pattern]]
[[Entity와 Value]]
[[도메인 언어와 유비쿼터스 언어]]
## 2. 아키텍처 개요
[[계층 구조 아키텍처]]
[[네 개의 영역]]
[[모듈 구성]]
[[1. Project/Book/도메인 주도 개발 시작하기/2. 아키텍처 개요/Aggregate|Aggregate]]
[[DIP]]
[[Domain 영역의 주요 구성요소]]
[[Repository]]

## 3. 애그리거트
[[1. Project/Book/도메인 주도 개발 시작하기/3. 애그리거트/Aggregate|Aggregate]]
[[Aggregate 루트]]
[[Aggregate간 집합 연관]]
[[Aggregate를 팩토리로 사용하기]]
[[ID를 이용한 Aggregate 참조]]
[[Repository와 Aggregate]]
## 4. 리포지터리와 모델 구현
[[기본 생성자]]
[[도메인 구현과 DIP]]
[[모듈 위치]]
[[엔티티와 밸류 매핑]]
[[필드 접근 방식]]
[[Aggregate의 영속성]]
### 밸류 매핑
[[별도 테이블에 저장하는 밸류 매핑]]
[[밸류를 이용한 아이디 매핑]]
[[AttributeConverter를 이용한 밸류 매핑 처리]]
#### 컬렉션 매핑
[[별도 테이블 매핑(컬렉션)]]
[[한 개 칼럼 매핑(컬렉션)]]
[[Entity로 매핑(컬렉션)]]

## 5. Spring Data JPA를 이용한 조회 기능
[[검색을 위한 스펙]]

## 6. 응용 서비스와 표현 영역
[[응용 서비스 구현]]
[[응용 서비스의 역할]]
[[표현 영역]]
[[표현 영역과 응용 영역]]

## 7. 도메인 서비스
[[도메인 서비스]]
[[여러 애그리거트가 필요한 기능]]

## 8. 애그리거트 트랜잭션 관리
[[선점 잠금]]
[[비선점 잠금]]
[[오프라인 선점 잠금]]
[[Aggregate와 Transaction]]
[[LockManager 인터페이스]]

## 9. 도메인 모델과 바운디드 컨텍스트
[[간접 통합]]
[[도메인 모델과 경계]]
[[직접 통합]]
[[Bounded Context]]
[[Bounded Context 간 관계]]
[[Bounded Context 간 통합]]
[[Bounded Context 구현]]
[[Context Mapping]]

## 10. 이벤트
[[동기 이벤트 처리 문제]]
[[시스템 간 강결합 문제]]
[[1. Project/Book/도메인 주도 개발 시작하기/10. 이벤트/이벤트|이벤트]]
[[이벤트 적용 시 추가 고려 사항]]
[[이벤트, 핸들러, 디스패처 구현]]
### 비동기 이벤트
[[로컬 핸들러를 비동기로 실행]]
[[비동기 이벤트 처리]]
[[이벤트 저장소와 이벤트 포워더]]
[[이벤트 제공 API]]
[[Message Queue]]

## 11. CQRS
1. [[단일 모델의 단점]]
2. [[CQRS]]
