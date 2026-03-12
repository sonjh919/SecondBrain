[](api와%20implementation%20차이.md)### Question
Multi-Module 구조를 도입한 이유는 무엇이고, 어떻게 모듈을 구성하셨나요?

### Answer
기존 Monolithic 구조에서는 모든 의존성이 하나의 모듈에 집중되어 있고 패키지만으로 레이어를 분리하다 보니, 의존성을 더욱 명확하게 분리해서 책임을 분리하고 싶었습니다.
이를 개선하기 위해 DDD의 Domain Model Pattern을 참고해서 Web - Application - Domain - Infrastructure 구조로 모듈을 분리했고, 각 레이어의 책임을 명확히 하면서 필요한 의존성만 협력하도록 구성했습니다.

### Feedback
기존 구조의 문제점(의존성 혼재)을 명확히 인식하고, DDD를 참고하여 체계적으로 모듈을 분리하신 점이 훌륭합니다. 다만, 각 레이어(Web, Application, Domain, Infrastructure)가 구체적으로 어떤 책임을 가지는지, 그리고 모듈 간 의존 방향과 의존성 제어 규칙(예: Domain이 Infrastructure에 의존하지 않도록)을 어떻게 강제했는지 추가로 설명하면 더욱 완성도 높은 답변이 될 것입니다.

### Recommendation
**Multi-Module 도입 배경:**

이선좌 프로젝트 초기에는 전형적인 Monolithic 단일 모듈 구조로 시작했습니다. 패키지 구조로만 레이어를 분리했는데, 다음과 같은 문제점들이 발생했습니다:

1. **의존성 혼재**: 모든 라이브러리가 하나의 build.gradle에 집중되어, 어떤 레이어가 어떤 의존성을 사용하는지 불명확했습니다. 예를 들어 Domain 레이어가 Spring Web 의존성을 사용할 수 있는 상황이었습니다.

2. **레이어 간 의존 규칙 위반**: 패키지만으로는 컴파일 타임에 의존 방향을 강제할 수 없어, Domain 레이어가 Infrastructure 레이어의 구현체를 직접 참조하는 등의 아키텍처 위반이 발생했습니다.

3. **테스트 복잡도 증가**: 단위 테스트를 작성할 때 불필요한 의존성들까지 함께 로드되어 테스트 실행 속도가 느렸고, 특정 레이어만 독립적으로 테스트하기 어려웠습니다.

4. **책임 분리 모호**: 패키지만으로는 물리적 경계가 명확하지 않아, 개발자들이 레이어의 책임을 무시하고 코드를 작성하는 경우가 있었습니다.

이러한 문제를 해결하기 위해 Multi-Module 구조를 도입하여 **컴파일 타임에 의존성과 레이어 간 경계를 강제**하고, 각 모듈의 책임을 명확히 분리하고자 했습니다.

---

**모듈 구성: DDD Domain Model Pattern 기반**

DDD(Domain-Driven Design)의 Domain Model Pattern과 4-Layered Architecture를 참고하여 다음과 같이 모듈을 설계했습니다:

```
project-root/
├── web-module/          (표현 계층)
├── application-module/  (응용 계층)
├── domain-module/       (도메인 계층)
└── infrastructure-module/ (인프라 계층)
```

**1. Domain Module (도메인 계층)**
- **책임**: 비즈니스 로직과 도메인 규칙을 담당하는 핵심 모듈
- **포함 요소**:
  - 엔티티 (Entity): 비즈니스 식별자를 가진 객체
  - 값 객체 (Value Object): 식별자 없이 속성으로 구별되는 객체
  - 도메인 서비스: 엔티티나 VO에 속하지 않는 비즈니스 로직
  - 리포지토리 인터페이스: 영속성 추상화
- **의존성**: 순수 Java만 사용, **외부 프레임워크 의존성 없음**
- **원칙**: 다른 어떤 모듈에도 의존하지 않음 (가장 핵심적이고 독립적)

```java
// domain-module
public class Ticket {
    private TicketId id;
    private Money price;
    private TicketStatus status;
    
    public void reserve() {
        if (!this.status.isAvailable()) {
            throw new TicketNotAvailableException();
        }
        this.status = TicketStatus.RESERVED;
    }
}

public interface TicketRepository {
    Ticket findById(TicketId id);
    void save(Ticket ticket);
}
```

**2. Application Module (응용 계층)**
- **책임**: 유스케이스 구현, 도메인 객체 조율, 트랜잭션 관리
- **포함 요소**:
  - 애플리케이션 서비스: 유스케이스를 구현하고 도메인 객체를 조율
  - DTO (Data Transfer Object): 계층 간 데이터 전달
- **의존성**: Domain Module, Spring Core (트랜잭션)
- **원칙**: Domain에 의존하지만, Web/Infrastructure에는 의존하지 않음

```java
// application-module
@Service
@Transactional
public class TicketReservationService {
    private final TicketRepository ticketRepository;
    
    public ReservationResult reserve(ReserveTicketCommand command) {
        Ticket ticket = ticketRepository.findById(command.getTicketId());
        ticket.reserve();
        ticketRepository.save(ticket);
        return ReservationResult.from(ticket);
    }
}
```

**3. Infrastructure Module (인프라 계층)**
- **책임**: 외부 시스템과의 통신, 영속성 구현
- **포함 요소**:
  - JPA 엔티티 및 리포지토리 구현체
  - 외부 API 클라이언트
  - 메시징, 캐시 등 기술적 구현
- **의존성**: Domain Module, Application Module, Spring Data JPA, 외부 라이브러리
- **원칙**: Domain의 인터페이스를 구현하여 의존성 역전 (Dependency Inversion)

```java
// infrastructure-module
@Repository
public class JpaTicketRepository implements TicketRepository {
    private final TicketJpaRepository jpaRepository;
    
    @Override
    public Ticket findById(TicketId id) {
        TicketEntity entity = jpaRepository.findById(id.getValue())
            .orElseThrow(TicketNotFoundException::new);
        return entity.toDomain();
    }
}
```

**4. Web Module (표현 계층)**
- **책임**: HTTP 요청/응답 처리, 인증/인가, API 문서화
- **포함 요소**:
  - REST Controller
  - Request/Response DTO
  - 예외 핸들러
  - Spring Security 설정
- **의존성**: Application Module, Spring Web, Spring Security
- **원칙**: Application에 의존하지만, Domain/Infrastructure의 구체적 구현에는 의존하지 않음

```java
// web-module
@RestController
@RequestMapping("/api/tickets")
public class TicketController {
    private final TicketReservationService reservationService;
    
    @PostMapping("/{ticketId}/reserve")
    public ResponseEntity<ReservationResponse> reserve(
        @PathVariable Long ticketId,
        @RequestBody ReserveRequest request
    ) {
        ReserveTicketCommand command = request.toCommand(ticketId);
        ReservationResult result = reservationService.reserve(command);
        return ResponseEntity.ok(ReservationResponse.from(result));
    }
}
```

---

**모듈 간 의존성 제어:**

Gradle의 `api`와 `implementation`을 활용하여 의존성 전이를 제어했습니다:

```gradle
// domain-module/build.gradle
dependencies {
    // 순수 Java만 사용, 외부 프레임워크 의존성 없음
}

// application-module/build.gradle
dependencies {
    api project(':domain-module')  // domain을 외부에 노출
    implementation 'org.springframework:spring-tx'
}

// infrastructure-module/build.gradle
dependencies {
    implementation project(':domain-module')
    implementation project(':application-module')
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
}

// web-module/build.gradle
dependencies {
    implementation project(':application-module')
    implementation project(':infrastructure-module')  // 런타임 구현체 제공
    implementation 'org.springframework.boot:spring-boot-starter-web'
}
```

이러한 구조로 다음과 같은 의존 방향을 강제했습니다:
```
Web → Application → Domain ← Infrastructure
```

Domain은 어떤 모듈에도 의존하지 않고, Infrastructure는 Domain의 인터페이스를 구현하여 의존성 역전 원칙(DIP)을 준수했습니다.

---

**Multi-Module의 효과:**

1. **명확한 책임 분리**: 각 모듈이 단일 책임을 가지며, 컴파일 타임에 경계가 강제됨
2. **의존성 제어**: Domain 모듈은 프레임워크에 독립적이며, 핵심 비즈니스 로직만 집중
3. **독립적 테스트**: Domain 모듈은 순수 Java 단위 테스트, Application은 통합 테스트로 분리 가능
4. **재사용성 향상**: 잘 설계된 Domain 모듈은 다른 프로젝트에서도 재사용 가능
5. **빌드 최적화**: 변경된 모듈만 재빌드하여 빌드 시간 단축

Multi-Module 구조를 통해 코드의 유지보수성과 확장성을 크게 향상시킬 수 있었습니다.
