#SoftwarePattern #DesignPattern

알고리즘 캡슐화하기

## Template Method Pattern
템슬릿 메소드는 알고리즘의 각 단계(골격)를 정의하며, 서브클래스에서 일부 단계를 구현할 수 있도록 유도한다.

> [!example]+ 
> Java의 compareTo()는 비교하는 인자만 지정해주면 알아서 객체를 비교해준다.
### hook
추상 클래스에서 선언되지만 기본적인 내용만 구현되어 있거나 아무 코드도 들어있지 않은 메소드이다.