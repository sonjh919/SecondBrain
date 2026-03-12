#ELK #Logstash 

## Logstash
Logstash는 오픈 소스 데이터 처리 엔진으로, 다양한 소스에서 데이터를 수집하고 변환하여 지정된 대상 서버(ElasticSearch)에 인덱싱하여 전송하는 역할을 담당하는 소프트웨어이다. 

> [!summary]+ 
> 1. Data 처리 파이프라인
> 2. 동시 Data 수집 → 변환 → Stash보관소 전송
> 3. 수집로그 선정 → 지정된 서버에 인덱싱하여 전송


> [!check]+ 
> 주로 로그 및 이벤트 데이터의 수집, 전처리, 변환, 전송

## Logstash 구성 요소
Logstash는 다음과 같은 구성 요소를 조합하여 데이터 파이프라인을 구성할 수 있다. 각 단계에서 데이터를 가공하고 다음 단계로 전달하여 데이터 처리 및 전달 과정을 자동화한다.
### Input
Input은 다양한 소스에서 데이터를 수집한다.

> [!example]+ 
> 파일, 로그, [[Message Queue]], 데이터베이스
### Filter
Filter는 입력된 데이터를 가공하고 변환다. 다양한 형식의 데이터를 파싱하거나, 필드 추가, 삭제, 수정 등의 작업을 수행하여 데이터를 정제하거나 보강한다.
### Output
Output은 가공된 데이터를 다양한 대상으로 전송한다. [[ElasticSearch]], Kafka, Redis, Amazon S3, [[DataBase]] 등 다양한 대상에 데이터를 전송할 수 있다.