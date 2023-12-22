## 🌈 SUBSTR

- COLUMN이나 문자열에서 지정한 위치로부터 지정한 개수의 문자열을 잘라서 반환

```sql
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; -- 5번째부터 2개
SELECT SUBSTR('SHOWMETHEMONEY', 5) FROM DUAL; -- 5번째부터 마지막까지
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- 역방향으로!
SELECT SUBSTR('쇼미더머니', 2, 3) FROM DUAL; -- 한글도 글자수대로!
```