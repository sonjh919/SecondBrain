#Elasticsearch 

## 색인 API
문서 단건을 색인한다. [[라우팅]]을 지정할 수 있다.

```json
PUT [인덱스 이름]/_doc/[_id값]  // 기본
POST [인덱스 이름]/_doc  // _id값 지정 없이 색인
PUT [인덱스 이름]/_create/[_id값] // create: 덮어씌우면서 색인 금지. id가 이미 있다면 실패
POST [인덱스 이름]/_create/[_id값]
```

### refresh
색인 시 refresh 매개변수를 지정할 수 있다. 실제 서비스에서 색인 직후 검색 결과에 최신 변경 내용이 포함되어야만 하는 비즈니스 요구가 있을 때 고려할 수 있다.

| refresh값 | 동작 방식                                              |
| -------- | -------------------------------------------------- |
| true     | 색인 직후 문서가 색인된 샤드를 refresh하고 응답을 반환한다.              |
| wait_for | 색인 이후 문서가 refresh될 때까지 기다린 후 응답을 반환한다.             |
| false    | 아무 값도 지정하지 않았을 때 기본값이다. refresh와 관련된 동작을 수행하지 않는다. |

## 조회 API
문서 단건을 조회한다.

> [!check]+ 
> 조회 API는 검색과는 다르게 색인이 refresh되지 않은 상태에서도 변경된 내용을 확인할 수 있다. 애초에 고유한 식별자를 지정하여 단건 문서를 조회하는 것은 [[역색인]]을 사용할 필요가 없고, [[ES 내부 구조와 루씬|translog]]에서도 데이터를 읽어올 수 있기 때문이다.

```json
GET [인덱스 이름]/_doc/[_id값]     // 인덱스, _id 등을 포함한 기본적인 메타데이터 함께 조회
GET [인덱스 이름]/_source/[_id값] // 문서의 본문만을 조회
```

### 필드 필터링
조회 API 사용시 `_source_includes`와 `_source_excludes`옵션 사용 시 결과에 원하는 필드만 필터링해 포함시킬 수 있다. excludes 옵션은 includes 옵션 적용 후에 적용된다.

> [!example]+ 
> ```json
> GET my_index2/_doc/1?_source_includes=p*,views&_source_excludes=public
> ```


## 업데이트 API
지정한 문서 하나를 업데이트한다. doc을 이용한 방법과 script를 이용한 방법이 있다.

```json
POST [인덱스 이름]/_update/[_id값]
```

### 1. doc
+ detect_noop : 실질적으로 변경되었는지 확인.
+ doc_as_upsert : 기존 문서가 없을 때 새로 문서 추가
```json
POST [인덱스 이름]/_update/[_id값]
{
	"doc":{
		[업데이트 내용]
	},
	"detect_noop" : false,
	"doc_as_upsert": true
}
```

### 2. script
ES 자체 스크립트 언어인 painless를 사용한다. [[JVM]]바이트코드로 컴파일되며 자바와 문법이 비슷하다.

-추후 추가 예정-

## 삭제 API
지정한 문서 하나를 삭제한다. 일반적으로 **한번 삭제한 문서는 되돌릴 수 없다.**
마찬가지로 routing과 refresh 옵션을 지정할 수 있다.

```json
DELETE [인덱스 이름]/_doc/[_id값] // 문서 삭제
DELETE [인덱스 이름] // 인덱스 삭제
```