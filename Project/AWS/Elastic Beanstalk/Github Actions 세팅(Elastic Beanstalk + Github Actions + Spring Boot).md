#AWS #ElasticBeanstalk #Git #Github_Action  #CI/CD

Spring 프로젝트를 Github에 올리고, Beanstalk도 세팅을 완료했다면 이제 Github에서 AWS 접속을 위한 세팅을 해야 한다. [[EC2 키 페어]]를 사용하여 세팅을 해보자.

## 키 페어 세팅
해당 repository에 들어가서 Settings로 가보자. Settings 탭에서 Secrets and variables → Actions를 들어간다. New repository secret에서 키 페어를 등록하여 사용하면 된다.

![[githubaction.png]]