/*
    < DML : DATA MANIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입(INSERT) 하거나, 기존의 데이터를 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
    DML INSERT UPDATE DELETE 
*/

/*
    1. INSERT : 테이블에 새로운 행을 추가하는 구문
    
    [ 표현법 ]
    1) INSERT INTO 테이블명 VALUES(값, 값, 값, 값, ....);
    => 해당 테이블에 모든 컬럼에 값을 추가하고자 할 때 내가 직접 값을 제시해서 한 행을 INSERT 할 수 있음
    주의할 점 : 컬럼 순번을 지켜서 VALUES괄호 안에 값을 나열해야 함
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES (900, '홍길동', '550101-1010101', 'HONG@NAVER.COM', '01012341234', 'D1', 'J1', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);

SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       EMP_ID = '900';

/*
    2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값, 값, 값);
    => 해당 테이블에 특정 컬럼만 선택해서 그 컬럼에 추가할 값만 제시할 때 사용
    한 행 단위로 추가되기 때문에 선택을 하지 않은 컬럼은 기본적으로 NULL값이 들어감
    (단, DEFAULT(기본값)이 지정되어있을 경우 기본값이 들어감)
    주의할점 : NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값을 제시해야함
            -> NOT NULL 제약조건이 걸려있는 컬럼도 기본값이 지정되어있다면 선택 안할 수 있음
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL)          -- 최소 이정도는 쓸 줄 알아야함
VALUES (901,'김길동', '222222-0222222', 'D1', 'J2', 'S1');

SELECT * FROM EMPLOYEE;

/*
    3) INSERT INTO 테이블명 (서브쿼리)
    => VALUES로 값을 기입하는 대신 서브쿼리로 조회한 RESULT SET을 통채로 INSERT하는 구문(여러 행을 INSERT할 수 있음)
*/
-- 새로운 테이블 먼저 만들기
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);

SELECT * FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명을 조회한 결과를 EMP_01 테이블에 추가
INSERT INTO EMP_01
                    (
                      SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                        FROM EMPLOYEE, DEPARTMENT
                       WHERE DEPT_CODE = DEPT_ID(+)
                    );
                    
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------

/*
    2. INSERT ALL
    두 개 이상의 테이블에 각각 INSERT할 때 사용
    그 때 사용되는 서브쿼리가 동일한 경우
*/

-- 새로운 테이블 만들기
-- 첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명을 보관할 테이블
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);


-- 두번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명을 보관할 테이블
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- 급여가 300만원 이상인 사원들의 사번, 이름, 직급명, 부서명 조회
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
 WHERE
       SALARY >= 3000000;

/*
    1) INSERT ALL
       INTO 테이블명1 VALUES(컬럼명, 컬럼명, 컬럼명)
       INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명)
           서브쿼리;
*/          

-- EMP_JOB 테이블에는 급여가 300만원 이상인 사원들의 EMP_ID, EMP_NAME, JOB_NAME을 INSERT
-- EMP_DEPT 테이블에는 급여가 300만원 이상인 사원들의 EMP_ID, EMP_NAME, DEPT_TITLE을 INSERT

INSERT ALL                                              
  INTO EMP_JOB VALUES (EMP_ID, EMP_NAME, JOB_NAME)      -- 9개 행이 추가
  INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_TITLE)   -- 9개 행이 추가  총 18개 행
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
 WHERE
       SALARY >= 3000000;

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- INSERT ALL시 조건을 추가해서 각 테이블에 INSERT

-- 사번, 사원명, 입사일, 급여 (EMP_OLD) => 2010년도 이전 입사한 사원
CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
       WHERE 1 = 0;


-- 사번, 사원명, 입사일, 급여 (EMP_NEW) => 2010년도 이후 입사한 사원
CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
       WHERE 1 = 0;

SELECT
       EMP_ID,
       EMP_NAME,
       HIRE_DATE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       HIRE_DATE >= '2010/01/01';
--       HIRE_DATE < '2010/01/01';

/*
    2) INSERT ALL
       WHEN 조건1 THEN
       INTO 테이블명1 VALUES(컬럼명, 컬럼명, 컬럼명)
       WHEN 조건2 THEN
       INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명)
       서브쿼리   
*/

INSERT ALL 
  WHEN HIRE_DATE < '2010/01/01' THEN
  INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
  WHEN HIRE_DATE >= '2010/01/01' THEN
  INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT
       EMP_ID,
       EMP_NAME,
       HIRE_DATE,
       SALARY
  FROM
       EMPLOYEE;
       
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

--------------------------------------------------------------------------------
/*
    3. UPDATE
    테이블에 기록된 기존의 데이터를 수정하는 구문
    
    [ 표현법 ]
    UPDATE 테이블명
        SET 컬럼명 = 바꿀 값
           ,컬럼명 = 바꿀 값
           ,컬럼명 = 바꿀 값
           ,... => 여러 개의 컬럼값 동시 변경 가능(,로 나열해야함 AND쓰면 안됨!!!)
     WHERE 조건; => WHERE절은 생략 가능, 생략 시 전체 모든 행의 데이터가 다 바뀜----거의 쓴다고 보면 됨
*/

-- 복사본 테이블 하나 생성!
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;
    
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에 D9부서의 부서명을 전략기획팀으로 수정
UPDATE DEPT_COPY
   SET DEPT_TITLE = '전략기획팀' -- 전체 행 DEPT_TITLE컬럼의 모든 행을 다 전략기횓팀으로 바꿔라
 WHERE DEPT_TITLE = '총무부';
-- DEPT_TITLE 값이 총무부인 부서만을 찾아서 변경


CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
       FROM EMPLOYEE;
       
SELECT * FROM EMP_SALARY;

-- EMP_SALARY 테이블에 홍길동 사원의 급여를 1000만원으로 변경
UPDATE EMP_SALARY
   SET SALARY = 10000000
 WHERE EMP_NAME = '홍길동';
 
-- 전체사원의 급여를 기존의 급여에 20프로 인상한 금액으로 변경
UPDATE EMP_SALARY
   SET SALARY = SALARY * 1.2;
   

/*
    * UPDATE시 서브쿼리를 사용
    
    UPDATE 테이블명
       SET 컬럼명 = (서브쿼리)
*/

-- EMP_SALARY테이블에 '홍길동'사원의 부서코드를 '선동일' 사원의 부서코드로 변경
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '선동일';


UPDATE EMP_SALARY
   SET DEPT_CODE = (SELECT
                          DEPT_CODE
                     FROM
                          EMPLOYEE
                    WHERE
                          EMP_NAME = '선동일')
 WHERE
       EMP_NAME = '홍길동';

SELECT * FROM EMP_SALARY;   


-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스값으로 변경
SELECT
       SALARY
      ,BONUS
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '유재식';
       
       
UPDATE
       EMP_SALARY
   SET (SALARY ,BONUS)  = (SELECT SALARY ,BONUS
                             FROM EMP_SALARY
                            WHERE EMP_NAME = '유재식')
 WHERE EMP_NAME = '방명수';
      
SELECT * FROM EMP_SALARY;

--------------------------------------------------------------------------------

-- 송중기 사원의 사번을 200번으로 변경
UPDATE EMPLOYEE
   SET EMP_ID = 200
 WHERE EMP_NAME = '송중기'; --PRIMARY KEY 제약조건 위배!!
 
-- 사번이 200번인 사원의 이름을 NULL로 변경
UPDATE EMPLOYEE
   SET EMP_NAME = NULL
 WHERE EMP_ID = 200; -- NOT NULL 제약조건에 위배!!

-- UPDATE 시에도 변경할 값이 해당 컬럼에 대한 제약조건에 위배되면 안됨!!!

COMMIT; -- 모든 변경사항들을 확정하는 명령어

--------------------------------------------------------------------------------
/*
    4. DELETE
    테이블에 기록된 데이터를 삭제하는 구문
    
    [ 표현법 ]
    DELETE FROM 테이블명
     WHERE 조건; => WHERE 생략가능, 생략 시 해당 테이블 전체 행 삭제
*/

DELETE FROM EMPLOYEE; -- EMPLOYEE 테이블에 모든 행 삭제

ROLLBACK; -- 롤백 시 마지막 커밋 시점으로 돌아감

SELECT * FROM EMPLOYEE;

-- 홍길동과 김길동 직원의 데이터 지우기
DELETE FROM EMPLOYEE
 WHERE EMP_NAME IN ('홍길동', '김길동');

COMMIT;

-- DEPARTMENT 테이블로부터 DEPT_ID가 D1인 부서 삭제
DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D1';


-- DEPARTMENT 테이블로부터 DEPT_ID가 D3인 부서 삭제
DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D3';
 
ROLLBACK;

/*
    * TRUNKCATE : 테이블의 전체 행을 삭제할 때 사용하는 구문(절삭)
                  별도의 조건 제시 불가, ROLLBACK이 불가능!!!
                  DELETE보다 수행속도가 더 빠름!!!!!!
    [ 표현법 ]
    
    TRUNCATE TABLE 테이블명;            |         DELETE FROM 테이블명;
 --------------------------------------------------------------------------
    별도의 조건 제시 불가                 |          특정 조건 제시 가능
    수행 속도 빠름                       |            수행속도 느림
    ROLLBACK 불가능                     |            ROLLBACK도 가능   
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY; -- 0.042초

ROLLBACK;

TRUNCATE TABLE EMP_SALARY; -- 0.165초
-- Table EMP_SALARY이(가) 잘렸습니다.













