---
tags: [infrastructure, scalability, architecture, roadmap]
created: 2025-10-23
---

# 인프라 확장 로드맵 (1만 → 10만 → 1000만)

## 📋 개요
Spring Boot 기반 토론방 서비스의 사용자 증가에 따른 인프라 확장 전략을 정리한 문서입니다.

## 🗺️ Canvas 시각화
- **[[인프라 확장 로드맵.canvas]]** - 전체 흐름을 시각화한 캔버스

## 📚 주제별 상세 문서

### 1. 네트워크 계층
- [[01-로드밸런서 진화]] - Nginx → ALB → Multi-Region

### 2. 캐싱 전략
- [[02-캐싱 전략]] - Redis 단일 → Multi-level → Cluster

### 3. 데이터베이스
- [[03-데이터베이스 확장]] - 단일 DB → Read Replica → Sharding

### 4. 애플리케이션
- [[04-애플리케이션 서버 확장]] - 단일 서버 → 스케일아웃 → 마이크로서비스

### 5. 비동기 처리
- [[05-비동기 처리]] - @Async → RabbitMQ → Kafka

### 6. 모니터링
- [[06-모니터링과 관찰성]] - Actuator → APM → 분산 추적

### 7. 검색
- [[07-검색 엔진]] - MySQL FTS → Elasticsearch → ES Cluster

### 8. 보안
- [[08-보안과 안정성]] - Spring Security → Circuit Breaker → WAF

---

## 🎯 단계별 최우선 과제

### 1만 명 단계
1. ✅ **Redis 캐싱 도입** (최고 효율)
2. ✅ ALB로 SPOF 제거
3. ✅ Connection Pool 최적화
4. ✅ 인덱스 최적화

**예상 투입 시간**: 2-3주  
**예상 비용**: 월 $200-300

---

### 10만 명 단계
1. ✅ **Read Replica 구축** (필수)
2. ✅ 애플리케이션 스케일 아웃 (3-5개 인스턴스)
3. ✅ APM 도입 (Pinpoint/DataDog)
4. ✅ RabbitMQ 비동기 처리

**예상 투입 시간**: 1-2개월  
**예상 비용**: 월 $1,000-2,000

---

### 1000만 명 단계
1. ✅ **Database Sharding** (핵심)
2. ✅ Kafka 이벤트 드리븐 아키텍처
3. ✅ 마이크로서비스 전환
4. ✅ Elasticsearch Cluster

**예상 투입 시간**: 6개월-1년  
**예상 비용**: 월 $10,000+

---

## 💡 핵심 인사이트

### 비용 효율이 가장 좋은 순서
1. **Redis 캐싱** - 적은 비용으로 70-80% DB 부하 감소
2. **인덱스 최적화** - 무료이며 즉각적인 효과
3. **Read Replica** - 읽기 성능 2-3배 향상

### 가장 시간이 오래 걸리는 작업
1. **Sharding** - 데이터 마이그레이션 + 애플리케이션 수정
2. **마이크로서비스 전환** - 아키텍처 전면 재설계
3. **CQRS 패턴 도입** - 읽기/쓰기 모델 분리

### 가장 리스크가 높은 작업
1. **Sharding** - 롤백이 거의 불가능
2. **마이크로서비스 전환** - 복잡도 급증
3. **Database 마이그레이션** - 다운타임 발생 가능

---

## 📊 예상 성능 지표

| 단계 | 사용자 | RPS | DB Conn | Cache Hit | P99 응답시간 |
|------|--------|-----|---------|-----------|--------------|
| 1만 | 10K | ~100 | ~10 | 70% | <200ms |
| 10만 | 100K | ~1,000 | ~50 | 85% | <300ms |
| 1000만 | 10M | ~10,000 | 분산 | 90%+ | <500ms |

---

## 🛠️ 기술 스택 변화

### 1만 명
```
[사용자] → [ALB] → [Spring Boot] → [MySQL] → [Redis]
```

### 10만 명
```
[사용자] → [ALB] 
           ↓
       [Spring Boot x3-5]
           ↓
     [MySQL Master]
       ↙     ↘
 [Replica 1] [Replica 2]
       ↓
   [Redis + RabbitMQ]
```

### 1000만 명
```
[사용자] → [CDN] → [Multi-Region ALB]
                      ↓
                  [API Gateway]
                      ↓
        ┌─────────────┼─────────────┐
        ↓             ↓             ↓
   [Room Svc]   [User Svc]   [Comment Svc]
        ↓             ↓             ↓
   [Kafka Event Bus]
        ↓
   [MySQL Shards x4] + [Redis Cluster]
        ↓
   [Elasticsearch Cluster]
```

---

## 📝 실무 팁

### 1. 모니터링부터 시작
- 최적화는 측정 가능한 것만 가능합니다
- Prometheus + Grafana는 10만 명 전에 도입

### 2. 점진적 마이그레이션
- Big Bang 배포는 피하기
- Blue-Green, Canary 배포 활용

### 3. 캐시는 만능이 아님
- Cache Invalidation이 가장 어렵습니다
- TTL과 Eviction 정책을 신중히 설계

### 4. 데이터베이스는 마지막
- Sharding은 정말 필요할 때만
- Read Replica + 캐싱으로 대부분 해결 가능

### 5. 마이크로서비스는 신중히
- 조직 구조와 일치해야 성공 가능
- 초기 스타트업에는 모놀리스가 더 빠름

---

## 🔗 참고 자료
- [Spring Boot Best Practices](https://spring.io/guides)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Redis Best Practices](https://redis.io/docs/manual/patterns/)
- [MySQL Performance Tuning](https://dev.mysql.com/doc/refman/8.0/en/optimization.html)

---

## ✅ TODO
- [ ] 1만 명 단계 구현 (2-3주)
- [ ] 성능 테스트 (JMeter, Gatling)
- [ ] 10만 명 준비 시점 판단
- [ ] 비용 분석 및 예산 확보
