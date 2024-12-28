#NoSQL 

> [!example]+ 
> + CassandraDB
> + DynamoDB
> + [[Redis]]


## Key-Value
딕셔너리(dictionary), 해시(hash)로 잘 알려져 있는 자료 구조인 연관 배열의 저장, 검색, 관리를 위해 설계된 데이터 스토리지 패러다임이다.

![[keyvalue.png]]
### CassandraDB
Cassandra는 **읽고 쓰기가 매우 빠른 데이터베이스**이다. 애플, 넷플릭스, 인스타그램 등의 회사가 사용중이다. 엄청 많은 양의 데이터를 빠르게 저장하거나, 검색엔진처럼 많은 양의 데이터를 빠르게 읽어야 할 때 사용할 수 있다.

> [!check]+ 
> CassandraDB는 column wide databse 유형이기도 하다.

### DynamoDB
Dynamo는 serverless이고, 분산된 key-value DB로, AWS가 만들었다. 역시 매우 빠르게 많이 써야 하고 많이 읽어야 할 때 사용한다.

## Document vs Key-Value
Key-Value는 Document에 비해 어떤 종류의 DB를 얻을 수 있는지가 제한적이다. DB에서 얻고자 하는 것이 무엇인지 미리 생각해놓아야 한다.

> [!important]+ 
> SQL에서는 어떤 데이터를 얻을 것인지 고민을 하지 않는다. 데이터의 구조에 대해 고민을 한다. 나중에 데이터를 뽑아서 어떻게 할지에 대해서는 고민이 없다.