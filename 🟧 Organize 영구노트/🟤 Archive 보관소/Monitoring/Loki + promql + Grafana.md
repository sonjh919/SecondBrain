

```cardlink
url: https://creampuffy.tistory.com/213#Promtail%20%EC%84%A4%EC%A0%95%20%EB%B0%8F%20%EC%8B%A4%ED%96%89-1
title: "Grafana, Loki, Promtail 을 이용한 로그 모니터링 및 알림 시스템"
description: "로그 모니터링 시스템의 필요성 Logback을 이용해 날짜별, 로그 레벨별 로그 파일들을 관리하고 있었지만, 로그를 확인하려면 개발, 운영 서버에 직접 들어가서 log 파일을 열어서 확인해야 했습니다. 날짜별로, 레벨 별로도 분리되어 있고, 개발 운영 환경별로도 로그가 분리되어 있어 통합적으로 모니터링하는 것은 상당히 어렵습니다. 또한 최근 일주일 동안 특정 로그가 몇 건 발생했는지와 같은 로그 집계나 특정 시간 내에 어떤 로그가 몇 건 이상 발생 시 알림 전송 기능도 있으면 크게 도움될 것 같습니다. Grafana, Loki, Promtail의 역할 promtail is the agent, responsible for gathering logs and sending them to Loki. loki i.."
host: creampuffy.tistory.com
favicon: https://t1.daumcdn.net/tistory_admin/favicon/tistory_favicon_32x32.ico
image: https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2Fbw6j9P%2FbtrQf4khGUt%2FAAAAAAAAAAAAAAAAAAAAAKYOGIWtr0RLtG1R_5cMeg21JoivzJo8L4zbG7IeL8B0%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1756652399%26allow_ip%3D%26allow_referer%3D%26signature%3DLF3LF5FvA2Zb22HOFQooBjgGJg4%253D
```


```cardlink
url: https://growupcoding.tistory.com/122
title: "[Grafana] Centos - Grafana + Loki + Promtail 연동"
description: "grafana 설치 이후 loki 와 promtail 을 설치 하여 로그를 모니터링 하는 방법에 대해 알아 보겠습니다.  구성 설명  Promtail: 로그를 수집하고 필터링한 후 Loki로 전송하는 로그 수집기.Loki: 로그 데이터를 저장하고 검색 쿼리를 처리하는 로그 데이터베이스.Grafana: Loki로부터 데이터를 시각화하고 분석하는 대시보드 툴 입니다. .  설치Loki 설치 loki 바이너리를 다운로드 받아 압축해제후 loki 설치 합니다. #loki 다운로드 mkdir loki cd loki wget https://github.com/grafana/loki/releases/download/v2.9.8/loki-linux-amd64.zip    unzip loki-linux-amd64.zip.."
host: growupcoding.tistory.com
favicon: https://growupcoding.tistory.com/favicon.ico
image: https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2FbVDo1I%2FbtsIdIit4sS%2FAAAAAAAAAAAAAAAAAAAAAJxQU_A-76pSRRhXwMYIwTlImjr7jLcNMZwVGdVgVbYH%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1756652399%26allow_ip%3D%26allow_referer%3D%26signature%3DqPKEvz%252FgJEVkg5yeyVt33mVGMNc%253D
```


### 로그 vs 모니터링
로그는 **문제의 원인을 파악하는 것에 중점**을 둔 데이터고 메트릭은 **성능 및 상태 모니터링에 중점**을 둔 데이터


```cardlink
url: https://jminc00.tistory.com/91
title: "실시간 로그와 메트릭 모니터링: Grafana, Loki, Promtail, Prometheus 통합하기"
description: "최근 사내에서 진행한 결제 프로젝트는 NestJS라는 새로운 프레임워크를 도입해서 진행했습니다. 현재 가장 큰 문제점은 오류가 발생했을 때 그 오류를 로컬 환경에서 재현하지 않으면 오류의 원인을 명확히 알 수 없는 상황이었습니다. 물론 현재는 Sentry Report를 통해서 오류가 발생했을 때 원인을 알 수 있도록 시니어 개발자분께서 환경세팅을 해주셨지만 Sentry는 메트릭과 관련된 데이터를 모니터링하는 것에는 한계가 있었습니다.  그래서 이번 포스팅에서는 Grafana, Loki, Promtail, Prometheus를 사용해서 실시간 로그 수집과 메트릭을 모니터링해 본 경험을 공유해보려고 합니다. 아직 사내에서 정식 채택되어 사용하지는 못했지만, 지속적인 공유와 디벨롭을 통해서 가까운 미래에 사용.."
host: jminc00.tistory.com
favicon: https://t1.daumcdn.net/tistory_admin/favicon/tistory_favicon_32x32.ico
image: https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2Frbk7x%2FbtsLJLKi1YB%2FAAAAAAAAAAAAAAAAAAAAAILQNArDwjA-F_LvUtviLET7SAn1naYKq1VnxbPkdNjO%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1756652399%26allow_ip%3D%26allow_referer%3D%26signature%3D%252BOHXTqxTWHT3A6PKhkl%252FMSvGSEI%253D
```


### s3 - loki

```cardlink
url: https://wlsdn3004.tistory.com/48
title: "[Grafana Loki]란? 개념부터 설치까지"
description: "Grafana Loki란?Grafana Loki는 Prometheus에서 영감을 받은 로그 집계 시스템으로, 로깅 및 이벤트 데이터를 수집, 저장 및 검색하기 위한 오픈 소스 플랫폼이다. 비용 효율적으로 운영하기 쉽게 설계되었으며 Grafana Labs에서 Loki 프로젝트 개발을 주도하고 있다. Loki는 로그 전체 TEXT가 아닌 metadata만 인덱싱하는 방식을 취한다.이런 최소 인덱싱 접근 방식은 다른 솔루션보다 적은 저장 공간이 필요함을 의미한다. Grafana Loki는 아래와 같이 작동한다.Loki를 위해 만들어진 로그 수집 도구인 Promtail을 통해 로그를 가져와 로그를 저장한다. 이후 Grafana에서 LogQL이라는 쿼리 언어를 통해 로그를 검색하게 된다. 또한 경고 규칙을 설정하.."
host: wlsdn3004.tistory.com
favicon: https://t1.daumcdn.net/tistory_admin/favicon/tistory_favicon_32x32.ico
image: https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdna%2FozkLK%2FbtszvhnJf0S%2FAAAAAAAAAAAAAAAAAAAAANytlH7t7xgqiQMF_dkfTzp1DSAGEtcRLPbKPEw0SRGc%2Fimg.png%3Fcredential%3DyqXZFxpELC7KVnFOS48ylbz2pIh7yKj8%26expires%3D1756652399%26allow_ip%3D%26allow_referer%3D%26signature%3DpUbYmo%252FGxDFQA9tKmmMGfFxr%252Bzw%253D
```


t4.micro면 로키, 프로메테우스, 그라파나 셋 다 충분히 넣을 수 있음
s3는 아직 안넣었는데 후순위

다만 같은 vpc라도 보안 그룹이 다르기 때문에 변환기마냥 중간에 nginx를 하나 둬서 포트를 뚫어줘야한다.

올인하면 주말 내로 가능할듯?

-> 오늘 할거는
인프라 vpc 보안그룹 nginx
로그 로키 그라파나
모니터링 프로메테우스, 그라파나

내일부터 달리기!