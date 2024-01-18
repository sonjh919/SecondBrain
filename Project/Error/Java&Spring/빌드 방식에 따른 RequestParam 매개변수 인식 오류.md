---
title: RequestParam 매개변수 인식 오류
date: 2024-01-18 16:24
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## RequestParam 매개변수 인식 오류
흔한 코딩을 하던 도중, 흔하지 않은 오류가 생겨버렸다.
분명 코드는 깔끔했으나, 실행되는 경우도 있었고, 500에러가 뜨는 경우도 있었다.

![[requestparam.png]]

> java.lang.IllegalArgumentException: Name for argument of type [java.lang.String] not specified, and parameter name information not found in class file either.

### (일단) 해결책
찾아보니 2가지 해결책이 있는데, 첫번째 방법은 버전 변경이다. Spring boot 3.2버전에서는 이름을 필수로 적어주어야 하기 때문에, 다른 버전을 사용하면 된다.

`@RequestParam("name") String name`  다음과 같이 변경해주면 되는데, @PathVariable, @Autowired 등에서도 같은 오류가 발생한다.

두번째 방법은 빌드 방식을 Intellij에서 Gradle로 바꾸는 것이다. 바꾸었더니 버전 상관없이 잘 동작하는 것을 볼 수 있었다.

### Intellij 빌드 방식과 Gradle 빌드 방식?
하지만 여기서 끝내기에는 Intellij와 Gradle의 차이가 궁금해졌다. 과연 어떤 차이가 있길래 Intellij 내부 빌드 툴을 쓰면 안되고, Gradle 빌드는 되는 걸까?

### debugging enabled
Spring Document에 다음과 같은 내용이 있다.

> The matching of method parameter names to URI Template variable names can only be done if your code is compiled with debugging enabled. If you do have not debugging enabled, you must specify the name of the URI Template variable name to bind to in the @PathVariable annotation

컴파일할 때 debugging enabled 상태이지 않은 경우는 name에 값을 줘야 한다고 명시되어 있었다.
debugging enabled는 또 무엇일까..?
java를 컴파일할 때 사용하는 javac 명령어에는 -g 옵션이 있다. 이를 사용할 경우 로컬 지역변수를 포함한 debugging information을 생성하고 디폴트는 라인 넘버와 소스파일 정보만 생성된다고 한다.

아마 Intellij 빌드 에는 -g 옵션이 없고, gradle 빌드는 옵션이 있나 보다 하는 생각이 들었다.

### gradle에는 -g 세팅이 되어있을까?
그럼 이제 문제를 안 것 같으니, Intellij와 gradle에 진짜 옵션이 있는지 한번 찾아보자.

일단 groovy 언어로 세팅을 하고 싶다면, 다음과 같이 세팅하면 된다.

```groovy
tasks.withType(JavaCompile) {
    options.debug = false
}
```

+ 하지만 gradle에서는 자동으로 debug 옵션을 세팅해준다고 한다!
+ 메서드들의 내용을 보면 Defaults to `true`로 명시되어 있는 것을 볼 수 있었다.

+ 출처 : https://docs.gradle.org/current/javadoc/org/gradle/api/tasks/compile/CompileOptions.html#setDebug-boolean-

![[isDebug.png]]

### Intellij는 어떨까?
+ If라는 것으로 보아, 디폴트 옵션은 아닌 듯하고 따로 설정해야 하는 것 같다.
+ 출처 : https://www.jetbrains.com/help/idea/java-compiler.html#javac_eclipse

![[Intellijdebug.png]]

## 결론
디버깅 옵션 때문에 일어난 일이었다. 우리 모두 gradle을 쓰도록 하자. 찾아보면서 알았지만 Intellij는 빠르지만 증분 빌드(incremental build)때문에 지운 파일에서 에러가 생기는 경우도 생긴다고 한다.