[](solution-steps.md)[](problem-analysis.md)[](solution-steps.md)[](problem-analysis.md)[](solution-steps.md)[](problem-analysis.md)# 동시성 문제 해결: MultipleUseRequestsTest

## 개요

쿠폰 시스템에서 여러 스레드가 동시에 쿠폰을 사용하려고 할 때 발생하는 **Race Condition** 문제를 해결한 사례입니다.

## 프로젝트 정보

- **프로젝트**: java-coupon
- **테스트**: `MultipleUseRequestsTest.동시_사용_요청()`
- **기술 스택**: Spring Boot, JPA/Hibernate, MySQL

## 문제 요약

### 테스트 시나리오
- 5개 스레드가 병렬로 실행
- 각 스레드가 20개의 MemberCoupon을 사용 시도 (총 100번 요청)
- Coupon의 `useLimit` = 5
- **기대 결과**: 정확히 5번만 성공, 나머지는 실패

### 실제 결과
- **문제**: 20~24번 성공 (5번을 초과함!)
- **원인**: 동시성 제어 부재로 인한 Race Condition

## 해결 결과

비관적 락(Pessimistic Lock)을 적용하여:
- ✅ 테스트 통과
- ✅ Coupon의 `useCount` = 5로 정확히 제한
- ✅ 데이터 무결성 보장

## 관련 문서

- [[problem-analysis]] - 문제 상세 분석
- [[solution-steps]] - 해결 단계별 과정
- [[technical-details]] - 기술적 구현 세부사항
- [[lessons-learned]] - 학습한 내용과 교훈
- [[test-validation]] - 테스트 검증 가이드 (예외 메시지가 정상인 이유)
- [[error-messages-explained]] - 두 가지 에러 메시지 상세 설명

## 타임라인

1. **문제 발견**: 테스트가 실패하고 예상보다 많은 쿠폰이 사용됨
2. **원인 분석**: Race Condition 확인
3. **1차 시도**: MemberCoupon에만 락 적용 → 실패
4. **2차 시도**: Coupon도 락 적용 시도 (FETCH JOIN) → 부분 성공
5. **최종 해결**: EntityManager로 이중 락 적용 → 성공

## 핵심 개념

- **Race Condition**: 여러 프로세스/스레드가 공유 자원에 동시 접근할 때 발생
- **Pessimistic Lock**: 데이터 접근 시 락을 획득하여 다른 트랜잭션의 접근을 차단
- **Lost Update**: 동시에 같은 데이터를 수정할 때 일부 수정사항이 손실되는 현상

## 키워드

`#concurrency` `#pessimistic-lock` `#race-condition` `#jpa` `#transaction` `#database-lock`
