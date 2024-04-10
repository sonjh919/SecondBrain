#Redis 

## Bitmaps
- bitmaps은 strings의 변형으로, **bit 단위의 연산**이 가능한다.
- String이 512MB 저장 할 수 있듯이 2^32 bit까지 사용 가능하다.
- 저장 시, 저장 공간 절약에 큰 장점이 있다.

![[bitmaps 1.png]]
## Bitmaps 명령어

```bash
# setbit <key> <offset> <value>
# key: 해당 비트맵을 칭할 값
# offset: 0 보다 큰 정수의 값
# value: 0 또는 1의 비트 값

> setbit 20220410 4885 1

> getbit 20220410 4885

> bitcount 20220410 # 범위 내의 1로 설정된 bit의 개수를 반환
```