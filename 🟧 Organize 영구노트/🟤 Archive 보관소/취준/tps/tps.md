## 요구사항 1. 목표 TPS 설정 및 서버 설정 최적화

- **먼저 우리 서비스가 한 대의 서버로 얼마나 감당할 수 있는지 알아야 합니다**
- 핵심 기능(로그인, 조회, 작성 등)별로 목표 TPS를 정하세요
- 그리고 그에 맞게 설정을 조정하세요

**톰캣 설정 튜닝:**

- **`threads.max`**: 동시에 처리할 수 있는 요청 수
- **`max-connections`**: 최대 연결 수
- **`accept-count`**: 대기열 크기
- **각 값을 왜 그렇게 설정했는지 근거를 제시하세요**

**HikariCP 커넥션 풀 설정:**

- 적절한 풀 사이즈는? (너무 적으면 병목, 너무 많으면 DB 부하)
- **`maximumPoolSize`**, **`minimumIdle`**, **`connectionTimeout`** 등
- **DB 최대 연결 수와 애플리케이션 서버 대수를 고려하세요**

---

## 답변 1. 목표 TPS 설정 및 서버 설정 최적화

- 현재 토독토독 서비스의 대부분의 API는 각각 하나의 트랜잭션으로 설계되었기 때문에 RPS를 TPS로 표현합니다.
- 테스트 별로 관찰할 핵심 지표는 아래와 같습니다.

|관찰할 지표|
|---|
|vus (= CCU, 동시접속자)|
|TPS (= Peak RPS, ~= 처리율)|
|api당 지연 시간(= 평균적으로 100ms를 넘는지, 어떤 것이 가장 많이 지연이 발생하는지)|
|Http 요청 실패율(= Http Failures / Total Http Requests)|
### 테스트 환경

---

1. 프록시 서버 (K6의 모든 요청을 받은 후 애플리케이션 서버로 요청을 프록시하는 서버)
    - `t4g.nano` (vCPU : 2, 메모리 : 0.5GiB)
2. 애플리케이션 서버
    
    - `t4g.small` (vCPU : 2, 메모리 : 2GiB)
    - Tomcat max threads : `200`
    - Tomcat max connections : `8124`
    - Tomcat accept count : `100`
    - HikariCP maxPoolSize : `10`

### 단일 테스트

---

- 테스트 방법 : 메인화면 조회 (가장 요청이 많이 몰릴 것으로 예상) 시 호출하는 api를 반복해서 호출함
    
    - 테스트 스크립트 (K6)
        
        ```jsx
        import http from 'k6/http';
        import { sleep, group } from 'k6';
        
        export const options = {
          stages: [
            { duration: '10m', target: 500 },
            { duration: '10m', target: 500 }
          ]
        };
        
        export default function () {
            group('메인 페이지 진입 시 API 일괄 호출', function () {
                http.get('<https://todoktodok.com/api/v1/notifications/unread/exists>');
                http.get('<https://todoktodok.com/api/v1/discussions/hot?period=7&count=5>');
                http.get('<https://todoktodok.com/api/v1/members/1/discussions?type=PARTICIPATED>');
                http.get('<https://todoktodok.com/api/v1/members/1/discussions?type=CREATED>');
                http.get('<https://todoktodok.com/api/v1/discussions/active?period=7&size=15>');
                http.get('<https://todoktodok.com/api/v1/discussions/hot?period=7&count=5>');
                http.get('<https://todoktodok.com/api/v1/members/1/discussions?type=CREATED>');
                http.get('<https://todoktodok.com/api/v1/members/1/discussions?type=PARTICIPATED>');
                http.get('<https://todoktodok.com/api/v1/discussions?size=15&cursor=>');
            });
            sleep(10);
        }
        ```
        
- 동시접속 VU 및 서버 튜닝을 변경해가며 테스트 9차 진행
    
| 테스트 | vus(명) | 변경지점                                                                                                  | TPS(req/s)         | latency(ms)        | failures(%) | server                                        | 결론 / 발생한 문제                                                               |
| --- | ------ | ----------------------------------------------------------------------------------------------------- | ------------------ | ------------------ | ----------- | --------------------------------------------- | ------------------------------------------------------------------------- |
| 1   | 300    |                                                                                                       | 293, 안정적           | 10~50 안정           | 0           |                                               | 안정적인 상태                                                                   |
| 2   | 500    | 동시 접속자수 증가                                                                                            | 408, 안정적           | 20-30 → 100-300 급증 | 0           |                                               | 응답시간 지연 발생                                                                |
| 3   | 1000   | 동시 접속자수 증가                                                                                            | 실패 요청 포함 658       | ~ 평균 600           | 20          | HikariCP Pending 커넥션 부하 (최대 188개)             | 데이터베이스 커넥션풀 포화                                                            |
| 4   | 500    | - 동시 접속자수 증가, 최대 동시 접속자수까지 증가 후 10분 유지 추가 Tomcat max threads 200→ 30 HikariCP connection pool 10 → 20 | 실패 요청 포함 428       | ~ 평균 100           | 0.1         | cpu 사용률 높음 (~94%)                             | cpu 사용률 매우 높음, 서버 다운 위험                                                   |
| 5   | 300    | 동시 접속자수 감소                                                                                            | 331, 조금 불안         | ~ 평균 60            | 0           | cpu 완화됨(~70%) 평균 스레드풀 사용량 5~10 → 유휴 스레드 다수 발생 |                                                                           |
| 6   | 300    | Tomcat max threads 30 → 3                                                                             | 191, 안정적           | 10~30 안정           | 0           | cpu 평균 사용량 48.6% hikariCP 커넥션 평균 2 & 최대 2     | 안정적인 상태                                                                   |
| 7   | 500    | 동시 접속자수 증가                                                                                            | 실패 요청 포함 442       | 10~30 안정           | 20          | cpu 37.4%                                     | tomcat connections가 250을 찍으면 더이상 증가하지 않으면서 Connection reset by peer가 발생한다 |
| 8   | 500    | Nginx worker connections를 1024로 늘리고, keep-alive 32개 커넥션 재사용                                           | 177, 안정적           | 10~30 안정           | 0           | cpu 25.6%                                     | 안정적인 상태                                                                   |
| 9   | 600    | 동시 접속자수 증가                                                                                            | 실패 요청 포함 412, 불안정적 | 10~30 안정           | 7           | cpu 34.0%                                     | 임계지점 발견                                                                   |

- 메인화면 단일 조회 테스트로 우리 서버 1대가 버틸 수 있는 안정적인 최대 VUs는 500명, **목표 TPS는 170~190TPS로 설정**
    
    - 해당 테스트 때의 튜닝 값
        - **Tomcat `threads.max`** : 3
        - **Tomcat `max-connections`** : 8192 (기본값)
        - **Tomcat `accept-count` :** 100 (기본값)
        - **HikariCP `maximumPoolSize`** : 10 (기본값) → max threads(3) 이상 늘어나지 않았으므로 10으로 충분히 여유를 둠
        - **HikariCP `minimumIdle`** : 5 (기본값) → DB가 병목지점이 아니었으므로 기본값에서 변경하지 않음
        - **HikariCP `connectionTimeout`** : 30초 (기본값) → DB가 병목지점이 아니었으므로 기본값에서 변경하지 않음

### 가중치 테스트

---

- 테스트 방법 : 서비스 전반의 핵심 플로우 15가지 선정, 각 플로우의 조회 및 생성 요청을 반복 발생시킴, 기능의 중요도에 따라 가중치를 다르게 두어 요청 발생
    
    - 핵심 플로우 15개
        
        15개의 핵심 서비스 사용 플로우를 정하고, 각 플로우에 가중치를 다르게 주어 트래픽을 분배해 보낸다. 이때 접속할 확률이 높고 핵심인 플로우일수록 가중치를 높게 주었다.
        
        1. 가중치 5 : 토론방 최신순 조회 (페이지네이션 포함, 동일 요청 5회)
        2. 가중치 3 : 토론방 검색
        3. 가중치 3 : 회원 관련 조회 연쇄 (프로필 조회, 도서 조회, 좋아요 및 참여한 토론방 조회)
        4. 가중치 7 : 메인화면 조회 (인기 토론방, 활성화된 토론방 조회)
        5. 가중치 3 : 토론방 생성 → 도서 생성
        6. 가중치 10 : 토론방 단일 조회 → 댓글 목록 조회 → 댓글 생성
        7. 가중치 10 : 토론방 단일 조회 → 댓글 목록 조회 → 대댓글 목록 조회 → 대댓글 생성
        8. 가중치 2 : 알림 fcmToken 발급
        9. 가중치 1 : 로그인
        10. 가중치 5 : 토론방 좋아요
        11. 가중치 5 : 댓글 좋아요
        12. 가중치 5 : 대댓글 좋아요
        13. 가중치 3 : 도서 상세 조회, 토론방 조회
        14. 가중치 1 : 알림 목록 조회
        15. 가중치 3 : 리프레시 토큰 재발급
    - 테스트 스크립트 (K6)
        
        ```jsx
        import http from 'k6/http';
        import { sleep, group, check } from 'k6';
        
        export const options = {
          stages: [
            { duration: '10m', target: 400 },
            { duration: '10m', target: 400 },
          ],
        };
        
        const BASE = '<http://43.202.235.126>';
        const JSON_HEADERS = { headers: { 'Content-Type': 'application/json' } };
        
        // ID 범위 정의
        const RANGES = {
          memberId: { min: 1, max: 8 },
          discussionId: { min: 1, max: 16 },
          commentId: { min: 1, max: 29 },
          replyId: { min: 1, max: 1 },
          bookId: { min: 1, max: 25 },
        };
        
        // ===== 유틸 =====
        function randInt(min, max) {
          return Math.floor(Math.random() * (max - min + 1)) + min;
        }
        function pickId(key) {
          const { min, max } = RANGES[key];
          return randInt(min, max);
        }
        function nowStr() {
          return new Date().toISOString();
        }
        function ok(res) {
          return res && res.status && res.status < 500;
        }
        function pick(arr) {
          return arr[Math.floor(Math.random() * arr.length)];
        }
        function randomIsbn13() {
          // 단순 13자리 숫자형 ISBN 생성(형식 감시 정도에 충분)
          const prefix = '978';
          const body = String(randInt(10 ** 9, 10 ** 10 - 1)).padStart(10, '0'); // 10자리
          return prefix + body; // 13자리
        }
        
        // 예쁜 값들
        const K_TITLES = [
          '객체지향의 사실과 오해', '클린 코드', '모던 자바 인 액션', '이펙티브 자바',
          '리팩터링 2판', '데이터 중심 애플리케이션 설계', 'HTTP 완벽 가이드', '가상 면접 사례로 배우는 대규모 시스템 설계'
        ];
        const K_AUTHORS = ['박재성', '로버트 C. 마틴', '조슈아 블로크', '마틴 파울러', '반 버넌', '토마스 피에츠첸'];
        const DEVICES = ['web', 'ios', 'android'];
        
        // 케이스 목록 (가중치 포함)
        const cases = [
          // 1. 가중치 5 [토론방 최신순 조회] - 동일 요청 5회
          {
            name: '토론방 최신순 조회 x5',
            weight: 5,
            run: () => {
              const url = `${BASE}/api/v1/discussions?size=5`;
              for (let i = 0; i < 5; i++) {
                const r = http.get(url);
                check(r, { '1.latest.ok': (res) => ok(res) });
              }
            },
          },
        
          // 2. 가중치 3 [토론방 검색]
          {
            name: '토론방 검색',
            weight: 3,
            run: () => {
              const url = `${BASE}/api/v1/discussions/search?keyword=${encodeURIComponent('객체')}`;
              const r = http.get(url);
              check(r, { '2.search.ok': (res) => ok(res) });
            },
          },
        
          // 3. 가중치 3 [회원 관련 조회 연쇄]
          {
            name: '회원 프로필/책/좋아요/참여 조회',
            weight: 3,
            run: () => {
              const memberId = pickId('memberId');
        
              let r = http.get(`${BASE}/api/v1/members/${memberId}/profile`);
              check(r, { '3.profile.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/members/${memberId}/books`);
              check(r, { '3.books.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/discussions/liked?size=10`);
              check(r, { '3.liked.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/members/${memberId}/discussions?type=PARTICIPATED`);
              check(r, { '3.participated.ok': (res) => ok(res) });
            },
          },
        
          // 4. 가중치 7 [메인화면 조회]
          {
            name: '메인화면 조회',
            weight: 7,
            run: () => {
              let r = http.get(`${BASE}/api/v1/discussions/hot?period=7&count=10`);
              check(r, { '4.hot.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/discussions/active?period=7&size=10`);
              check(r, { '4.active.ok': (res) => ok(res) });
            },
          },
        
          // 5. 가중치 3 [토론방 생성 → 도서 생성]
          {
            name: '토론방/도서 생성',
            weight: 3,
            run: () => {
              const bookId = pickId('bookId');
              const discussionTitle = `[k6] ${pick(K_TITLES)} (${nowStr()})`;
              const discussionOpinion = '성능 검증용 자동 생성 의견입니다. 실제 데이터와 혼동하지 마세요.';
              const r1 = http.post(
                `${BASE}/api/v1/discussions`,
                JSON.stringify({
                  bookId: bookId,
                  discussionTitle: discussionTitle,
                  discussionOpinion: discussionOpinion,
                }),
                JSON_HEADERS
              );
              check(r1, { '5.discussion.post.ok': (res) => ok(res) });
        
              const bookTitle = `[k6] ${pick(K_TITLES)} #${randInt(1, 999)}`;
              const bookAuthor = pick(K_AUTHORS);
              const isbn13 = randomIsbn13();
              // 보기 좋은 샘플 이미지 URL
              const imageUrl = `https://picsum.photos/seed/${isbn13.slice(-6)}/300/450`;
        
              const r2 = http.post(
                `${BASE}/api/v1/books`,
                JSON.stringify({
                  bookIsbn: isbn13,
                  bookTitle: bookTitle,
                  bookAuthor: bookAuthor,
                  bookImage: imageUrl,
                }),
                JSON_HEADERS
              );
              check(r2, { '5.book.post.ok': (res) => ok(res) });
            },
          },
        
          // 6. 가중치 10 [토론 단일 조회 → 댓글목록 → 댓글 생성]
          {
            name: '토론 단일/댓글 조회+생성',
            weight: 10,
            run: () => {
              const discussionId = pickId('discussionId');
        
              let r = http.get(`${BASE}/api/v1/discussions/${discussionId}`);
              check(r, { '6.discussion.get.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/discussions/${discussionId}/comments`);
              check(r, { '6.comments.get.ok': (res) => ok(res) });
        
              r = http.post(
                `${BASE}/api/v1/discussions/${discussionId}/comments`,
                JSON.stringify({ content: `k6 댓글: ${nowStr()}` }),
                JSON_HEADERS
              );
              check(r, { '6.comment.post.ok': (res) => ok(res) });
            },
          },
        
          // 7. 가중치 10 [토론/댓글/대댓글 조회+생성]
          {
            name: '토론/댓글/대댓글 조회+생성',
            weight: 10,
            run: () => {
              const discussionId = pickId('discussionId');
              const commentId = pickId('commentId');
        
              let r = http.get(`${BASE}/api/v1/discussions/${discussionId}`);
              check(r, { '7.discussion.get.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/discussions/${discussionId}/comments`);
              check(r, { '7.comments.get.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/discussions/${discussionId}/comments/${commentId}`);
              check(r, { '7.comment.get.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/discussions/${discussionId}/comments/${commentId}/replies`);
              check(r, { '7.replies.get.ok': (res) => ok(res) });
        
              r = http.post(
                `${BASE}/api/v1/discussions/${discussionId}/comments/${commentId}/replies`,
                JSON.stringify({ content: `k6 대댓글: ${nowStr()}` }),
                JSON_HEADERS
              );
              check(r, { '7.reply.post.ok': (res) => ok(res) });
            },
          },
        
          // 8. 가중치 2 [알람 fcmToken 발급]
        	{
        	  name: '알람 토큰 발급',
        	  weight: 2,
        	  run: () => {
        	    const token = `k6-${Math.random().toString(36).slice(2)}-${Date.now()}`;
        	    // 실제 FCM Installation ID 형식: 22~28자 base64url 비슷한 문자열
        	    const fid = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
        	
        	    const r = http.post(
        	      `${BASE}/api/v1/notificationTokens`,
        	      JSON.stringify({ token: token, fid: fid }),
        	      JSON_HEADERS
        	    );
        	    check(r, { '8.fcm.post.ok': (res) => ok(res) });
        	  },
        	},
        
          // 9. 가중치 1 [로그인]
          {
            name: '로그인',
            weight: 1,
            run: () => {
              const r = http.post(
                `${BASE}/api/v1/members/login`,
                JSON.stringify({ googleIdToken: 'chaeyoung0714@gmail.com' }),
                JSON_HEADERS
              );
              check(r, { '9.login.post.ok': (res) => ok(res) });
            },
          },
        
          // 10. 가중치 5 [토론 좋아요]
          {
            name: '토론 좋아요',
            weight: 5,
            run: () => {
              const discussionId = pickId('discussionId');
              const r = http.post(
                `${BASE}/api/v1/discussions/${discussionId}/like`,
                null,
                JSON_HEADERS
              );
              check(r, { '10.discussion.like.ok': (res) => ok(res) });
            },
          },
        
          // 11. 가중치 5 [댓글 좋아요]
          {
            name: '댓글 좋아요',
            weight: 5,
            run: () => {
              const discussionId = pickId('discussionId');
              const commentId = pickId('commentId');
              const r = http.post(
                `${BASE}/api/v1/discussions/${discussionId}/comments/${commentId}/like`,
                null,
                JSON_HEADERS
              );
              check(r, { '11.comment.like.ok': (res) => ok(res) });
            },
          },
        
          // 12. 가중치 5 [대댓글 좋아요]
          {
            name: '대댓글 좋아요',
            weight: 5,
            run: () => {
              const discussionId = pickId('discussionId');
              const commentId = pickId('commentId');
              const replyId = pickId('replyId');
              const r = http.post(
                `${BASE}/api/v1/discussions/${discussionId}/comments/${commentId}/replies/${replyId}/like`,
                null,
                JSON_HEADERS
              );
              check(r, { '12.reply.like.ok': (res) => ok(res) });
            },
          },
        
          // 13. 가중치 3 [도서 상세/토론방 조회]
          {
            name: '도서 상세/토론방 조회',
            weight: 3,
            run: () => {
              const bookId = pickId('bookId');
        
              let r = http.get(`${BASE}/api/v1/books/${bookId}`);
              check(r, { '13.book.get.ok': (res) => ok(res) });
        
              r = http.get(`${BASE}/api/v1/books/${bookId}/discussions?size=10`);
              check(r, { '13.book.discussions.get.ok': (res) => ok(res) });
            },
          },
        
          // 14. 가중치 1 [알람 목록 조회]
          {
            name: '알람 목록 조회',
            weight: 1,
            run: () => {
              const r = http.get(`${BASE}/api/v1/notifications`);
              check(r, { '14.notifications.get.ok': (res) => ok(res) });
            },
          },
        
          // 15. 가중치 3 [리프레시 토큰 재발급]
          {
            name: '리프레시 토큰 재발급',
            weight: 3,
            run: () => {
              const token = `rt-${Math.random().toString(36).slice(2)}-${Date.now()}`;
              const r = http.post(
                `${BASE}/api/v1/members/refresh`,
                JSON.stringify({ refreshToken: token }),
                JSON_HEADERS
              );
              check(r, { '15.refresh.post.ok': (res) => ok(res) });
            },
          },
        ];
        
        // 가중치 기반 선택 함수
        const totalWeight = cases.reduce((s, c) => s + c.weight, 0);
        function pickCase() {
          let r = Math.random() * totalWeight;
          for (const c of cases) {
            if (r < c.weight) return c;
            r -= c.weight;
          }
          return cases[cases.length - 1];
        }
        
        // 실제 시나리오 실행
        export default function () {
          group('다양한 API 테스트', function () {
            const chosen = pickCase();
            group(`케이스: ${chosen.name}`, function () {
              chosen.run();
            });
          });
        
          // 각 VU 루프 간 간격
          sleep(10);
        }
        ```
        
- 동시접속 VU 및 서버 튜닝, 테스트 스크립트를 변경해가며 테스트 7차 진행
    
- 테스트 설정 및 결과 요약

|테스트|vus(명)|변경지점|TPS(req/s)|latency(ms)|failures(%)|server|결론 / 발생한 문제|
|---|---|---|---|---|---|---|---|
|1|300||83, 불안정|3s 이상|3 (비즈니스 로직 에러로 무시)|cpu 17.7%|/hot 요청 지연|
|2|400|동시 접속자 수 증가|실패 요청 포함 19, 매우 불안정|8s 이상|99 (Nginx 499 에러)|cpu 2.3%|/hot 요청 대폭 지연|
|3|300|- 동시 접속자 수 감소 Tomcat max threads 3→ 10|13, 매우 낮고 불안정|평균 100-200ms, 최대 500ms|100 (순간적인 CPU 부하로 인해 테스트 서버가 다운)|cpu 10.3%|/hot 요청이 병목 지점임을 명확하게 인식|
|4|300|병목이 심했던 API 로직 간소화|123, 안정적으로 회복|100-300ms|5 (비즈니스 로직 에러로 무시)|cpu 0.8%|병목 제거로 latency는 있으나 전반적으로 안정화|
|5|100|- 동시 접속자 수 감소 Tomcat max threads 10 → 50|10.2, 불안정|5s ~ 15s|0||병목 증가, DB ConnectionPool 20개 사용|
|6|100|- HikariCP connection pool 10 → 5|33.3, 소폭 안정|100ms ~ 1s|8.6 (비즈니스 로직 에러로 무시)||TPS 비슷, 실패 응답 조금 있으나 latency 대폭 감소|
|7|200|동시 접속자 수 증가 DB Connection Pool Pending 발생|51.6, 소폭 안정|100ms ~ 1.2s|6 (비즈니스 로직 에러로 무시)||VUs 증가 → 처리량/TPS 증가, latency 약간 증가|


- 가중치 테스트 + 데이터가 약 10만까지 지속적으로 증가했을 때 우리 서버 1대가 버틸 수 있는 안정적인 최대 VUs는 100~200명, **목표 TPS는 30~50TPS로 설정**
    
    - 해당 테스트 때의 튜닝 값
        - **Tomcat `threads.max`** : 10
        - **Tomcat `max-connections`** : 8192 (기본값)
        - **Tomcat `accept-count` :** 100 (기본값)
        - **HikariCP `maximumPoolSize`** : 5
        - **HikariCP `minimumIdle`** : 5 (기본값)
        - **HikariCP `connectionTimeout`** : 30초 (기본값)
- 지연이 오래 발생하는 api (모든 테스트에서 공통적으로 평균 또는 최대 지연시간이 100ms를 초과하는 api)에서 핵심 병목 발생 → 쿼리 성능 개선하여 TPS 개선 예정
    
    - GET `/api/v1/discussions/hot`
    - GET `/api/v1/discussions/search`
    - GET `/api/v1/discussions/active`
    - GET `/api/v1/members/{memberId}/books`
    - GET `/api/v1/members/{memberId}/discussions`
    - GET `/api/v1/discussions/liked`

### 결론

---

우리 서버의 목표 MAU는 `3000`명이고, 이를 위해서는 `300`TPS를 목표치로 잡았다. 분산 서버 2대를 고려했을 때 한 서버당 약 `150`~`200`TPS를 목표로 한다.

톰캣 및 HikariCP 커넥션의 처리량이 적정수준일 때는 코어 수가 2일 때 max threads가 3, max HikariCP connections가 10일때도 `191`TPS까지 안정적으로 처리할 수 있었다. 이는 분산 서버 2대를 고려했을 때 저

그러나 데이터베이스에 데이터를 10만 건 넣고 처리량이 낮아지자 데이터베이스 커넥션에 병목이 발생했고, max threads가 10, max HikariCP connections가 5일 때 `100`TPS까지 처리 가능했다.

슬로우 쿼리 로그를 통해 지연이 발생하는 쿼리를 확인했고, 처리량이 목표 TPS를 만족하도록 개선하기 위해 쿼리 추가 개선이 필요하다.