#Elasticsearch 


## fielddata
대부분의 필드 타입은 doc_values를 사용할 수 있지만, text 타입은 파일 시스템 기반의 캐시인 doc_values를 사용할 수 없다. 이때 text 필드를 대상으로는 fielddata라는 캐시를 이용한다. fielddata를 사용한 정렬이나 집계 등의 작업 시에는 **역색인 전체를 읽어들여 힙 메모리에 올린다.** 따라서 OOM등 많은 문제를 발생시킬 수 있다. 따라서 매우 신중히 사용해야 한다.

