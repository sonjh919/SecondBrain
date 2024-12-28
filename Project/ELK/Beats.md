#ELK #Beats

## Beats
Beats는 [[ElasticSearch]]와 함께 사용되는 오픈 소스 데이터 수집기이다. 로그 및 [[Metric]] 데이터를 수집하여 Elasticsearch로 전송하는 역할을 한다. Beats는 경량화된 [[Agent]]로서, 다양한 종류의 데이터를 실시간으로 수집하고 처리하여 Elasticsearch 또는 [[Logstash]]로 전송할 수 있다.

> [!tip]+ 
> 대부분의 데이터는 Logstash로 전송되어 처리 후 Elasticsearch로 전송되지만, Elasticsearch로 바로 전송되는 경우도 있다.

> [!important]+ 
> 다양한 종류의 데이터를 수집하고 Elasticsearch 또는 Logstash로 전송하기 위한 **Agent들의 집합**이다. Beats는 경량화된 에이전트로 설계되었으며, 서로 다른 용도에 맞게 설계된 여러 Agent로 구성된다.
## Beats 구성 요소
> [!summary]+ 
> + Filebeat
> + Metricbeat
> + Packetbeat
> + Heartbeat
> + Winlogbeat : windows 이벤트 로그 수집
> + Auditbeat : Linux 감사 프레임워크 데이터 수집, 파일 무결성 모니터링 이벤트 실시간 전송
### Filebeat
Filebeat는 **로그 파일에서 데이터를 수집**하는 **Agent**이다. 로그 파일을 모니터링하고 변경 사항을 감지하여 데이터를 수집하고 Elasticsearch 또는 Logstash로 경량화된 방식으로 전송한다.
### Metricbeat
Metricbeat는 **시스템 및 서비스의 메트릭 데이터**를 수집하는 Agent이다. CPU 사용률, 메모리 사용률, 네트워크 트래픽 등 다양한 메트릭을 수집하여 Elasticsearch 또는 Logstash로 전송한다.

> [!example]+ 
> CPU 사용률, 메모리 사용률, 네트워크 트래픽, Redis, NGINX 등
### Packetbeat
Packetbeat는 네트워크 트래픽을 실시간으로 모니터링하여 웹 서버, 데이터베이스, 메시지 브로커 등과 같은 서비스 간의 상호 작용을 분석하는 **경량 네트워크 패킷 분석기**이다. HTTP 요청, DNS 쿼리, MySQL 쿼리 등의 정보를 캡처하고 Elasticsearch 또는 Logstash로 전송한다.
### Heartbeat
Heartbeat는 **서비스의 가용성**을 모니터링하기 위한 에이전트로, HTTP 엔드포인트, TCP 포트 등의 서비스에 대한 **접속 가능성**을 주기적으로 테스트하고 결과를 Elasticsearch에 전송한다.