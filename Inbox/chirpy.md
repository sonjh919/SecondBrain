bundle exec jekyll serve
## chirpy 구조
- \_config.yml : 블로그의 기본 설정 파일. 수정하면 항상 jekyll을 재구동하자.
- \_data : 왼쪽 사이드바와 포스트 하단의 공유하기 버튼등의 구성을 변경할 수 있다. 언어 설정에 따라 기본적으로 화면에 나오는 단어들을 변경할 수 있다.
- \_include : 사이드바, toc, 구글애널리틱스, footer, 댓글 등의 대부분의 모듈형으로 삽입되는 UI를 변경할 수 있다.
- \_layout : 블로그 전역에 적용되는 기본 형식, 카테고리, 포스트 등에 적용되는 형식등을 변경할 수 있다.
- \_posts : 내가 작성한 블로그 글을 저장해 두는 곳이다. 이곳에 옵시디언을 연동할 생각이다.
- \_sass : css 파일을 커스터마이징 할 수 있다.
- \_site : 로컬에서 실행할 때, 화면 UI를 구성하는 모든 내용이 들어 있다. 이곳의 내용을 변경하면 로컬에는 잘 반영되지만, git에는 올라가지 않습니다.
- \_tabs : 왼쪽 사이드바의 기본 탭메뉴들에 대한 랜딩페이지가 들어 있다.
- assets : css, img등이 있다.
- tools : github에서 자동 배포를 위한 코드가 들어 있다.

## \_config.yml 수정

|항목|값|설명|
|---|---|---|
|lang|ko|언어를 한글로 설정합니다. 기본값은 en입니다.  <br>ko에 대한 언어셋이 없기 때문에 사실상 효과 없습니다.  <br>그러나 나중에 커스터마이징을 위해 해 둡시다.|
|timezone|Asia/Seoul|서울 표준시로 설정합니다.(만든분이 중국인인 것 같습니다 😁)|
|title|아무거나~|블로그 제목을 넣어 줍니다. 아바타 바로 아래 큰 글씨로 표시됩니다|
|tagline|아무거나~|title 아래에 작은 글씨로 부연설명을 넣을 수 있습니다|
|description|아무거나~|[SEO](https://searchengineland.com/guide/what-is-seo)를 위한 키워드들을 입력합니다.  <br>SEO에 대해 골치아프니, 쉽게 생각하자면 구글 검색에 어떤 키워드로 내 블로그를 검색하게 할 것인가를 결정해서 넣으면 됩니다.|
|url|[https://focuschange-test.github.io](https://focuschange-test.github.io/)|내 블로그로 실제 접속할 url을 입력합니다|
|github|github id|본인의 github 아이디를 입력합니다|
|twitter.username|twitter id|트위터를 사용한다면 아이디를 입력합니다|
|social.name|이름|포스트 등에 표시할 나의 이름을 입력합니다|
|social.email|이메일|나의 이메일 계정을 입력합니다|
|social.links|소셜 링크들|트위터, 페이스등 내가 사용하고 있는 소셜 서비스의 나의 홈 url을 입력합니다|
|theme_mode|light or dark|원하는 테마 스킨을 선택합니다. 기본은 light입니다|
|avatar|이미지 경로|블로그 왼쪽 상단에 표시될 나의 아바타 이미지를 설정합니다|
|toc|true|포스팅된 글의 오른쪽에 목차를 표시합니다|
|paginate|10|한 목록에 몇개의 글을 표시해 줄 것인지 선택합니다|

출처: https://www.irgroup.org/posts/jekyll-chirpy/

링크 업데이트
`[2023-12-21 TIL](https://sonjh919.github.io/posts/2023-12-21 TIL)`

 