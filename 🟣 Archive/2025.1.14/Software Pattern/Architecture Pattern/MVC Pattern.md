#SoftwarePattern #ArchitecturePattern

## MVC 패턴
+ Model-View-Controller의 약자이다.
+ 소프트웨어를 구성하는 요소들을 Model, View, Controller로 구분하여 각각의 역할을 분리한다.


> [!note]+ MVC
> **Model**
> - 데이터와 비즈니스 Logic을 담당한다.
> - 데이터베이스와 연동하여 데이터를 저장하고 불러오는 등의 작업을 수행한다.
> 
> **View**
> - 사용자 인터페이스를 담당한다.
> - 사용자가 보는 화면과 버튼, 폼 등을 디자인하고 구현한다.
> 
> **Controller**
> - Model과 View 사이의 상호작용을 조정하고 제어한다.
> - 사용자의 입력을 받아 Model에 전달하고, Model의 결과를 바탕으로 View를 업데이트한다.

---
## MVC 사용의 결정적인 이유
브라우저. 모바일, 데스크탑 등 여러 종류의 View에서 비즈니스 Logic을 각각 작성 시 유지보수 효율 감소, 작성 과정에서의 충돌 현상 등이 발생한다. 따라서 View 관련 코드와 비즈니스 Logic 코드를 분리하고 한데 묶어 작성한다.

## 1. Model과 View의 분리
1. **코드의 역할을 파일로 분리**할 수 있다. 
2. 비즈니스 Logic의 수정 없이 **새로운 View를 추가**할 수 있다.

![[mv.png]]
## 2. Controller의 등장 (= Presentation 계층)
- Model과 View가 서로 직접 호출하게 되면 둘 간 **의존성**이 생기면서 간접 호출의 필요성이 생긴다.
+ View와 Model 사이에 Controller를 추가함으로서 **간접 호출**을 하게 하면서 MVC 패턴이 등장하게 된다.

![[mvc.png]]

### 코드 작성의 변화
- 비즈니스 Logic의 변화 없이도 Request를 처리할 Controller만 만들어두면 여러 View를 추가시킬 수 있다.

![[controllers.png]]


- 하지만 Controller를 여러개 만들어야 하는 단점이 있기 때문에 모든 Request를 http로 받고 json으로 Response하는 방식을 적용 중에 있다. → [[REST]]

## 3. DAO의 등장 (Data Access Object) (= Repository 계층)

- Model 안에서 여러 가지 기능들을 수행할 수 있는데, 그 기능들 사이에 중복되는 코드가 발생할 수 있고, 또한 Model과 DB 사이에 결합 관계가 발생하게 된다.

> [!important]+ 
> **실질적으로 Data에 Access할 수 있는 DAO 객체를 만들어 중복을 한번 더 줄인다.**
> **Model을 비즈니스 Logic을 담당하는 Service 계층과 Data Access를 위한 DAO로 나눈다.**


- **Query문 단위**로 작성하여 **Service와 DB 사이의 간접 호출**을 담당한다.
- DB의 변경 시 Service는 변경할 필요 없이 **DAO만 변경**하면 된다.
- DAO와 DB사이에 결합 관계가 발생하게 된다 → **Mybatis의 단점**
- JPA는 Query를 쓰지 않기 때문에 DB와의 종속 관계를 해결할 수 있다.

## 4. DTO
- [[DTO]]는 계층간에 Data를 전달하고 Return받을, Data를 뭉치기 위한 용도의 객체이다.
- Data를 옮기는 역할이기 때문에 전 계층에서 사용 가능하다.
- View에서도 쓸수 있지만 Java의 영향을 받지 않게 하기 위해 쓰지 않는다.

---

## MVC Pattern 정리
![[mvcall.png]]


---

## 각 계층별 사용되는 언어

![[mvclanguage.png]]

---

## 각 계층별 역할

![[mvcpart.png]]