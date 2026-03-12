### Question
`api`와 `implementation`의 차이는 무엇이고, 어떤 기준으로 선택하셨나요?

### Answer
`implementation`은 해당 모듈 내부에서만 사용하는 의존성으로, 다른 모듈에 전이되지 않고, `api`는 해당 모듈을 의존하는 다른 모듈에도 전이되는 의존성입니다.
예를 들어 Domain 모듈에서 JPA Entity를 정의할 때 `api`로 선언하면, Domain을 의존하는 Application이나 Infrastructure 모듈에서도 Entity를 직접 사용할 수 있지만, `implementation`으로 선언하면 Domain 내부에서만 사용 가능합니다.
기본적으로 `implementation`을 사용해서 불필요한 의존성 전이를 막고, Domain의 핵심 모델처럼 상위 모듈에서 반드시 알아야 하는 타입들만 `api`로 선언해서 명확한 인터페이스를 제공하도록 했습니다.

### Feedback
`api`와 `implementation`의 차이와 의존성 전이 메커니즘을 정확하게 설명하셨고, 실무적인 선택 기준도 명확합니다. 추가로 `api` 사용 시 빌드 성능에 미치는 영향(하위 모듈 변경 시 상위 모듈도 재컴파일), 그리고 캡슐화 관점에서 `implementation`을 기본으로 사용하는 것의 장점을 언급하면 더욱 완성도 높은 답변이 될 것입니다.

### Recommendation
**`api`와 `implementation`의 차이:**

Gradle에서 `api`와 `implementation`은 모듈 간 의존성 전이(Dependency Transitive)를 제어하는 키워드입니다.

**1. `implementation` (구현 의존성):**
- 해당 모듈 **내부에서만** 사용하는 의존성
- 다른 모듈에 **전이되지 않음** (컴파일 클래스패스에 포함되지 않음)
- 의존성 변경 시 해당 모듈만 재컴파일

**2. `api` (API 의존성):**
- 해당 모듈을 의존하는 다른 모듈에도 **전이되는** 의존성
- 모듈의 public API 일부로 노출됨
- 의존성 변경 시 해당 모듈과 의존하는 모든 모듈이 재컴파일

---

**구체적인 예시:**

```gradle
// domain-module/build.gradle
dependencies {
    // Domain 엔티티와 인터페이스는 다른 모듈에서도 사용해야 하므로 api
    api 'org.projectlombok:lombok:1.18.30'
    
    // 내부 유틸리티는 Domain 내부에서만 사용하므로 implementation
    implementation 'org.apache.commons:commons-lang3:3.12.0'
}
```

```gradle
// application-module/build.gradle
dependencies {
    // Domain 모듈을 api로 선언
    api project(':domain-module')
    
    // Application에서만 사용하는 Spring 기능은 implementation
    implementation 'org.springframework:spring-tx:5.3.0'
}
```

**의존성 전이 예시:**

```
Domain Module (domain-module)
├── api: Lombok
└── implementation: Commons Lang3

Application Module (application-module)
└── api: domain-module

Infrastructure Module (infrastructure-module)
└── implementation: application-module
```

이 구조에서:
- Infrastructure는 Domain의 Lombok을 사용할 수 있음 (Domain → api → Application → api → Infrastructure 전이)
- Infrastructure는 Domain의 Commons Lang3을 사용할 수 없음 (implementation으로 차단)
- Infrastructure는 Application의 Spring TX를 사용할 수 없음 (implementation으로 차단)

---

**실무 적용 사례: Domain 모듈 설계**

```gradle
// domain-module/build.gradle
dependencies {
    // ✅ api: Domain 엔티티와 VO는 다른 레이어에서 참조해야 함
    api 'org.projectlombok:lombok:1.18.30'
    annotationProcessor 'org.projectlombok:lombok:1.18.30'
    
    // ❌ implementation: 내부 유틸리티는 외부에 노출 불필요
    implementation 'org.apache.commons:commons-lang3:3.12.0'
    
    // ❌ implementation: Validation은 Domain 내부에서만 사용
    implementation 'javax.validation:validation-api:2.0.1.Final'
}
```

**잘못된 예시와 개선:**

```gradle
// ❌ 잘못된 예: 모든 의존성을 api로 선언
dependencies {
    api 'org.springframework.boot:spring-boot-starter-data-jpa'
    api 'com.fasterxml.jackson.core:jackson-databind'
}
```

문제점:
1. Domain이 Spring JPA에 강하게 결합됨
2. Domain을 의존하는 모든 모듈이 불필요한 JPA, Jackson 의존성을 갖게 됨
3. 의존성 변경 시 전체 모듈 재컴파일 → 빌드 시간 증가

```gradle
// ✅ 개선된 예: 필요한 것만 노출
dependencies {
    // Domain은 순수 Java 객체로 유지
    api 'org.projectlombok:lombok:1.18.30'
    
    // 구현 세부사항은 숨김
    implementation 'javax.validation:validation-api:2.0.1.Final'
}
```

---

**선택 기준:**

**`implementation` 사용 (기본 선택):**
- 모듈 내부에서만 사용하는 유틸리티 라이브러리
- 구현 세부사항 (예: Jackson, Apache Commons)
- 프레임워크 의존성 (예: Spring Framework)
- **원칙**: 기본적으로 `implementation`을 사용하여 불필요한 전이를 막음

**`api` 사용 (신중하게 선택):**
- 다른 모듈에서 **반드시** 알아야 하는 타입
  - Domain 엔티티, VO, 도메인 이벤트
  - 리포지토리 인터페이스
  - 서비스 인터페이스
- 모듈의 public API 일부로 명시적으로 노출하고 싶은 의존성
- **원칙**: 모듈의 "계약(Contract)" 역할을 하는 타입만 `api`로 선언

---

**실제 프로젝트 적용:**

```gradle
// domain-module/build.gradle
dependencies {
    // Domain 엔티티는 Application, Infrastructure에서 사용 → api
    compileOnly 'org.projectlombok:lombok:1.18.30'
    annotationProcessor 'org.projectlombok:lombok:1.18.30'
}

// application-module/build.gradle
dependencies {
    // Application 서비스는 Web에서 호출 → api
    api project(':domain-module')
    
    // 트랜잭션은 Application 내부 관심사 → implementation
    implementation 'org.springframework:spring-tx:5.3.0'
}

// infrastructure-module/build.gradle
dependencies {
    // Infrastructure는 Domain 인터페이스를 구현 → implementation
    implementation project(':domain-module')
    implementation project(':application-module')
    
    // JPA는 Infrastructure 구현 세부사항 → implementation
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
}

// web-module/build.gradle
dependencies {
    // Controller는 Application 서비스를 호출 → implementation
    implementation project(':application-module')
    
    // 런타임에 Infrastructure 구현체 필요 → runtimeOnly도 고려 가능
    implementation project(':infrastructure-module')
    
    // Spring Web은 Web 레이어 관심사 → implementation
    implementation 'org.springframework.boot:spring-boot-starter-web'
}
```

---

**`api` vs `implementation`의 빌드 성능 영향:**

**`api` 사용 시:**
```
Domain 모듈의 엔티티 변경
  ↓
Application 모듈 재컴파일 필요 (Domain을 api로 의존)
  ↓
Infrastructure 모듈 재컴파일 필요 (Application을 의존)
  ↓
Web 모듈 재컴파일 필요 (Application을 의존)
```
→ 전체 프로젝트 재빌드 (느림)

**`implementation` 사용 시:**
```
Application 모듈의 내부 클래스 변경
  ↓
Application 모듈만 재컴파일
```
→ 변경된 모듈만 재빌드 (빠름)

---

**캡슐화 관점의 장점:**

`implementation`을 기본으로 사용하면:
1. **정보 은닉**: 내부 구현 세부사항이 외부에 노출되지 않음
2. **결합도 감소**: 모듈 간 불필요한 의존성이 생기지 않음
3. **변경 용이성**: 내부 구현 변경 시 다른 모듈에 영향 없음
4. **빌드 최적화**: 변경 범위가 최소화되어 빌드 시간 단축

이러한 원칙을 따라 Multi-Module 프로젝트에서 명확한 모듈 경계와 효율적인 빌드 구조를 유지할 수 있었습니다.
