---
tistoryBlogName: sonjh919
tistoryTitle: Commit 종류
tistoryTags: Git, Git개념
tistoryVisibility: "3"
tistoryCategory: "1206689"
tistorySkipModal: true
tistoryPostId: "22"
tistoryPostUrl: https://sonjh919.tistory.com/22
---
#Git 
## 🌈 Commit 종류
기본 형식은 다음과 같다.
```
Commit종류 (add로 추가한 파일): Commit메세지
```


- 기능 
    - **feat**: 새로운 기능 추가
    - **fix**: 버그 수정
    - design: UI 디자인 변경 (css 등)
- 개선
    - **style**: 코드 수정 없음 (세미콜론 누락, 코드 포맷팅 등), 코드 의미에 영향을 주지 않는 변경사항
    - **refactor**: 리펙토링
    - comment: 주석 추가 및 변경
- 기타
    - **docs**: 문서 수정 (README.md 등)
    - **test**: 테스트 코드 추가
    - chore: 빌드 업무 수정, 패키지 매니저 수정 (pom.xml 등)
    - rename: 파일명, 폴더명 수정 또는 이동
    - remove: 파일 삭제
    - cicd: CI/CD 관련 설정