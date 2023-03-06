/*
    < VIEW 뷰 >
    SELECT(쿼리문)을 저장해둘 수 있는 객체
    (자주 사용하는 길이가 긴 SELECT문을 저장해두면 매 번 다시 기술할 필요 없이 VIEW를 시용해서 편하게 사용가능!!)
    임시테이블 같은 존재(실제 데이터가 들어가진 않음!!!)
*/

------------------------------------- 문제 --------------------------------------

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명을 조회하시고!!
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_TITLE,
       SALARY,
       NATIONAL_NAME,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING (NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '한국';

--------------------------------------------------------------------------------

/*
    1. VIEW 생성 방법
    [ 표현법 ]
    CREATE VIEW 뷰명
    AS 서브쿼리;
    
    CREATE OR REPLACE VIEW 뷰명
    AS 서브쿼리; -> OR REPLACE는 생략 가능!
    
*/

CREATE VIEW VW_EMPLOAEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING (NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- KH계정에 뷰 생성권한이 없음!!
-- 관리자계정에서  GRANT CREATE VIEW TO KH; 해주면 해결!!!

CREATE VIEW VW_EMPLOYEE
    AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
          FROM
               EMPLOYEE
          JOIN
               DEPARTMENT ON (DEPT_ID = DEPT_CODE)
          JOIN
               JOB USING (JOB_CODE)
          JOIN
               LOCATION ON (LOCATION_ID = LOCAL_CODE)
          JOIN
               NATIONAL USING (NATIONAL_CODE));
    -- VW_EMLPYOEE

SELECT * FROM VW_EMPLOYEE;
-- 복잡한 쿼리문을 뷰로 만들어 그때그때 필요한 데이터들만 조회가 가능하다 
-- 서브쿼리로 사용하는것보다 훨씬 간단하게 해결 가능

SELECT * FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '한국';
 
SELECT * FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '러시아';

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '일본';


SELECT BONUS FROM VW_EMPLOYEE;
-- VW-EMPLOYEE 뷰에 BONUS커럼이 존재하지 않기 때문에 오류 발생

CREATE OR REPLACE VIEW VW_EMPLOYEE
    AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
          FROM
               EMPLOYEE
          JOIN
               DEPARTMENT ON (DEPT_ID = DEPT_CODE)
          JOIN
               JOB USING (JOB_CODE)
          JOIN
               LOCATION ON (LOCATION_ID = LOCAL_CODE)
          JOIN
               NATIONAL USING (NATIONAL_CODE));
-- 보너스컬럼이 없는 뷰였는데 보너스 컬럼도 조회를 하고싶다.
-- CREATE OR REPLACE를 사용!!

SELECT BONUS FROM VW_EMPLOYEE;
-- 기존의 오류가 사라짐!!
/*
    OR REPLACE
    뷰 생성 시 기존에 중복된 이름의 뷰가 존재하지 않는다면 새롭게 뷰를 생성하고
             만약에 중복된 뷰가 있다면 해당 뷰를 변경(갱신)하는 옵션
*/

-- VIEW는 논리적인 가상테이블 (실제존재 X)
-- 실제 데이터를 저장하고 있지 않음!!(쿼리문을 TEXT형태로 저장하고 있음)
SELECT * FROM USER_VIEWS;
--------------------------------------------------------------------------------
/*
    * 뷰 컬럼에 별칭 부여
    서브쿼리의 SELECT절에 함수나 산술연산식이 기술되는 경우 반드시 별칭 지정
*/
-- 사원의 사번, 이름, 직급명, 성별, 근무년수를 조회할 수 있는 SELECT문을 뷰로 정의
CREATE OR REPLACE VIEW VIEW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'),
              EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
         FROM EMPLOYEE
         JOIN JOB USING(JOB_CODE);
-- 별칭을 지정하지 않아 오류 발생
-- ORA-00998: must name this expression with a column alias

CREATE OR REPLACE VIEW VIEW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별,
              EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
         FROM EMPLOYEE
         JOIN JOB USING(JOB_CODE);
-- 뷰 생성 성공

SELECT * FROM VIEW_EMP_JOB;

-- 별칭부여시 다른방법!!(단, 모든 컬럼에 대한 별칭을 다 부여해야함!!)
CREATE OR REPLACE VIEW VIEW_EMP_JOB (사번, 사원명, 직급명, 성별, 근무년수)
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'),
              EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
         FROM EMPLOYEE
         JOIN JOB USING(JOB_CODE);

SELECT 사원명, 근무년수
  FROM VIEW_EMP_JOB;

SELECT *
  FROM VIEW_EMP_JOB
 WHERE 근무년수 >= 20;

-- 뷰를 삭제하려고 한다면??
DROP VIEW VIEW_EMP_JOB;

--------------------------------------------------------------------------------

/*
    * 생성한 뷰를 이용해서 DML(DELETE, INSERT, UPDATE) 사용가능
    단, 뷰를 통해서 DML구문을 수행하게 되면 실제 데이터가 담겨있는 테이블(베이스테이블)에도 적용이 된다!!
*/
CREATE OR REPLACE VIEW VW_JOB
    AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;

-- 뷰에 INSERT
INSERT INTO VW_JOB VALUES('J8', '인턴');

SELECT * FROM JOB;

-- VIEW UPDATE!
UPDATE VW_JOB
   SET JOB_NAME = '알바'
 WHERE JOB_CODE = 'J8';

-- VIEW DELETE
DELETE FROM VW_JOB
 WHERE JOB_CODE = 'J8';
 
 SELECT * FROM JOB;

--------------------------------------------------------------------------------
/*
    VIEW를 가지고 DML이 불가능한 경우!!!
    
    1) VIEW에 정의되지 않은 컬럼을 조작하는 경우
    2) VIEW에 정의되지 않은 커럼 중에 베이스테이블에 NOT NULL제약조건이 지정되어있는 경우
    3) 산술연산식 또는 함수를 통해서 정의한 경우
    4) GROUP BY 그룹함수 절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 매칭시켜놓은 경우    
*/
--------------------------------------------------------------------------------
/*
    * VIEW 옵션 
    
    [ 상세표현법 ]
    CREATE OR REPLACE FORCE/NOFORCE VIEW 뷰명
    AS 서브쿼리
    WITH CHECK OPTION
    WITH READ ONLY;
    
    1) OR REPLACE : 해당 뷰가 존재하지 않으면 새로 생성 / 해당 뷰가 존재한다면 갱신시켜주는 옵션
    2) FORCE / NOFORCE
        - FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성
        - NOFORCE(생략시 기본값) : 서브쿼리에 기술된 테이블이 반드시 존재해야만 뷰가 생성
    3) WITH CHECK OPTION : 서브쿼리에 조건절에 기술된 내용에 만족하는 값으로만 DML이 가능
                           조건에 부합하지 않은 값으로 수정하는 경우 오류 발생
    4) WITH READ ONLY : 뷰에 대해 조회만 가능(DML 수행 불가)
*/

-- 2) FORCE / NOFORCE 
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_TEST
    AS SELECT TCODE, TNAME, TCONTENT
         FROM T;
-- ORA-00942: table or view does not exist
-- T라는 테이블이 존재하지 않기 때문에 오류 발생!

CREATE OR REPLACE FORCE VIEW VW_TEST
    AS SELECT TCODE, TNAME, TCONTENT
         FROM T;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM VW_TEST;
-- 오류 발생
-- 단, 접속 탭에서 KH-뷰를 열어보면 VW_TEST뷰가 생성이 된 것은 확인이 가능!

CREATE TABLE T(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(40)
);

SELECT * FROM VW_TEST;
-- T 테이블 생성 후 다시 뷰를 조회하면 정상적으로 확인이 가능!!


-- 3) WITH CHECK OPTION
CREATE OR REPLACE VIEW VW_EMP
    AS SELECT *
         FROM EMPLOYEE
        WHERE SALARY >= 3000000
  WITH CHECK OPTION; -- 위에 기술한 WHERE 조건절  

SELECT * FROM VW_EMP;

UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 200;
-- 서브쿼리에 기술한 조건절에 부합하지 않기 때문에 변경 불가

UPDATE VW_EMP
   SET SALARY = 5000000
 WHERE EMP_ID = 200;
-- 서브쿼리에 기술한 조건에 부합하기 때문에 변경가능! 

SELECT * FROM VW_EMP;

ROLLBACK;


-- 4) WITH READ ONLY   -- 줄여서 RO라고 씀

CREATE OR REPLACE VIEW VW_EMPBONUS
    AS SELECT EMP_ID, EMP_NAME, BONUS
         FROM EMPLOYEE
        WHERE BONUS IS NOT NULL
  WITH READ ONLY;
  
SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
 WHERE EMP_ID = 207;
-- SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view
-- DML 수행불가!!

















































