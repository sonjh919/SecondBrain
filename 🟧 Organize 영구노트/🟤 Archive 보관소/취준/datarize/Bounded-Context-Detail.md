# Bounded Context 상세 설계

> 작성일: 2026-01-10
> 관련 문서: Event-Storming-Design.md

## 목차
1. [Seat Management Context 상세](#seat-management-context-상세)
2. [Reservation Context 상세](#reservation-context-상세)
3. [도메인 서비스 설계](#도메인-서비스-설계)
4. [Repository 설계](#repository-설계)

---

## Seat Management Context 상세

### 핵심 책임
- 좌석 배치 관리 (공연장 레이아웃)
- 좌석 가용성 관리
- 임시 점유(5분) 프로세스 관리
- 커플석 규칙 검증

### 도메인 모델

#### Seat (좌석)

```java
/**
 * 좌석 Aggregate Root
 * 
 * 불변식:
 * - 예약 가능 상태에서만 점유 가능
 * - 이미 예약된 좌석은 해제 전까지 변경 불가
 */
@Entity
@Table(name = "seats")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Seat {
    
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "performance_id")
    private Performance performance;
    
    @Embedded
    private SeatPosition position;
    
    @Enumerated(EnumType.STRING)
    private SeatStatus status;
    
    public Seat(Performance performance, SeatPosition position) {
        this.performance = performance;
        this.position = position;
        this.status = SeatStatus.AVAILABLE;
    }
    
    // 도메인 로직
    public boolean isAvailable() {
        return status == SeatStatus.AVAILABLE;
    }
    
    public void reserve() {
        if (!isAvailable()) {
            throw new SeatNotAvailableException("이미 예약된 좌석입니다.");
        }
        this.status = SeatStatus.RESERVED;
    }
    
    public void release() {
        this.status = SeatStatus.AVAILABLE;
    }
    
    // 위치 정보 위임
    public SeatGrade getGrade() {
        return position.getGrade();
    }
    
    public SeatCategory getCategory() {
        return position.getCategory();
    }
    
    public int getPrice(Show show) {
        return getGrade().getPrice(show);
    }
}

public enum SeatStatus {
    AVAILABLE("예약 가능"),
    RESERVED("예약 완료");
    
    private final String description;
    
    SeatStatus(String description) {
        this.description = description;
    }
}
```

#### SeatPosition (값 객체)

```java
/**
 * 좌석 위치 값 객체
 * 
 * 불변식:
 * - 행은 1~20 범위
 * - 열은 1~20 범위
 */
@Embeddable
@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SeatPosition {
    
    @Column(name = "row_number")
    private int row;
    
    @Column(name = "column_number")
    private int column;
    
    public SeatPosition(int row, int column) {
        validate(row, column);
        this.row = row;
        this.column = column;
    }
    
    private void validate(int row, int column) {
        if (row < 1 || row > 20) {
            throw new InvalidSeatPositionException("행은 1~20 사이여야 합니다.");
        }
        if (column < 1 || column > 20) {
            throw new InvalidSeatPositionException("열은 1~20 사이여야 합니다.");
        }
    }
    
    // 도메인 로직
    public SeatGrade getGrade() {
        return SeatGrade.fromRow(this.row);
    }
    
    public SeatCategory getCategory() {
        return SeatCategory.fromColumn(this.column);
    }
    
    public boolean isCoupleArea() {
        return column == 19 || column == 20;
    }
    
    public SeatPosition getPairPosition() {
        if (!isCoupleArea()) {
            throw new NotCoupleSeatException("커플석이 아닙니다.");
        }
        int pairColumn = (column == 19) ? 20 : 19;
        return new SeatPosition(row, pairColumn);
    }
    
    public boolean isSameRow(SeatPosition other) {
        return this.row == other.row;
    }
}
```

#### SeatOccupancy (좌석 점유)

```java
/**
 * 좌석 점유 Aggregate Root
 * 
 * 불변식:
 * - 점유는 5분 제한
 * - 같은 좌석에 활성 점유는 1개만 존재
 * - 사용자당 회차별 최대 5석까지만 점유 가능
 */
@Entity
@Table(name = "seat_occupancies")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SeatOccupancy extends BaseEntity {
    
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seat_id")
    private Seat seat;
    
    private Long userId;  // User Context와 느슨한 결합
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "performance_id")
    private Performance performance;
    
    @Embedded
    private OccupancyPeriod period;
    
    @Enumerated(EnumType.STRING)
    private OccupancyStatus status;
    
    public SeatOccupancy(Seat seat, Long userId, Performance performance) {
        validateSeatAvailable(seat);
        this.seat = seat;
        this.userId = userId;
        this.performance = performance;
        this.period = OccupancyPeriod.ofMinutes(5);
        this.status = OccupancyStatus.ACTIVE;
    }
    
    private void validateSeatAvailable(Seat seat) {
        if (!seat.isAvailable()) {
            throw new SeatNotAvailableException("예약 가능한 좌석이 아닙니다.");
        }
    }
    
    // 도메인 로직
    public boolean isActive() {
        return status == OccupancyStatus.ACTIVE && !period.isExpired();
    }
    
    public void expire() {
        if (status != OccupancyStatus.ACTIVE) {
            throw new IllegalStateException("활성 상태가 아닙니다.");
        }
        this.status = OccupancyStatus.EXPIRED;
        registerEvent(new OccupancyExpired(this.id, this.seat.getId(), this.userId));
    }
    
    public void confirm() {
        if (!isActive()) {
            throw new OccupancyExpiredException("만료된 점유입니다.");
        }
        this.status = OccupancyStatus.CONFIRMED;
    }
    
    // 도메인 이벤트 발행
    public void occupy() {
        registerEvent(new SeatsOccupied(
            this.id,
            List.of(this.seat.getId()),
            this.userId,
            this.performance.getId(),
            this.period.getStartedAt(),
            this.period.getExpiresAt()
        ));
    }
}

public enum OccupancyStatus {
    ACTIVE("활성"),
    EXPIRED("만료"),
    CONFIRMED("확정");
    
    private final String description;
    
    OccupancyStatus(String description) {
        this.description = description;
    }
}
```

#### OccupancyPeriod (값 객체)

```java
/**
 * 점유 기간 값 객체
 * 
 * 불변
 */
@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class OccupancyPeriod {
    
    @Column(name = "started_at")
    private LocalDateTime startedAt;
    
    @Column(name = "expires_at")
    private LocalDateTime expiresAt;
    
    public static OccupancyPeriod ofMinutes(int minutes) {
        LocalDateTime now = LocalDateTime.now();
        return new OccupancyPeriod(now, now.plusMinutes(minutes));
    }
    
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }
    
    public Duration getRemainingTime() {
        if (isExpired()) {
            return Duration.ZERO;
        }
        return Duration.between(LocalDateTime.now(), expiresAt);
    }
}
```

---

## Reservation Context 상세

### 핵심 책임
- 예약 확정 및 관리
- 결제 정보 관리
- 할인 정책 적용
- 예약 취소 처리

### 도메인 모델

#### Reservation (예약)

```java
/**
 * 예약 Aggregate Root
 * 
 * 불변식:
 * - 예약은 활성 점유에서만 생성 가능
 * - 모든 점유된 좌석을 한 번에 예약
 * - 공연 시작 전까지만 취소 가능
 */
@Entity
@Table(name = "reservations")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Reservation extends BaseEntity {
    
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private Long userId;
    private Long performanceId;
    
    @OneToMany(mappedBy = "reservation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ReservedSeat> seats = new ArrayList<>();
    
    @Embedded
    private Payment payment;
    
    @Embedded
    private PriceBreakdown priceBreakdown;
    
    private LocalDateTime reservedAt;
    
    @Enumerated(EnumType.STRING)
    private ReservationStatus status;
    
    // Factory Method
    public static Reservation create(
            Long userId,
            Performance performance,
            List<SeatOccupancy> occupancies,
            User user,
            CardCompany cardCompany) {
        
        // 1. 점유 상태 검증
        validateOccupancies(occupancies);
        
        // 2. 가격 계산
        DiscountContext discountContext = DiscountContext.of(
            performance.isEarlyBird(),
            user.isYouth(performance.getDate()),
            cardCompany
        );
        
        PriceCalculator calculator = new PriceCalculator();
        PriceBreakdown breakdown = calculator.calculate(
            occupancies,
            performance.getShow(),
            discountContext
        );
        
        // 3. 예약 생성
        Reservation reservation = new Reservation();
        reservation.userId = userId;
        reservation.performanceId = performance.getId();
        reservation.payment = new Payment(cardCompany, breakdown.getFinalAmount());
        reservation.priceBreakdown = breakdown;
        reservation.reservedAt = LocalDateTime.now();
        reservation.status = ReservationStatus.CONFIRMED;
        
        // 4. 좌석 정보 스냅샷
        occupancies.forEach(occ -> {
            ReservedSeat reservedSeat = ReservedSeat.from(
                occ.getSeat(),
                breakdown.getPriceFor(occ.getSeat().getGrade())
            );
            reservedSeat.assignTo(reservation);
            reservation.seats.add(reservedSeat);
        });
        
        // 5. 도메인 이벤트 발행
        reservation.registerEvent(new ReservationConfirmed(
            reservation.id,
            reservation.seats.stream()
                .map(ReservedSeat::getSeatId)
                .toList(),
            userId,
            performance.getId()
        ));
        
        return reservation;
    }
    
    private static void validateOccupancies(List<SeatOccupancy> occupancies) {
        if (occupancies.isEmpty()) {
            throw new NoOccupancyException("점유된 좌석이 없습니다.");
        }
        
        occupancies.forEach(occ -> {
            if (!occ.isActive()) {
                throw new OccupancyExpiredException("만료된 점유가 포함되어 있습니다.");
            }
        });
    }
    
    // 도메인 로직
    public void cancel(Performance performance) {
        if (status == ReservationStatus.CANCELLED) {
            throw new AlreadyCancelledException("이미 취소된 예약입니다.");
        }
        
        if (performance.hasStarted()) {
            throw new CannotCancelException("공연이 시작되어 취소할 수 없습니다.");
        }
        
        this.status = ReservationStatus.CANCELLED;
        
        registerEvent(new ReservationCancelled(
            this.id,
            this.seats.stream().map(ReservedSeat::getSeatId).toList()
        ));
    }
    
    public int getTotalAmount() {
        return priceBreakdown.getFinalAmount();
    }
}

public enum ReservationStatus {
    CONFIRMED("확정"),
    CANCELLED("취소");
    
    private final String description;
    
    ReservationStatus(String description) {
        this.description = description;
    }
}
```

#### ReservedSeat (예약된 좌석)

```java
/**
 * 예약된 좌석 엔티티
 * 
 * 예약 시점의 좌석 정보를 불변 스냅샷으로 저장
 */
@Entity
@Table(name = "reserved_seats")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReservedSeat {
    
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reservation_id")
    private Reservation reservation;
    
    private Long seatId;  // 참조용 ID (FK 아님)
    
    @Embedded
    private SeatPosition position;  // 스냅샷
    
    @Enumerated(EnumType.STRING)
    private SeatGrade grade;  // 스냅샷
    
    private int price;  // 스냅샷
    
    public static ReservedSeat from(Seat seat, int price) {
        ReservedSeat reservedSeat = new ReservedSeat();
        reservedSeat.seatId = seat.getId();
        reservedSeat.position = seat.getPosition();
        reservedSeat.grade = seat.getGrade();
        reservedSeat.price = price;
        return reservedSeat;
    }
    
    void assignTo(Reservation reservation) {
        this.reservation = reservation;
    }
}
```

#### 값 객체들

```java
/**
 * 결제 정보 값 객체
 */
@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Payment {
    
    @Enumerated(EnumType.STRING)
    private CardCompany cardCompany;
    
    private int amount;
    
    @Column(name = "paid_at")
    private LocalDateTime paidAt;
    
    public Payment(CardCompany cardCompany, int amount) {
        this.cardCompany = cardCompany;
        this.amount = amount;
        this.paidAt = LocalDateTime.now();
    }
}

/**
 * 가격 구성 값 객체
 */
@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class PriceBreakdown {
    
    private int originalAmount;      // 원가
    private int earlyBirdDiscount;   // 조조 할인액
    private int youthDiscount;       // 청소년 할인액
    private int cardDiscount;        // 카드 할인액
    
    public int getFinalAmount() {
        return originalAmount - earlyBirdDiscount - youthDiscount - cardDiscount;
    }
    
    public int getTotalDiscount() {
        return earlyBirdDiscount + youthDiscount + cardDiscount;
    }
    
    public int getPriceFor(SeatGrade grade) {
        // 등급별 가격 계산 (할인 비율 적용)
        // 간단하게는 평균 할인율 적용
        return (int) (originalAmount * (1.0 - (double) getTotalDiscount() / originalAmount));
    }
}

/**
 * 할인 컨텍스트 값 객체
 */
@Value
public class DiscountContext {
    boolean isEarlyBird;
    boolean isYouth;
    CardCompany cardCompany;
    
    public static DiscountContext of(
            boolean isEarlyBird,
            boolean isYouth,
            CardCompany cardCompany) {
        return new DiscountContext(isEarlyBird, isYouth, cardCompany);
    }
    
    public boolean hasCardDiscount() {
        return cardCompany == CardCompany.SHINHAN 
            || cardCompany == CardCompany.KB 
            || cardCompany == CardCompany.WOORI;
    }
}
```

---

## 도메인 서비스 설계

### CoupleSeatValidator (커플석 검증)

```java
/**
 * 커플석 규칙 검증 도메인 서비스
 */
@Component
public class CoupleSeatValidator {
    
    public void validate(List<SeatPosition> positions) {
        Set<SeatPosition> couplePositions = positions.stream()
            .filter(SeatPosition::isCoupleArea)
            .collect(Collectors.toSet());
        
        if (couplePositions.isEmpty()) {
            return;  // 커플석이 없으면 검증 불필요
        }
        
        for (SeatPosition position : couplePositions) {
            SeatPosition pair = position.getPairPosition();
            if (!couplePositions.contains(pair)) {
                throw new IncompleteCoupleSeatsException(
                    String.format("커플석 %d행 %d열은 %d열과 함께 선택해야 합니다.",
                        position.getRow(), position.getColumn(), pair.getColumn())
                );
            }
        }
    }
}
```

### PriceCalculator (가격 계산)

```java
/**
 * 할인 정책 적용 및 가격 계산 도메인 서비스
 */
@Component
public class PriceCalculator {
    
    public PriceBreakdown calculate(
            List<SeatOccupancy> occupancies,
            Show show,
            DiscountContext context) {
        
        // 1. 원가 계산
        int originalAmount = occupancies.stream()
            .mapToInt(occ -> occ.getSeat().getPrice(show))
            .sum();
        
        // 2. 조조 할인 계산 (원가의 10%)
        int earlyBirdDiscount = context.isEarlyBird() 
            ? (int) (originalAmount * 0.1) 
            : 0;
        
        // 3. 청소년 할인 계산 (원가의 20%)
        int youthDiscount = context.isYouth() 
            ? (int) (originalAmount * 0.2) 
            : 0;
        
        // 4. 중간 금액 계산
        int intermediateAmount = originalAmount - earlyBirdDiscount - youthDiscount;
        
        // 5. 카드 할인 계산 (중간 금액의 5%)
        int cardDiscount = context.hasCardDiscount() 
            ? (int) (intermediateAmount * 0.05) 
            : 0;
        
        return new PriceBreakdown(
            originalAmount,
            earlyBirdDiscount,
            youthDiscount,
            cardDiscount
        );
    }
}
```

---

## Repository 설계

### SeatRepository

```java
public interface SeatRepository extends JpaRepository<Seat, Long> {
    
    /**
     * 특정 회차의 모든 좌석 조회
     */
    List<Seat> findByPerformanceId(Long performanceId);
    
    /**
     * 비관적 락으로 좌석 조회 (동시성 제어)
     */
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT s FROM Seat s WHERE s.id IN :ids")
    List<Seat> findByIdsWithLock(@Param("ids") List<Long> ids);
    
    /**
     * 특정 회차의 예약 가능한 좌석만 조회
     */
    @Query("SELECT s FROM Seat s WHERE s.performance.id = :performanceId AND s.status = 'AVAILABLE'")
    List<Seat> findAvailableByPerformanceId(@Param("performanceId") Long performanceId);
}
```

### SeatOccupancyRepository

```java
public interface SeatOccupancyRepository extends JpaRepository<SeatOccupancy, Long> {
    
    /**
     * 사용자의 특정 회차 활성 점유 조회
     */
    @Query("""
        SELECT so FROM SeatOccupancy so 
        WHERE so.userId = :userId 
          AND so.performance.id = :performanceId 
          AND so.status = 'ACTIVE'
        """)
    List<SeatOccupancy> findActiveByUserAndPerformance(
        @Param("userId") Long userId,
        @Param("performanceId") Long performanceId
    );
    
    /**
     * 만료된 점유 조회
     */
    @Query("""
        SELECT so FROM SeatOccupancy so 
        WHERE so.status = 'ACTIVE' 
          AND so.period.expiresAt < :now
        """)
    List<SeatOccupancy> findExpired(@Param("now") LocalDateTime now);
    
    /**
     * 특정 좌석의 활성 점유 존재 여부
     */
    @Query("""
        SELECT COUNT(so) > 0 FROM SeatOccupancy so 
        WHERE so.seat.id = :seatId 
          AND so.status = 'ACTIVE' 
          AND so.period.expiresAt > :now
        """)
    boolean existsActiveBySeatId(
        @Param("seatId") Long seatId,
        @Param("now") LocalDateTime now
    );
}
```

### ReservationRepository

```java
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    
    /**
     * 사용자의 모든 예약 조회
     */
    List<Reservation> findByUserIdOrderByReservedAtDesc(Long userId);
    
    /**
     * 사용자의 확정된 예약만 조회
     */
    @Query("""
        SELECT r FROM Reservation r 
        WHERE r.userId = :userId 
          AND r.status = 'CONFIRMED' 
        ORDER BY r.reservedAt DESC
        """)
    List<Reservation> findConfirmedByUserId(@Param("userId") Long userId);
    
    /**
     * 특정 회차의 모든 예약 조회
     */
    List<Reservation> findByPerformanceId(Long performanceId);
}
```

---

## 다음 단계

- [ ] Application Service 설계
- [ ] DTO 설계
- [ ] API 명세 작성
- [ ] 예외 처리 전략
- [ ] 테스트 시나리오 작성
