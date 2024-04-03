#ELK #Docker #Elasticsearch #Kibana 
## 1. Elasticsearch
1. image pull
```
docker pull elasticsearch:8.11.4
```

2. 영구 elasticsearch volume 사용 설정
```
docker volume create elasticsearch-volume
```

3. elasticSearch container 실행
```
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -v elasticsearch-volume:/usr/share/elasticsearch/data -e "discovery.type=single-node" elasticsearch:8.11.4
```

> [!note]+ 
> + 9200 port
> Elasticsearch HTTP API를 호스트에 노출하기 위한 포트
> + 9300 port
> Elasticsearch 노드들 끼리 서로 통신하기 위한 tcp 포트
> + discovery.type
> Elasticsearch가 다중 노드 클러스터를 형성해야 하는지 여부를 지정 옵션
> 기본 값은 multi-node (해당 명령어는 싱글 노드로 옵션을 설정한 것)

4. 설치 테스트
+ 8버전부터는 시큐리티가 들어가기 때문에 토큰을 발급받아야 한다.
참고 : [[토큰 발급]]
```
curl http://127.0.0.1:9200/
```
![[elksetting1.png]]
## 2. Kibana
1. image pull
```
docker pull kibana:8.11.4
```

2. kibana container 실행
```
docker run -d --link elasticsearch:elasticsearch -p 5601:5601 --name kibana kibana:8.11.4
```

3. kibana es 설정 확인
```
docker exec -i -t kibana cat /usr/share/kibana/config/kibana.yml
```
![[elksetting2.png]]

4. kibana 페이지 접속
```
http://localhost:5601/app/home#/
http://localhost:5601/app/kibana#/home
```

## 3. Cerebro
> [!info]+ 
> Elasticsearch에서 구성된 Master, Data Node 구성 및 Shards에 대해서 좀 더 물리적으로 나눠져있는 주샤드,복제샤드를 모니터링할 수 있는 Tool
1. image pull
```
docker pull lmenezes/cerebro
```

2. container 실행
```
docker run -d -p 9000:9000 --link elasticsearch:localhost --name cerebro -e "CEREBRO_PORT=9000" -e "ELASTICSEARCH_HOST=http://localhost:9200" lmenezes/cerebro
```

3. 페이지 접속
```
localhost:9000
```


## 완성
타란~
![[elksetting3.png]]