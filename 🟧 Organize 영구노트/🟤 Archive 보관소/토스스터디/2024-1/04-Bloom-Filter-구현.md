# Bloom Filter 구현

## 개요
100명 이상 사용 중인 비밀번호를 효율적으로 필터링하기 위한 Bloom Filter 구현입니다.

## Bloom Filter 기본 개념

### 작동 원리
```
1. 요소 추가: k개의 해시 함수로 비트 배열의 k개 위치를 1로 설정
2. 요소 확인: k개의 해시 함수로 비트 배열 확인
   - 모든 위치가 1 → "있을 수 있음" (might contain)
   - 하나라도 0 → "확실히 없음" (definitely not)
```

### 특징
- ✅ **메모리 효율**: 실제 데이터 저장 없이 비트만 사용
- ✅ **빠른 속도**: O(k) 시간 복잡도
- ✅ **확실한 음성**: "없다"는 100% 정확
- ⚠️ **False Positive**: "있다"가 틀릴 수 있음 (1% 정도)
- ❌ **삭제 불가**: 기본 Bloom Filter는 삭제 미지원

---

## 1. Guava Bloom Filter 구현

### 의존성 추가

```xml
<!-- pom.xml -->
<dependency>
    <groupId>com.google.guava</groupId>
    <artifactId>guava</artifactId>
    <version>32.1.3-jre</version>
</dependency>
```

### 기본 구현

```java
@Component
@Slf4j
public class CommonPasswordBloomFilter {
    
    private BloomFilter<String> filter;
    
    // 예상 항목 수: 10만 개 (100명 이상 사용하는 비밀번호)
    private static final int EXPECTED_INSERTIONS = 100_000;
    
    // 허용 가능한 오탐율: 1%
    private static final double FALSE_POSITIVE_RATE = 0.01;
    
    @PostConstruct
    public void initialize() {
        log.info("Initializing Bloom Filter for common passwords");
        
        filter = BloomFilter.create(
            Funnels.stringFunnel(StandardCharsets.UTF_8),
            EXPECTED_INSERTIONS,
            FALSE_POSITIVE_RATE
        );
        
        loadCommonPasswords();
        
        log.info("Bloom Filter initialized with {} expected insertions, {:.2f}% FPP",
                 EXPECTED_INSERTIONS, FALSE_POSITIVE_RATE * 100);
    }
    
    /**
     * 100명 이상 사용하는 비밀번호 로드
     */
    private void loadCommonPasswords() {
        List<String> commonPasswords = passwordUsageRepository
            .findPasswordHashesWithUsageGreaterThan(100);
        
        for (String passwordHash : commonPasswords) {
            filter.put(passwordHash);
        }
        
        log.info("Loaded {} common passwords into Bloom Filter", 
                 commonPasswords.size());
    }
    
    /**
     * 비밀번호가 흔한지 확인
     * 
     * @return true: 100명 이상 사용 가능성 있음 (DB 확인 필요)
     *         false: 확실히 100명 미만 사용 (통과)
     */
    public boolean mightBeCommonPassword(String passwordHash) {
        return filter.mightContain(passwordHash);
    }
    
    /**
     * 새로운 흔한 비밀번호 추가
     */
    public void addCommonPassword(String passwordHash) {
        filter.put(passwordHash);
        log.debug("Added password to Bloom Filter: {}", 
                  passwordHash.substring(0, 8) + "...");
    }
    
    /**
     * Bloom Filter 통계 조회
     */
    public BloomFilterStats getStats() {
        return BloomFilterStats.builder()
            .expectedInsertions(EXPECTED_INSERTIONS)
            .falsePositiveRate(FALSE_POSITIVE_RATE)
            .approximateElementCount(filter.approximateElementCount())
            .build();
    }
    
    /**
     * 필터 교체 (원자적)
     */
    public synchronized void replaceFilter(BloomFilter<String> newFilter) {
        this.filter = newFilter;
        log.info("Bloom Filter replaced");
    }
}
```

---

## 2. Bloom Filter 재구축 전략

### 주기적 재구축

```java
@Component
public class BloomFilterRebuilder {
    
    private final CommonPasswordBloomFilter bloomFilter;
    private final PasswordUsageCountRepository repository;
    
    /**
     * 매일 새벽 4시 Bloom Filter 재구축
     */
    @Scheduled(cron = "0 0 4 * * *")
    public void rebuildBloomFilter() {
        log.info("Starting Bloom Filter rebuild");
        
        long startTime = System.currentTimeMillis();
        
        // 1. 새로운 Bloom Filter 생성
        BloomFilter<String> newFilter = BloomFilter.create(
            Funnels.stringFunnel(StandardCharsets.UTF_8),
            100_000,
            0.01
        );
        
        // 2. 100명 이상 사용 비밀번호 조회 및 추가
        List<String> commonPasswords = repository
            .findPasswordHashesWithUsageGreaterThan(100);
        
        for (String passwordHash : commonPasswords) {
            newFilter.put(passwordHash);
        }
        
        // 3. 원자적으로 교체
        bloomFilter.replaceFilter(newFilter);
        
        long duration = System.currentTimeMillis() - startTime;
        log.info("Bloom Filter rebuilt in {}ms with {} passwords",
                 duration, commonPasswords.size());
    }
    
    /**
     * 즉시 재구축 (관리자 API 용)
     */
    public void rebuildNow() {
        rebuildBloomFilter();
    }
}
```

### 증분 업데이트

```java
@Component
public class BloomFilterIncrementalUpdater {
    
    private final CommonPasswordBloomFilter bloomFilter;
    
    /**
     * 비밀번호 사용 횟수가 100회 도달 시 Bloom Filter 추가
     */
    @EventListener
    @Async
    public void onPasswordUsageReached100(PasswordUsageThresholdEvent event) {
        if (event.getNewCount() >= 100 && event.getOldCount() < 100) {
            bloomFilter.addCommonPassword(event.getPasswordHash());
            
            log.info("Password reached 100 users, added to Bloom Filter");
        }
    }
}
```

---

## 3. 고급 구현: Scalable Bloom Filter

### 동적 확장 가능한 Bloom Filter

```java
@Component
public class ScalableBloomFilter {
    
    private final List<BloomFilter<String>> filters = new CopyOnWriteArrayList<>();
    private BloomFilter<String> currentFilter;
    
    private static final int INITIAL_CAPACITY = 50_000;
    private static final double FPP = 0.01;
    private static final int THRESHOLD = 45_000; // 90% 도달 시 확장
    
    @PostConstruct
    public void initialize() {
        currentFilter = createNewFilter();
        filters.add(currentFilter);
    }
    
    private BloomFilter<String> createNewFilter() {
        return BloomFilter.create(
            Funnels.stringFunnel(StandardCharsets.UTF_8),
            INITIAL_CAPACITY,
            FPP
        );
    }
    
    /**
     * 요소 추가 (자동 확장)
     */
    public synchronized void put(String passwordHash) {
        // 현재 필터가 거의 찼으면 새 필터 생성
        if (currentFilter.approximateElementCount() >= THRESHOLD) {
            log.info("Current Bloom Filter reaching capacity, creating new one");
            
            BloomFilter<String> newFilter = createNewFilter();
            filters.add(newFilter);
            currentFilter = newFilter;
        }
        
        currentFilter.put(passwordHash);
    }
    
    /**
     * 요소 확인 (모든 필터 체크)
     */
    public boolean mightContain(String passwordHash) {
        for (BloomFilter<String> filter : filters) {
            if (filter.mightContain(passwordHash)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * 총 요소 수 추정
     */
    public long approximateElementCount() {
        return filters.stream()
            .mapToLong(BloomFilter::approximateElementCount)
            .sum();
    }
}
```

---

## 4. 커스텀 Bloom Filter 구현

### 비트 배열 기반 직접 구현

```java
public class CustomBloomFilter {
    
    private final BitSet bitSet;
    private final int numHashFunctions;
    private final int bitArraySize;
    
    public CustomBloomFilter(int expectedInsertions, double falsePositiveRate) {
        // 최적 비트 배열 크기: m = -n * ln(p) / (ln(2)^2)
        this.bitArraySize = optimalNumOfBits(expectedInsertions, falsePositiveRate);
        
        // 최적 해시 함수 개수: k = (m/n) * ln(2)
        this.numHashFunctions = optimalNumOfHashFunctions(expectedInsertions, bitArraySize);
        
        this.bitSet = new BitSet(bitArraySize);
    }
    
    /**
     * 최적 비트 배열 크기 계산
     */
    private int optimalNumOfBits(int n, double p) {
        return (int) Math.ceil(-n * Math.log(p) / (Math.log(2) * Math.log(2)));
    }
    
    /**
     * 최적 해시 함수 개수 계산
     */
    private int optimalNumOfHashFunctions(int n, int m) {
        return Math.max(1, (int) Math.round((double) m / n * Math.log(2)));
    }
    
    /**
     * 요소 추가
     */
    public void put(String item) {
        for (int i = 0; i < numHashFunctions; i++) {
            int hash = hash(item, i);
            bitSet.set(Math.abs(hash % bitArraySize));
        }
    }
    
    /**
     * 요소 확인
     */
    public boolean mightContain(String item) {
        for (int i = 0; i < numHashFunctions; i++) {
            int hash = hash(item, i);
            if (!bitSet.get(Math.abs(hash % bitArraySize))) {
                return false; // 확실히 없음
            }
        }
        return true; // 있을 수 있음
    }
    
    /**
     * i번째 해시 함수
     */
    private int hash(String item, int i) {
        // Murmur3 해시 사용
        return Hashing.murmur3_128(i).hashString(item, StandardCharsets.UTF_8).asInt();
    }
    
    /**
     * 현재 오탐율 추정
     */
    public double estimatedFalsePositiveRate(int insertedElements) {
        double bitsSet = bitSet.cardinality();
        return Math.pow(bitsSet / bitArraySize, numHashFunctions);
    }
}
```

---

## 5. Redis 기반 분산 Bloom Filter

### Redis BitSet 활용

```java
@Component
public class RedisBloomFilter {
    
    private final RedisTemplate<String, String> redisTemplate;
    private static final String BLOOM_KEY = "bloom:common_passwords";
    private static final int NUM_HASH_FUNCTIONS = 7;
    private static final int BIT_ARRAY_SIZE = 10_000_000; // 10M bits ≈ 1.25MB
    
    /**
     * 요소 추가
     */
    public void put(String passwordHash) {
        redisTemplate.executePipelined((RedisCallback<Object>) connection -> {
            for (int i = 0; i < NUM_HASH_FUNCTIONS; i++) {
                int bitIndex = hash(passwordHash, i) % BIT_ARRAY_SIZE;
                connection.setBit(BLOOM_KEY.getBytes(), bitIndex, true);
            }
            return null;
        });
    }
    
    /**
     * 요소 확인
     */
    public boolean mightContain(String passwordHash) {
        List<Boolean> results = redisTemplate.executePipelined(
            (RedisCallback<Boolean>) connection -> {
                for (int i = 0; i < NUM_HASH_FUNCTIONS; i++) {
                    int bitIndex = hash(passwordHash, i) % BIT_ARRAY_SIZE;
                    connection.getBit(BLOOM_KEY.getBytes(), bitIndex);
                }
                return null;
            }
        );
        
        return results.stream().allMatch(bit -> bit != null && bit);
    }
    
    /**
     * Bloom Filter 초기화
     */
    public void clear() {
        redisTemplate.delete(BLOOM_KEY);
    }
    
    private int hash(String item, int seed) {
        return Math.abs(Hashing.murmur3_128(seed)
            .hashString(item, StandardCharsets.UTF_8)
            .asInt());
    }
}
```

---

## 6. 성능 테스트

### 벤치마크 코드

```java
@SpringBootTest
class BloomFilterPerformanceTest {
    
    @Autowired
    private CommonPasswordBloomFilter bloomFilter;
    
    @Test
    void testBloomFilterPerformance() {
        int testSize = 100_000;
        List<String> testPasswords = generateRandomPasswords(testSize);
        
        // 추가 성능 테스트
        long addStart = System.nanoTime();
        for (String pwd : testPasswords) {
            bloomFilter.addCommonPassword(pwd);
        }
        long addDuration = System.nanoTime() - addStart;
        
        // 조회 성능 테스트
        long queryStart = System.nanoTime();
        for (String pwd : testPasswords) {
            bloomFilter.mightBeCommonPassword(pwd);
        }
        long queryDuration = System.nanoTime() - queryStart;
        
        System.out.printf("Add: %.2f μs/op\n", addDuration / testSize / 1000.0);
        System.out.printf("Query: %.2f μs/op\n", queryDuration / testSize / 1000.0);
    }
    
    @Test
    void testFalsePositiveRate() {
        // 10만 개 추가
        List<String> insertedPasswords = generateRandomPasswords(100_000);
        insertedPasswords.forEach(bloomFilter::addCommonPassword);
        
        // 10만 개 미삽입 항목 테스트
        List<String> notInsertedPasswords = generateRandomPasswords(100_000);
        
        long falsePositives = notInsertedPasswords.stream()
            .filter(bloomFilter::mightBeCommonPassword)
            .count();
        
        double actualFPP = (double) falsePositives / notInsertedPasswords.size();
        
        System.out.printf("Expected FPP: 1%%\n");
        System.out.printf("Actual FPP: %.2f%%\n", actualFPP * 100);
        
        assertTrue(actualFPP < 0.02, "FPP should be under 2%");
    }
}
```

---

## 7. 메모리 사용량 비교

### 실제 메모리 계산

```java
@Service
public class BloomFilterMemoryAnalyzer {
    
    /**
     * Bloom Filter 메모리 사용량 계산
     */
    public MemoryUsage calculateMemoryUsage(int expectedInsertions, double fpp) {
        // m = -n * ln(p) / (ln(2)^2)
        int bits = (int) Math.ceil(
            -expectedInsertions * Math.log(fpp) / (Math.log(2) * Math.log(2))
        );
        
        int bytes = (bits + 7) / 8; // bits to bytes
        int kilobytes = bytes / 1024;
        
        // HashSet과 비교
        int hashSetBytes = expectedInsertions * (64 + 16); // 객체 + 참조 오버헤드
        int hashSetKilobytes = hashSetBytes / 1024;
        
        return MemoryUsage.builder()
            .bloomFilterKB(kilobytes)
            .hashSetKB(hashSetKilobytes)
            .savingsRatio((double) hashSetKilobytes / kilobytes)
            .build();
    }
    
    @Scheduled(cron = "0 0 * * * *") // 매 시간
    public void logMemoryUsage() {
        MemoryUsage usage = calculateMemoryUsage(100_000, 0.01);
        
        log.info("Bloom Filter Memory Usage:");
        log.info("  Bloom Filter: {} KB", usage.getBloomFilterKB());
        log.info("  HashSet: {} KB", usage.getHashSetKB());
        log.info("  Savings: {}x", String.format("%.1f", usage.getSavingsRatio()));
    }
}
```

### 예상 메모리 사용량

| 항목 수 | Bloom Filter | HashSet | 절감율 |
|--------|-------------|---------|-------|
| 10,000 | 14 KB | 780 KB | 55x |
| 100,000 | 120 KB | 7.8 MB | 65x |
| 1,000,000 | 1.2 MB | 78 MB | 65x |

---

## 8. 모니터링 및 관리

### 관리자 API

```java
@RestController
@RequestMapping("/api/admin/bloom-filter")
public class BloomFilterAdminController {
    
    private final CommonPasswordBloomFilter bloomFilter;
    private final BloomFilterRebuilder rebuilder;
    
    /**
     * Bloom Filter 통계 조회
     */
    @GetMapping("/stats")
    public ResponseEntity<BloomFilterStats> getStats() {
        return ResponseEntity.ok(bloomFilter.getStats());
    }
    
    /**
     * 즉시 재구축
     */
    @PostMapping("/rebuild")
    public ResponseEntity<String> rebuild() {
        rebuilder.rebuildNow();
        return ResponseEntity.ok("Bloom Filter rebuild initiated");
    }
    
    /**
     * 특정 비밀번호 확인
     */
    @GetMapping("/check")
    public ResponseEntity<CheckResult> checkPassword(
            @RequestParam String passwordHash) {
        
        boolean mightBeCommon = bloomFilter.mightBeCommonPassword(passwordHash);
        
        return ResponseEntity.ok(CheckResult.builder()
            .passwordHash(passwordHash.substring(0, 8) + "...")
            .mightBeCommon(mightBeCommon)
            .recommendation(mightBeCommon ? "DB 확인 필요" : "통과 가능")
            .build());
    }
}
```

### 메트릭 수집

```java
@Component
public class BloomFilterMetrics {
    
    private final MeterRegistry registry;
    private final Counter bloomFilterHits;
    private final Counter bloomFilterMisses;
    
    @Autowired
    public BloomFilterMetrics(MeterRegistry registry) {
        this.registry = registry;
        this.bloomFilterHits = Counter.builder("bloom_filter.hits")
            .description("Bloom filter positive results")
            .register(registry);
        this.bloomFilterMisses = Counter.builder("bloom_filter.misses")
            .description("Bloom filter negative results")
            .register(registry);
    }
    
    public void recordHit() {
        bloomFilterHits.increment();
    }
    
    public void recordMiss() {
        bloomFilterMisses.increment();
    }
    
    public double getFilterEfficiency() {
        double hits = bloomFilterHits.count();
        double misses = bloomFilterMisses.count();
        double total = hits + misses;
        
        return total > 0 ? (misses / total) * 100 : 0;
    }
}
```

---

## 9. 실전 활용 예제

### 통합 검증 플로우

```java
@Service
public class IntegratedPasswordValidator {
    
    private final CommonPasswordBloomFilter bloomFilter;
    private final RedisTemplate<String, Integer> redisTemplate;
    private final PasswordUsageCountRepository repository;
    private final BloomFilterMetrics metrics;
    
    /**
     * 3단계 검증: Bloom Filter → Redis → DB
     */
    public void validateCommonPassword(String passwordHash) {
        // Step 1: Bloom Filter (수 마이크로초)
        if (!bloomFilter.mightBeCommonPassword(passwordHash)) {
            // 확실히 100명 미만
            metrics.recordMiss();
            return; // 통과
        }
        
        metrics.recordHit();
        
        // Step 2: Redis Cache (수 밀리초)
        String cacheKey = "pwd:count:" + passwordHash;
        Integer cachedCount = redisTemplate.opsForValue().get(cacheKey);
        
        if (cachedCount != null) {
            if (cachedCount >= 100) {
                throw new InvalidPasswordException("Common password (cached)");
            }
            return;
        }
        
        // Step 3: DB 조회 (수십 밀리초)
        Integer dbCount = repository.findById(passwordHash)
            .map(PasswordUsageCount::getUsageCount)
            .orElse(0);
        
        // 캐시 저장
        redisTemplate.opsForValue().set(cacheKey, dbCount, Duration.ofHours(24));
        
        if (dbCount >= 100) {
            throw new InvalidPasswordException("Common password (DB confirmed)");
        }
    }
}
```

---

## 관련 문서
- [[01-데이터-모델-설계]]
- [[02-비밀번호-검증-로직]]
- [[03-캐싱-전략]]
- [[05-배치-처리-및-동기화]]
