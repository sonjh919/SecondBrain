---
tistoryBlogName: sonjh919
tistoryTitle: Java의 탄생 과정과 특징
tistoryTags: Java
tistoryVisibility: "0"
tistoryCategory: "1206047"
tistoryPostId: "7"
tistoryPostUrl: https://sonjh919.tistory.com/7
---
## 📌 JVM(Java Virtual Machine)
Java는 C에서의 단점을 없애기 위해 JVM이라는 프로그램을 설치한다. 먼저 Java는 컴파일을 통해 하나의 목적 파일을 만들고, 이후에 JVM을 사용한다. 이 JVM이라는 친구는 각 플랫폼마다 설치되는데, **목적 파일을 각각의 운영체제로 전달될 수 있게 번역하는 역할이다.** 이 외에도 메모리 관리 등 효율적으로 관리하기 위한 여러 수단들을 자동화해놓은 하나의 프로그램이라고 생각하면 된다.

>**💡 이는 운영체제로 만들던 목적 파일을 하나만 만들 수 있게 해준다!**

---

## 📌 WORA(Write Once Run Anywhere)
JVM을 사용하면 어느 플랫폼에서든지 동일한 목적 파일을 제공할 수 있다는 뜻이고, **이식성이 좋아진다는 특징**이 있다. 이러한 특징을 **WORA**라고 부르며, 한번 쓰면 어디서든 돌아갈 수 있다는 뜻이다.
