## 에러 상황
![[Pasted image 20240403155021.png]]

```
[2024-04-03T06:45:19.702+00:00][ERROR][elasticsearch-service] Unable to retrieve version information from Elasticsearch nodes. security_exception
2024-04-03 15:45:19     Root causes:
2024-04-03 15:45:19             security_exception: missing authentication credentials for REST request [/_nodes?filter_path=nodes.*.version%2Cnodes.*.http.publish_address%2Cnodes.*.ip]
```

## 1. token을 받기 위해 다음 명령어 실행 -> 에러 발생
```
docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

ERROR: [xpack.security.enrollment.enabled] must be set to `true` to create an enrollment token, with exit code 78

```
### 1-1. elasticsearch.yml 변경
```
cluster.name: "docker-cluster"
network.host: 0.0.0.0
xpack.security.enrollment.enabled: true
```

## 2. 다른 에러 발생
```
PS D:\intellij\demo> docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
Unable to create enrollment token for scope [kibana]

ERROR: Unable to create an enrollment token. Elasticsearch node HTTP layer SSL configuration is not configured with a keystore, with exit code 73

```

### 2-1 kibana.yml 변경 -> 효과 없음
엘라스틱서치와 동일한 아이디정보, 패스워드 정보를 추가한다. encryptionKey 는 암호화 key로 사용될 스트링이다. 임의로 32자 이상을 넣어준다.
sesionTimeout은 로그인이 유지되는 세션 시간인데, 디폴트는 600000(10분)이다.
```
elasticsearch.username: "elastic"
elasticsearch.password: "9iRN_OfC4tJJ74tgN=d5"
xpack.security.encryptionKey: "something_at_least_32_characters"
xpack.security.sessionTimeout: 600000
```