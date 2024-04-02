#ELK #Elasticsearch #Kibana #Logstash #Beats

## ELK(ElasticSearch, Logstash, Kibana) Stack
데이터 처리 관련 오픈소스 솔루션인 [[Elasticsearch]] + [[Logstash]] + [[Kibana]] + [[Beats]] 를 같이 연동하여 사용한다는 의미이다. 데이터를 **수집, 처리, 조회**하는 데 특화되어 있는 시스템이며 많은 회사에서 데이터 수집용도로 사용하고 있는 시스템이다.

![[elk.png]]

> [!summary]+ ELK 요약
> + Elasticsearch : 쌓아진 정보를 가공(데이터 분석)
> + Logstash : 수집된 데이터를 받아 로그를 쌓아두고 필터링
> + Kibana : 가공된 데이터를 보여주는 부분(데이터 시각화)
> + Beat : 데이터 수집
> ![[elk2.png]]


## Beats
2015년 이후 Beat이 추가되면서 ELK Stack으로 많이 불린다.