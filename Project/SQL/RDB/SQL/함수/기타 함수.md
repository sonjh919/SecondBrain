## 🌈 DECODE
+ if else와 비슷한 기능을 수행한다.
+ [[CASE]]를 사용하여 똑같이 구현할 수 있다.
```sql
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                        'J6', SALARY*1.15, 
                        'J7', SALARY*1.2, 
                              SALARY*1.05) 인상급여
  FROM EMPLOYEE;
```