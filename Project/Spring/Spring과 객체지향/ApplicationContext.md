---
title: ApplicationContext
date: 2024-01-19 15:14
categories:
  - Spring
tags:
  - Spring
image: 
path:
---

## ApplicationContext
+ BeanFactory등을 상속하여 기능을 확장한 Container 이다.
+ BeanFactory는 ‘Bean’ 의 생성, 관계설정등의 제어를 담당하는 IoC 객체이다.

### ApplicationContext를 이용하여 Bean 가져오기

```java
@Component
public class MemoService {

		private final MemoRepository memoRepository;

    public MemoService(ApplicationContext context) {
        // 1.'Bean' 이름으로 가져오기
        MemoRepository memoRepository = (MemoRepository) context.getBean("memoRepository");

        // 2.'Bean' 클래스 형식으로 가져오기
        // MemoRepository memoRepository = context.getBean(MemoRepository.class);

        this.memoRepository = memoRepository;
    }

		...		
}
```