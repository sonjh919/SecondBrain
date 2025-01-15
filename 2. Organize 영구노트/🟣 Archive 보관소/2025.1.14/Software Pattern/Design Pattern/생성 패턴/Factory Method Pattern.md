#SoftwarePattern #DesignPattern

## 팩토리 메서드 패턴(Factory Method Pattern)
팩토리 메소드 패턴은 **객체 생성을 공장(Factory) 클래스로 캡슐화 처리하여 대신 생성**하게 하는 생성 디자인 패턴이다. `new` 연산자를 이용해 직접 객체를 생성하는 것이 아닌, 생성의 책임을 가지는 **공장 클래스**를 만들고, 이를 상속하는 서브 공장 클래스의 메서드에서 여러 객체 생성을 각각 책임진다.

사용하는 서브클래스에 따라 생산되는 객체 인스턴스가 결정된다.

> [!info]+ 
> 객체 생성에 필요한 과정을 미리 구성해둔다. 즉 전처리, 후처리 등을 통해 생성 과정을 다양하게 처리하여 유연한 객체 생성이 가능하다.

## 팩토리 메서드 특징
> [!note]+ 특징
> + 클래스 생성과 사용의 처리 로직을 분리하여 **결합도를 낮추고자 할 때**
> + 코드가 동작해야 하는 객체의 유형과 종속성을 **캡슐화**를 통해 정보 은닉 처리 할 경우
> + 라이브러리 혹은 프레임워크 사용자에게 구성 요소를 확장하는 방법을 제공하려는 경우 
> + 기존 객체를 재구성하는 대신 **기존 객체를 재사용**하여 리소스를 절약하고자 하는 경우

## 팩토리 메서드 패턴 장단점
> [!summary]+ 장점
> + 생성자(Creator)와 구현 객체(concrete product)의 강한 결합을 피할 수 있다.
> + 팩토리 메서드를 통해 객체의 생성 후 공통으로 할 일을 수행하도록 지정해줄 수 있다.
> + 캡슐화, 추상화를 통해 생성되는 객체의 구체적인 타입을 감출 수 있다.
> + 생성에 대한 인터페이스 부분과 생성에 대한 구현 부분을 따로 나뉘었기 때문에 패키지를 분리하여 개별로 여러 개발자가 협업을 통해 개발할 수 있다.

> [!summary]+ 단점
> + 각 제품 구현체마다 팩토리 객체들을 모두 구현해주어야 하기 때문에, 구현체가 늘어날때 마다 팩토리 클래스가 증가하여 서브 클래스 수가 폭발한다.
> + 코드의 복잡성이 증가한다.
> 
## 팩토리 메서드 패턴 구조
![[factorymethod.png]]

> [!summary]+ 
> - **Creator** : 최상위 공장 클래스이다. 팩토리 메서드를 추상화한다.
> - **someOperartion** : 객체 생성 처리 메서드로, 객체 생성에 관한 전/후처리를 템플릿화한 메소드이다.
> - **createProduct** : 팩토리 메서드로, 서브 공장 클래스에서 재정의할 객체 생성 추상 메서드이다.
> 
> - **ConcreteCreator** : 각 서브 공장 클래스들은 생성 추상 메소드를 재정의한다.
> - **Product** : 제품 구현체를 추상화한다.
> 
> - **ConcreteProduct** : 제품 구현체

### 생성 예시
+ Product 클래스
```java
// 제품 객체 추상화 (인터페이스)
interface IProduct {
    void setting();
}

// 제품 구현체
class ConcreteProductA implements IProduct {
    public void setting() {
    }
}

class ConcreteProductB implements IProduct {
    public void setting() {
    }
}
```

+ Factory 클래스
```java
// 공장 객체 추상화 (추상 클래스)
interface AbstractFactory {

    // 객체 생성 전처리 후처리 메소드 (final로 오버라이딩 방지, 템플릿화)
    default IProduct createOperation() {
        IProduct product = createProduct(); // 서브 클래스에서 구체화한 팩토리 메서드 실행
        product.setting(); // .. 이밖의 객체 생성에 가미할 로직 실행
        return product; // 제품 객체를 생성하고 추가 설정하고 완성된 제품을 반환
    }

    // 팩토리 메소드 : 구체적인 객체 생성 종류는 각 서브 클래스에 위임
    // protected 이기 때문에 외부에 노출이 안됨
    abstract protected IProduct createProduct();
}

// 공장 객체 A (ProductA를 생성하여 반환)
class ConcreteFactoryA implements AbstractFactory {
    @Override
    public IProduct createProduct() {
        return new ConcreteProductA();
    }
}

// 공장 객체 B (ProductB를 생성하여 반환)
class ConcreteFactoryB implements AbstractFactory {
    @Override
    public IProduct createProduct() {
        return new ConcreteProductB();
    }
}
```

> [!tip]+ 
> 최상위 공장 클래스는 반드시 추상 클래스로 선언할 필요 없다. Java 8 버전 이후 추가된 인터페이스의 디폴트 메서드를 통해 팩토리 메서드를 선언하면 되기 때문이다.

> [!check]+ 클래스 흐름
> ![[Pasted image 20240321145725.png]]