#Architecture #DDD #Book

### LockManager 인터페이스
```java
public interface LockManager {
	//  type과 id를 파라미터로 갖고, 각각 잠글 대상 타입과 식별자를 값으로 전달
    // 잠금을 식별할 때 사용할 LockId를 return
    LockId tryLock(String type, String id) throws LockException;

    void checkLock(LockId lockId) throws LockException;

    void releaseLock(LockId lockId) throws LockException;

    void extendLockExpiration(LockId lockId, long inc) throws LockException;
}
```
### LockId 클래스
```java
public class LockId {
    private String value;

    public LockId(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
```

> [!note]+ 
> 1. 오프라인 선점 잠금이 필요한 코드는 LockManager#tryLock()을 이용해 잠금을 시도한다.
> 2. 잠금에 성공하면 tryLock()은 LockId를 리턴한다. LockId는 다음에 잠금을 해제할 때 사용하며, 어딘가에 보관해야 한다.

### 서비스
- 서비스는 DAO를 통해 조회한 데이터와 LockId를 함께 반환한다.
- 컨트롤러는 서비스가 리턴한 LockId를 모델로 뷰에 전달한다.
- 잠금을 선점하는 데 실패하면 LockException이 발생한다.
```java
// 서비스: 서비스는 잠금 ID를 리턴한다
public DataAndLockId getDataWithLock(Long id) {
    // 1. 오프라인 선점 시도
    LockId lockId = lockManager.tryLock("data", id);
    // 2. 기능 실행
    Data data = someDao.select(id);
    return new DataAndLockId(data, lockId);
}
```

잠금을 선점한 이후에 실행하는 기능은 아래를 고려하여 반드시 주어진 LockId를 갖는 잠금이 유효한지 확인해야 한다.

> [!summary]+ 
> 1. 잠금 유효 시간이 지났으면 다른 사용자가 잠금을 선점한다.
> 2. 잠금을 선점하지 않은 사용자가 기능을 실행했다면 기능 실행을 막아야 한다.