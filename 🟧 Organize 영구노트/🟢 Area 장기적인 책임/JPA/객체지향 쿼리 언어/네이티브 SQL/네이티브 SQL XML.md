#jpa #NativeSQL 


## 네이티브 SQL XML에 정의
- XML에 정의할 때는 순서대로 를 먼저 정의하고 을 정의해야 한다.
- 네이티브 SQL의 쿼리들은 대체로 복잡하고 라인수가 많아 XML을 사용하는 것이 편리하다.

```java
<entity-mappings ...>
  <named-native-query name="Member.memberWithOrderCountXml"
      result-set-mapping="memberWithOrderCountResultMap">
      <query> ... </query>
  </named-native-query>

  <sql-result-set-mapping name="memberWithOrderCountResultMap">
      <entity-result entity-class="jpabook.domain.Member"/>
      <column-result name="ORDER_COUNT"/>
  </sql-result-set-mapping>
</entity-mappings>
```