## 📌 JDK(Java Development Kit) : Java 개발 키트
JDK는 Java로 개발을 하려는 사람들이 설치하여 사용하면 된다! JDK에는 JRE, JVM 등이 포함된다. JDK를 설치하려면 3가지 Edition 중 하나를 선택하여 설치하면 된다.

### **1. Java SE(Java Standard Edition)**
+ 데스크탑용 어플리케이션을 만들기 위한 심플한 용도의 java

### **2. Java EE(Java Enterprise Edition)**
+ 웹 환경을 구축할 수 있는 기능이 추가로 들어있다.

### **3. Java ME(Java Micro Edition)**
+ 소형 기기에 탑재될 수 있는 가벼운 용도의 java 
ex)자판기


성능과 비용적인 측면에서는 Oracle JDK와 Open JDK가 있다.

### **1. Oracle JDK**
비상업적인 용도에 한해서 무료, 상업은 유료 구독형 라이선스로 구매하여 사용한다.

### **2. Open JDK**
오라클이 오픈소스 커뮤니티에 제공한 소스기반으로 오픈소스로 개발되고 있으며 무료이다.

---

## 📌 Java 프로그램의 실행 순서
+ Java는 컴파일러와 인터프리터의 장점을 모두 가지고 있으며, 굳이 따지자면 인터프리터의 성향이 더 강하다. → C보다 느리고 파이썬보다 빠르다.

> 💡 **Program.java → 컴파일러(JDK/JRE) → Program.class(중간/바이트 코드) → 인터프리터 → JVM→ 이진코드**