---
title: Lombok
date: 2024-01-17 12:38
categories:
  - Spring
  - Library
tags:
  - Spring
  - Library
image: 
path:
---

## Lombok
Lombok(롬복)은 Java 라이브러리로 반복되는 `getter`, `setter`, `toString` 등의 메서드 작성 코드를 줄여주는 코드 다이어트 라이브러리이다.

## Lombok 사용시 주의사항
롬복은 복잡하고 반복되는 코드가 줄어듦으로써 코드의 가독성을 높일 수 있고 코딩 생산성 또한 높일 수 있지만 롬복이 개발자마다 호불호가 나뉘는 라이브러리로 특정 개발자들은 코드가 직접 눈에 보임으로써 직관성을 유지하는것이 좋다고 보는 의견도 있다. 내가 그렇다..ㅎ

게다가 이렇게 편리하게 쓰면 getter/setter를 남발하기 때문에 쓰지 않아야 할 곳에 쓸 수도 있다. 또 내부 api 설명과 내부 동작을 숙지하지 않고 사용한다면 순환 참조나 무한 재귀 호출 문제 등으로 `StackOverflowError`가 발생할 수도 있다.

그래서 각자 프로젝트에 맞춰서 쓸지 말지 결정하면 될 것 같다.

### Lombok annotation
```Java
@Getter // getter
@Setter // setter
@ToString // ToString
@NoArgsConstructor // 인자 없는 생성자
@AllArgsConstructor // 모든 인자가 있는 생성자

@ Data // 위의 5 annotation 합친 것

@RequiredArgsConstructor // final 제어자가 붙은 빌드를 파라미터로 가지는 생성자

@Slf4j // 로깅
```