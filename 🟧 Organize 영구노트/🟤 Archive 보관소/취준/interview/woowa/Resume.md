
## 독서 기반 토론 서비스, 토독토독 | 2025.07 - 진행중   |   BE 4, AN 3

• Java, Spring Boot, JPA, MySQL, H2, Loki, Prometheus, Grafana, K6,  Nginx, Flyway, Docker, AWS EC2/S3/RDS/ALB

- 토론방 검색에 Full-Text Index를 적용한 후에도 성능 목표 미달성
	- 원인을 분석한 결과, Index Fragmentation을 발견하고 Index Rebuilding으로 검색 성능 46% 개선 (18.6s→10s)
	- 이후 Scheduler로 Fragmentation Rate를 정기적으로 점검하고 5% 이상시 Slack 알림을 전송하는 모니터링 시스템 구축
    

- 2000명 예상 사용자의 동시 접속률(10%)을 고려하여 200 TPS 목표 설정
	- 핵심 플로우 15개에 대한 부하 테스트(단일 9회, 가중치 7회)로 병목 지점 식별 및 최적화
	- Tomcat/HikariCP 설정 최적화 및 서버 2대 구성으로 목표 달성
    
- 슬로우 쿼리 로그 분석을 통해 병목 API 식별 및 인덱스 최적화
    - Unique 제약조건을 추가 후 논클러스터링 index를 활용하여 99.91% 성능 개선(230ms→0.2ms)
	- 복잡한 하나의 쿼리를 두 개로 나누고 각각에 대해 복합 인덱스를 적용하여 covering index를 충족시켜 97.67% 성능 개선(30s→700ms)
    

- ALB와 GitHub Actions를 활용하여 Rolling Update 방식의 무중단 배포 환경 구축    
- 효율적인 시간 분배 및 병목 방지를 위해 문서화 및 이슈 관리 시스템을 제안하여 원활한 커뮤니케이션에 기여


## 티켓팅 웹 프로젝트, 이선좌 | 2024.03 - 2024.04   |   BE 3, FE 1

• Java, Spring Boot, JPA, MySQL, AWS, Docker, Prometheus, Grafana

- 4-Layered Architecture를 참고한 Multi-Module 도입으로 의존성 분리 및 레이어별 독립 테스트 가능
- Event Storming을 도입하여 도메인에 대한 팀원 간 이해 차이로 인한 커뮤니케이션 비용을 줄이고 협업 효율 개선
    
