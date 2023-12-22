
## 🌈 ROLLBACK
+ Transaction 작업을 취소하고 최근 COMMIT한 시점으로 이동하는 명령
```sql
ROLLBACK;
```

## 🌈 SAVEPOINT로 ROLLBACK하기
+ Transaction 작업을 취소하고 [[SAVEPOINT]] 시점으로 이동한다.
```sql
ROLLBACK TO SAVEPOINT명;
```
