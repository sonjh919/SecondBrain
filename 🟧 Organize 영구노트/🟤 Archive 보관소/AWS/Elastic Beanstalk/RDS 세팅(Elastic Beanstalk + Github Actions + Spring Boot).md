#AWS #ElasticBeanstalk #CI/CD #RDS

Elastic Beanstalk를 사용한다면 RDS는 알아서 생성해주지만, 우리가 직접 연결해서 사용하기 위해서는 2가지의 세팅이 더 필요하다.

## 퍼블릭 엑세스
다음과 같이 퍼블릭 엑세스가 가능해야 접근할 수 있다. Elastic Beanstalk의 기본 설정은 아니요이기 때문에, 예로 바꿔주도록 하자.

![[BeanstalkRDS1.png]]

## 인바운드 규칙 추가
RDS의 VPC 보안 그룹의 링크를 클릭하여 VPC 보안 그룹을 세팅해보도록 하자.

![[BeanstalkRDS2.png]]

Group ID를 클릭하면 세부 정보가 나오는데, 밑에서 인바운드 규칙 편집을 누른다.

![[BeanstalkRDS3.png]]

다음과 같이 2개의 인바운드 규칙을 추가하자.

![[BeanstalkRDS4.png]]

## 연결!
Elastic BeanStalk에서 생성했던 사용자 이름과 암호를 각각 User와 Password에 입력하자. Host에서는 RDS의 Endpoint를 입력하면 된다. 추가로, Database는 기본인 mysql로 세팅되어 있다. 연결한 후, 다른 DB를 만들고 바꿔서 다시 연결하도록 하자.

![[BeanstalkRDS5.png]]