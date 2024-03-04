---
title: 같은 타입의 Bean이 2개일 경우
date: 2024-01-24 10:53
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring 

## 같은 타입의 Bean이 2개일 경우
+ 다형성을 이용한 interface 설계 시, @Autowired를 사용하여 Bean 객체를 주입려고 시도하면 오류가 뜬다.
+ 이는 food 필드에 Bean을 주입해줘야하는데 같은 타입의 Bean 객체가 하나 이상이기 때문에 어떤 Bean을 등록해줘야할지 몰라 오류가 발생한 것이다. 기본적으로 autowired는 Food type으로 bean을 찾는다.

```java
public interface Food {
    void eat();
}

@Component
public class Chicken implements Food {
    @Override
    public void eat() {
        System.out.println("치킨을 먹습니다.");
    }
}

@Component
public class Pizza implements Food {
    @Override
    public void eat() {
        System.out.println("피자를 먹습니다.");
    }
}
```

```java
@SpringBootTest
public class BeanTest {

    @Autowired // 오류 발생!
    Food food;
    
}
```

### 1.  이름 직접 명시
+ 직접 명시해주면 쓸 수 있지만, 다형성에 어긋난다고 생각하여 잘 안 쓸 것 같다.

```java
@Autowired  
Food pizza; // 직접 명시  
  
@Autowired  
Food chicken; // 직접 명시
```

### 2. @Primary
+ Primary로 설정해 놓은 객체를 Bean을 등록한다.
+ 범용적으로 사용되는 객체에서 사용된다.

```java
@Component  
@Primary  
public class Chicken implements Food {  
    @Override  
    public void eat() {  
        System.out.println("치킨을 먹습니다.");  
    }  
}

@Autowired  
Food food;
```

### 3. @Qualifier
+ Qualifier를 참고하여 해당하는 객체를 Bean으로 등록한다.
+ 지엽적으로 사용되는 객체에서 사용된다.

```java
@Component  
@Qualifier("pizza")  
public class Pizza implements Food {  
    @Override  
    public void eat() {  
        System.out.println("피자를 먹습니다.");  
    }  
}

@Autowired  
@Qualifier("pizza")  
Food food;
```

### 우선순위
+ Primary와 Qualifier가 동시에 있을 경우, Qualifier의 우선순위가 더 높다. 
+ **좁은 범위의 설정의 우선순위**가 더 높다고 할 수 있다.