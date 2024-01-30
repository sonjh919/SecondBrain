#AWS #ElasticBeanstalk #Git #Github_Action #SpringBoot #CI/CD


프로젝트를 만드는 것은 누구나 다 할 수 있을 것이라 생각하고, Spring Boot에서 세팅해야 할 것을 얘기해보자. 크게 3가지가 있다.

## 1. cicd.yml
root에서 `.github/workflows` 디렉토리를 만든 후 `cicd.yml` 파일을 작성한다. github action이 실행 될 때 해당 파일을 읽어 실행된다.

```yml
name: todo-to-beanstalk  
  
on:  
  push:  
    branches:  
      - master  
  
jobs:  
  build:  
    runs-on: ubuntu-latest  
    steps:  
      - name: Checkout source code  
        uses: actions/checkout@v2  
  
      - name: Set up JDK 17  
        uses: actions/setup-java@v4  
        with:  
          distribution: 'corretto'  
          java-version: '17'  
  
      - name: Grant execute permission for gradlew  
        run: chmod +x ./gradlew  
        shell: bash  
  
      - name: Build with Gradle  
        run: ./gradlew clean build  
        shell: bash  
  
      - name: Get current time  
        uses: 1466587594/get-current-time@v2  
        id: current-time  
        with:  
          format: YYYYMMDDTHHmm  
          utcOffset: "+09:00"  
  
      - name: Generate deployment package  
        run: |  
          mkdir -p deploy  
          cp build/libs/*.jar deploy/todo.jar  
          cp Procfile deploy/Procfile  
          cp -r .ebextensions deploy/.ebextensions  
          cd deploy && zip -r todo.zip .  
  
      - name: Build and Deploy to AWS Elastic Beanstalk  
        uses: einaregilsson/beanstalk-deploy@v21  
        with:  
          aws_access_key: ${{ secrets.AWS_ACCESS_KEY_ID }}  
          aws_secret_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}  
          application_name: todo  
          environment_name: Todo-env-1  
          version_label: v${{ github.run_number }}  
          use_existing_version_if_available: true  
          region: ap-northeast-2  
          deployment_package: deploy/todo.zip  
          wait_for_environment_recovery: 30  
          wait_for_deployment: true
```

## 2. ebextensions
**구성 파일**들의 모음집이다. root 디렉토리에서 `.ebextensions` 디렉토리를 만든 후 `.ebextensions` 파일을 작성한다. 사실 굳이 이렇게 만든다면 디렉토리를 만들 필요가 없지만, 나중에 어떤 세팅이 또 들어갈지 모르기 때문에 만드는 것이 좋다고 생각한다.

```yml
commands:  
  set_time_zone:  
    command: ln -f -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime
```

## 3. Procfile
**웹 어플리케이션을 구동하기 위해 실행되어야 하는 프로세스의 목록**이다. root에서 Procfile을 만들고, 안에 필요한 세팅을 진행한다.

```yml
web: java -jar todo.jar
```
