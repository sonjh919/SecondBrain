##  Java Programming?

+ java 번역기를 이용한 _programming(수행절차)

## WORA (Write Once Run Anywhere)

+ java의 목적은 아무데서나 실행될 수 있도록 하는 것이다. (**운영체제에 독립적, 우수한 이식성**)
+ 하지만 WORA를 이루기 위해서는 문제점이 있다!
### CPU의 차이 (CPU 호환성)
- 번역하는 순간 작동되지 않는 CPU가 생겨 번역 후 전달은 불가
- 소스코드를 베포하여 **각 기기에서 번역할 수 있도록 해야 한다.**

해결방법 : **인터프리터 사용!**

- 하지만 코드 전부를 인터프리터를 사용하기에는 java가 너무 무겁기 때문에 **컴파일러로 번역을 한번 거친 후 전달**한다.

>여기서 말하는 컴파일러는?
 + JDK 안에 존재하는 **javac.exe**

### JDK (Java Development Kit)

- java programming에 사용되는 도구들을 모아놓은 kit

↔ **JRE (Java Runtime Evironment)**

개발 목적이 아니라 실행만 할 때 쓰이며, JIT(Just In Time) 컴파일러를 사용한다.

1. API의 차이 (Application Programming Interface)

> **Interface** 
 + app이 다른 장치를 직접 만나지 않고 간접적으로 만날 수 있게 해주는 함수들의 집합
>**API** 
 + app 개발 시 사용되는 Interface

- OS(interface)가 다르면 실행할 수가 없다.
- 호환성을 위해 독자적인 java platform을 가지고 OS가 바이트코드를 해석할 수 있게 도와주는 역할인 **JVM (Java Virtual Machine)**이 만들어졌다.

**_Program.java_ → 컴파일러(_JDK_ / _JRE_) → _Program.class_(중간 / 바이트 코드) → 인터프리터 → _JVM_→ 이진코드**

---
## IDE (Integrated Development Environment, 통합 개발 환경)

- 편집기, 탐색기, 실행도구, 실행 환경 등을 하나로 통합한 개발 환경
- EX)   **[Eclipse](https://www.eclipse.org/downloads/), [IntelliJ](https://www.jetbrains.com/ko-kr/idea/)**
### Import와 Export

### Export

- Java 파일을 밖으로 **내보내기**할 때 사용한다.
- Export → General → Archive file

### Import

- 외부의 Java project를 Eclipse안으로 **가져오기**할 때 사용한다.
- Import → General → Existing Projects into Workspace

### Package
- 가장 첫번째 줄에 작성된다.
- 모든 Class는 Package 안에 있는 것을 권장한다.

### Package 양식
+ **회사 성격.회사명.프로젝트이름**