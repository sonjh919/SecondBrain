## 역할
사용자의 기본 정보와 현재 사용 중인 비밀번호를 저장하는 테이블입니다.

## 주요 컬럼
- `user_id`: 사용자 고유 ID (BIGINT, Primary Key)
- `current_password`: 현재 비밀번호 해시 (VARCHAR 255)
- `created_at`: 계정 생성 시간
- `updated_at`: 마지막 업데이트 시간

## 설계 포인트
1억 개의 레코드를 수용해야 하므로 BIGINT 타입 사용. 인덱스는 최소화하여 INSERT/UPDATE 성능을 확보합니다.

## 관련 문서
- [[password-history-테이블]]
- [[password-usage-count-테이블]]
