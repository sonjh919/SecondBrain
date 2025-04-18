#Java 
## Annotation
+ 프로그램의 소스코드 안에 다른 프로그램을 위한 정보를 미리 약속된 형식으로 포함시킨 것
+ 해당 프로그램에 미리 정의된 종류와 형식으로 작성해야만 의미가 있다.
+ [[커스텀 Annotation]]을 작성할 수 있다.

> [!tip]+ 
> Annotation의 뜻은 주석, 주해, 메모이다.

> [!example]+ 
> 자신이 작성한 소스코드 중에서 특정 메서드만 테스트하기를 원한다면, `@Test` Annotation을 붙인다.


## Annotation 종류
### 1. 표준 annotation
+ 자바에서 기본적으로 제공하는 annotation

| annotation           | 설명                           |
| -------------------- | ---------------------------- |
| @Override            | 컴파일러에게 오버라이딩하는 메서드라는 것을 알린다. |
| @Deprecated          | 앞으로 사용하지 않을 것을 권장하는 대상에 붙인다. |
| @SuppressWarnings    | 컴파일러의 특정 경고메시지가 나타나지 않게 해준다. |
| @SafeVarargs         | 제네릭 타입의 가변인자에 사용한다.          |
| @FunctionalInterface | 함수형 인터페이스라는 것을 알린다.          |
| @Native              | native메서드에서 참조되는 상수 앞에 붙인다.  |

### 2. 메타 annotation
+ annotation을 위한 annotation
+ annotation을 정의할 때 annotation의 적용대상(target)이나 유지기간(retention)등을 지정하는데 사용된다.


| annotation  | 설명                                        |
| ----------- | ----------------------------------------- |
| @Target     | annotation이 적용가능한 대상을 지정하는데 사용된다.         |
| @Documented | annotation 정보가 javadoc으로 작성된 문서에 포함되게 한다. |
| @Inherited  | annotation이 자손 클래스에 상속되도록 한다.             |
| @Retention  | annotation이 유지되는 범위를 지정하는데 사용한다.          |
| @Repeatable | annotation을 반복해서 적용할 수 있게 한다.             |
#### @Target
+ 지정 가능한 annotation 적용대상의 종류

| 대상 타입            | 의미                   |
| ---------------- | -------------------- |
| ANNOTATION_TYPE | annotation           |
| CONSTRUCTOR      | 생성자                  |
| FIELD            | 필드(멤버변수, enum상수)     |
| LOCAL_VARIABLE   | 지역변수                 |
| METHOD           | 메서드                  |
| PACKAGE          | 패키지                  |
| PARAMETER        | 매개변수                 |
| TYPE             | 타입(클래스, 인터페이스, enum) |
| TYPE_PARAMETER   | 타입 매개변수              |
| TYPE_USE         | 타입이 사용되는 모든 곳        |

#### @Retention
+ annotation이 유지(retention)되는 기간을 지정하는데 사용된다.

| 유지 정책   | 의미                           |
| ------- | ---------------------------- |
| SOURCE  | 소스 파일에만 존재. 클래스파일에는 존재하지 않음. |
| CLASS   | 클래스 파일에 존재. 실행시에 사용불가. 기본값   |
| RUNTIME | 클래스 파일에 존재. 실행시에 사용가능.       |

> [!info]+ 
> 유지 정책을 RUNTIME으로 하면, 실행 시에 '리플렉션(reflection)'을 통해 클래스 파일에 저장된 annotation의 정보를 읽어서 처리할 수 있다.

### @interface
+ 자바에서 새로운 annotation을 정의할 때 사용하는 키워드
+ annotation은 코드에 메타데이터를 추가하는 역할을 하며, 컴파일러, 빌드 도구, 프레임워크 등이 이 정보를 활용해 다양한 동작을 수행할 수 있다.

### Annotation
+ Annotation 자신은 인터페이스이다.
+ 하지만 명시적으로 조상으로 지정할 수 없다.