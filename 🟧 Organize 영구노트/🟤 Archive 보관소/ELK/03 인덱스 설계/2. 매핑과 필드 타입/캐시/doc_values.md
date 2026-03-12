#Elasticsearch 

## doc_values
ES의 검색은 **역색인을 기반으로 한 색인**을 사용한다. 텀을 보고 역색인에서 문서를 찾는 방식이다. 하지만 정렬, 집계, 스크립트 작업 시에는 접근법이 다르다. 문서를 보고 필드 내의 텀을 찾는다. doc_values는 디스크를 기반으로 한 자료 구조로 파일 시스템 캐시를 통해 효율적으로 정렬, 집계 스크립트 작업을 수행할 수 있게 설계됐다.

ES에서는 text와 annotated_text 타입을 제외한 거의 모든 필드 타입이 doc_values를 지원한다. 또한 정렬, 집계, 스크립트 작업을 할 일이 없는 필드는 doc_values를 끌 수 있다. 기본값은 true이다.

```json
PUT mapping_test/_mapping
{
	"properties":{
		"notForSort":{
			"type": "keyword",
			"doc_values":false
		}
	}
}
```