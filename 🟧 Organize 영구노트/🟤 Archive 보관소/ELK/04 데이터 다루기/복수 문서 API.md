#Elasticsearch 

실제 서비스에서는 최대한 [[단건 문서 API]] 보다는 복수 문서 API를 활용해야 한다.

## bulk API
bulk API는 여러 색인, 업데이트, 삭제 작업을 한 번의 요청에 담아서 보내는 API이다.

-추후 추가 예정-

## multi get API
\_id를 여럿 지정하여 해당 문서를 한 번에 조회하는 API이다. 단건 조회 API를 반복해서 사용하는 것보다 성능이 좋다.

```json
GET _mget
GET [인덱스 이름]/_mget
```

요청 본문에는 docs 필드 밑에 각 세부 조회 요청을 기술한다. 각 세부 요청은 \_index, \_id를 포함해야 하며 라우팅이나 특정 필드 포함 및 제거 옵션들을 함께 기술할 수 있다.

## update by query
먼저 검색 쿼리를 통해 주어진 조건을 만족하는 문서를 찾은 뒤 그 문서를 대상으로 업데이트나 삭제 작업을 실시하는 API이다.

```json
POST [인덱스 이름]/_update_by_query
{
	"script":{
		"source": "//...",
	},
	"query":{
	//...
	}
}
```
### 스로틀링
update by query API는 관리적인 목적으로 수행되는 경우가 많다. 그런데 이런 대량 작업 수행 시 운영 중인 기존 서비스에도 영향을 줄 수 있다. 이런 상황을 피하기 위해 스로틀링을 적절하게 적용하여 작업 속도를 조정하고 클러스터 부하와 서비스 영향을 최소화할 수 있다. 스로틀링을 동적으로 변경할 수도 있다.

### 비동기적 요청과 tasks API
ES에서 update by query API 요청 시 `wait_for_completion` 매개변수를 false로 지정하여 비동기적 처리를 할 수 있다.

### task 작업 등록과 상태 조회
update by query API는 task의 형태로 동작하며 task 조회 API를 통해 작업 진행을 확인할 수 있다. 작업이 완료되어도 task 기록은 ES에 남으므로 문서를 삭제해주면 좋다.

```json
GET _tasks/[task Id]
POST _tasks/[task Id]/_cancel // 작업 취소
DELETE .tasks/_doc/[task Id]
```

### 슬라이싱
관리적 목적의 대량 업데이트를 수행하는 경우, 스로틀링을 적용해 부하를 줄이는 선택도 있지만 반대로 업데이트 성능을 최대로 끌어내 빠른 시간 안에 끝내고자 할 경우도 있다. 이때 slices 매개변수를 지정하여 검색과 업데이트를 지정한 개수로 쪼개 병렬적으로 수행한다.

```json
POST [인덱스 이름]/_update_by_query?slices=auto
{
	//...
}
```

## delete by query
먼저 지정한 검색 쿼리로 삭제할 대상을 지정한 뒤에 삭제를 수행하는 작업이다. 관리적인 목적으로 사용한다. update by query와 다르게 **주기적인 배치성 작업**으로 수행하는 경우도 많다.

```json
POST [인덱스 이름]/_delete_by_query
{
	"query":{
		// ...
	}
}
```