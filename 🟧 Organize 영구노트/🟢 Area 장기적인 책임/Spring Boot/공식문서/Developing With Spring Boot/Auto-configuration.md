#SpringBoot #공식문서 

+ 스프링 부트 auto-configuration은 추가된 jar dependency를 기반으로 스프링 애플리케이션을 자동으로 구성하려고 시도한다.
+ `@Configuration` 클래스를 `@EnableAutoConfiguration` 또는 `@SpringBootApplication`에 추가하여 auto-configuration에 옵트인해야 한다.
> [!tip]+ 
> 일반적으로 둘 중 하나만 추가해야 한다.

### Gradually Replacing Auto-configuration
+ 언제든지, 자동 구성의 특정 부분을 대체하기 위해 직접 설정을 정의할 수 있다.

> [!example]+ 
> 예를 들어, 직접 DataSource 빈을 등록하면, 기본적으로 제공되는 임베디드 데이터베이스 지원은 자동으로 비활성화된다.


### Disabling Specific Auto-configuration Classes
+ `@SpringBootApplication`의 exclude 속성을 사용하여 특정 configuration을 비활성화할 수 있다.

```java
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class MyApplication {

}
```

> [!tip]+ 
> 클래스가 클래스 경로에 있지 않은 경우 주석의 excludeName 속성을 사용하고 대신 정규화된 이름을 지정할 수 있다.

### Auto-configuration Packages
- Auto-configuration Package는 스프링 부트가 자동으로 스캔하는 기준이 되는 패키지입니다.
- `@SpringBootApplication` 또는 `@EnableAutoConfiguration`이 위치한 패키지가 기본값이 되며, 필요하다면 `@AutoConfigurationPackage`로 추가 패키지를 지정할 수 있습니다.