#Architecture #MSA

> [!important]+ 
> 동기 방식과 비동기 방식의 차이는 **시간의 이슈**이다.
> Blocking 방식과 Non-Blocking 방식의 차이는 **IO의 이슈**이다.
> 
> 동기이면서 Blocking인 경우(MySQL), 비동기이면서 Non-Blocking인 경우(이벤트 처리)가 많다.

## 동기 방식
요청을 보낸 후 응답을 받아야지만 다음 동작이 이루어지는 방식이다. 어떠한 일을 처리할 동안 다른 프로그램은 정지한다. **Request 시간과 Response 시간이 동일하다**고 생각하면 된다.

> [!example]+ 
> [[HTTP]] 방식

## 비동기 방식
요청을 보낸  후 응답과는 상관없이 다음 동작이 이루어지는 방식이다. **Request 시간과 Response 시간이 다르다.** 비동기 방식의 경우 MQ(Message Queue) 패턴을 사용한다.

### Message Queue의 종류
> [!summary]+ 
> + amazon sqs (큐 서비스 쉽게 쓸 때)
> + amazon sns (카프카는 어렵지만 Topic 개념이 필요할 때)
> + kafka ( MAJOR ) → Amazon MSK, confluent Kafka
> + active mq (데이터 통신이 정확해야 하는 경우)
> + rabbit mq (쉽게 설정이 필요한 경우)
> + zmq ( 넥슨에서 쓰다가 망함)

---

## Blocking
현재 작업이 block(차단, 대기) 상태에 놓이는 것을 Blocking이라 한다. 데이터 입출력 시 데이터의 무결성을 고려해 막는 것을 선택한다.

> [!caution]+ 
> 시간이랑은 상관이 없다.

## Non-Blocking
현재 작업에 대해 blocking하지 않는 것을 말한다.