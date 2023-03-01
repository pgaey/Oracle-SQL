

/*
    < SELECT >
    데이터를 조회하거나 검색할 때 사용하는 명령어
    
    - Result Set : SELECT구문을 통해 조회된 데이터의 결과물을 의미
                    즉, 조회된 행들의 집합 
                    
    [ 표현법 ]
    SELECT 조회하고자 하는 컬럼, 컬럼, 컬럼, ...
      FROM 테이블명
*/

-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼만을 조회

SELECT 
       EMP_ID
      ,EMP_NAME
      ,SALARY
  FROM
       EMPLOYEE;
  
-- EMPLOYEE 테이블의 전체 사원들의 모든 컬럼을 다 조회
SELECT
       *
  FROM
       EMPLOYEE;
  
-- 명령어, 키워드, 테이블명, 컬럼명 대소문자를 가리지 않음
-- 소문자로 해도 무방, 단, 대문자로 쓰는 습관을 들이도록 하자........

----- 실습 문제 -----

-- 1. JOB 테이블의 모든 컬럼 조회
SELECT 
       *
  FROM
       JOB;

-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT 
       JOB_NAME
  FROM
       JOB;

-- 3. DEPARTMENT테이블의 모든 컬럼 조회
SELECT 
       *
  FROM
       DEPARTMENT;

-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 입사일 컬럼만 조회
SELECT
       EMP_NAME
      ,EMAIL
      ,PHONE
      ,HIRE_DATE
  FROM 
       EMPLOYEE;

-- 5. EMPLOYEE테이블의 입사일, 직원명, 급여 컬럼만 조회
SELECT
       HIRE_DATE
      ,EMP_NAME
      ,SALARY
  FROM
       EMPLOYEE;
------------------------------------------------
/*
    < 컬럼값을 산술연산 >
    조회하고자 하는 컬럼들을 나열하는 SELECT절에 산술연산( + - * / )을 기술해서 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉
SELECT
       EMP_NAME
      ,SALARY
      ,SALARY * 12
  FROM
       EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스, 보너스가 포함된 연봉
SELECT
       EMP_NAME
      ,SALARY
      ,BONUS
      ,(SALARY + BONUS * SALARY) * 12
  FROM
       EMPLOYEE;
--> 산술연산을 하는 과정에서 NULL값이 존재한다면 산술연산의 결과마저도 NULL이 된다.
      
-- EMPLOYEE 테이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일) 조회
-- DATE 타입끼리도 연산가능(DATE => 년, 월, 일, 시, 분, 초)
-- 오늘날짜 : SYSDATE
SELECT
       EMP_NAME
      ,HIRE_DATE
      ,SYSDATE - HIRE_DATE
  FROM
       EMPLOYEE;
-- 값이 지저분한 이유는 DATE타입안에 포함되어있는 시/분/초에 대한 연산까지 수행하기 때문
-- 날짜 . 시분초

--------------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지칭하기 >
    [ 표현법 ]
    컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 별칭, 컬럼명 "별칭"
    
    AS를 써도 되고 안써도 되는데
    별칭에 특수문자나 공백문자가 포함될 경우 반드시 ""로 묶어서 표기해야함
*/

SELECT
       EMP_NAME AS 이름
      ,SALARY AS "급여(월)"  -- 쌍따옴표를 안하게 되면 ()를 연산자로 인식해서 오류 발생
      ,BONUS 보너스
      ,((SALARY + BONUS * SALARY) * 12) "총 소득"  -- 공백문자를 사용할 때도 "" 사용.
  FROM
       EMPLOYEE;
--------------------------------------------------------------------------
/*
    < 리터럴 >
    
    임의로 지정한 문자열을 SELECT절에 기술하면
    실제 테이블에 존재하는 데이터처럼 조회가 가능하다.
*/

-- EMPLOYEE 테이블로부터 사번, 사원명, 급여 단위 조회하기
SELECT EMP_ID
      ,EMP_NAME
      ,SALARY
      ,'원' 단위
  FROM
       EMPLOYEE;
-- SELECT절에 제시한 리터럴 값은 조회결과인 RESULT SET의 모든 행에 반복적으로 출력됨
--------------------------------------------------------------------------
       
  /*
      < DISTINCT >
      조회하고자 하는 컬럼에 중복된 값을 딱 한번씩만 조회하고자 할 때 사용
  
      [ 표현법 ]
      DISTINCT 컬럼명
      
      (단, SECELCT절에 DITINCT구문에 단 한개만 사용 가능하다.)
  */
SELECT DISTINCT
       DEPT_CODE
  FROM
       EMPLOYEE;

SELECT DISTINCT
       JOB_CODE
  FROM
       EMPLOYEE;
------------------------------------------------------------------------

/*
    < WHERE 절 >
    조회하고자 하는 테이블에 특정 조건을 제시해서
    그 조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문
    
    [ 표현법 ]
    SELECT 조회하고자 하는 컬럼, 컬럼, ...
      FROM 테이블명
     WHERE 조건식;
     
     - 조건식 다양한 연산자들이 사용 가능
     
     < 비교 연산자 >
     >, <, >=, <=
        =(일치하는가? : 자바에서 동등비교는 ==)
    !=, ^=, <>(일치하지 않는가?)
    
    실행순서 FROM절 -> WHERE절 -> SELECT절
*/

SELECT
       *
  FROM 
       EMPLOYEE;
  
-- EMPLOYEE 테이블로부터 금여가 400만원 이상인 사원들의 모든 컬럼을 조회
SELECT 
       *
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 4000000;
  
-- EMPLOYEE테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여 조회
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D9';

-- EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE != 'D9';
--     DEPT_CODE <> 'D9';
--     DEPT_CODE ^= 'D9';

--------------------------- 실습문제 ------------------------------

-- 1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT
       EMP_NAME AS "이름"
      ,SALARY AS "급여"
      ,HIRE_DATE AS "입사일"
  FROM
       EMPLOYEE 
 WHERE
       SALARY >= 3000000;
       
-- 2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT
       EMP_NAME AS "이름"
      ,SALARY AS "급여"
      ,BONUS AS "보너스"
  FROM
       EMPLOYEE
 WHERE
       JOB_CODE = 'J2';

-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT
       EMP_ID AS "사번"
      ,EMP_NAME AS "이름"
      ,HIRE_DATE AS "입사일 조회"
  FROM
       EMPLOYEE
 WHERE
       ENT_YN = 'N';

-- 4. EMPLOYEE 테이블에서 연봉(급여 * 12)이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT
       EMP_NAME 이름
      ,SALARY AS 급여
      ,(SALARY * 12) AS "연봉"
      ,HIRE_DATE "입사일"
  FROM
       EMPLOYEE
 WHERE
       (SALARY * 12) >= 50000000;
--> SELECT절에 부여한 별칭을 WEHRE절에서 사용할 수 없음
--> FROM -> WHERE -> SELECT 순서라 WHERE절에서는 "연봉" 별칭이 입력되지 않음.
-----------------------------------------------------------------
/*
    < 논리연산자 >

    여러개의 조건을 엮을 때 사용

    AND(~이면서, 그리고) OR(~이거나, 또는)
*/

-- 부서코드가 'D9'면서 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE -- 부서코드가 'D9', 급여가 500만원 이상
       DEPT_CODE = 'D9' AND SALARY >= 5000000;
       
-- 부서코드가 'D9'이거나 급여가 300만원 이상인 사원들의 이름, 부서코드, 급여 조회
SELECT 
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D9' OR SALARY >= 3000000;
  
-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT
       EMP_NAME
      ,EMP_ID
      ,SALARY
      ,JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       3500000 <= SALARY AND SALARY <= 6000000;
------------------------------------------------------------------------
/*
    < BETWEEN AND >
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    [ 표현법 ]
    비교대상컬럼명 BETWEEN 하한값 AND 상한값
*/
  
-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT
       EMP_NAME
      ,EMP_ID
      ,SALARY
      ,JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY BETWEEN 3500000 AND 6000000;
       
-- 급여가 350만원 미만이고 600만원 초과인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT
       EMP_NAME
      ,EMP_ID
      ,SALARY
      ,JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY NOT BETWEEN 35000000 AND 6000000; -- NOT
--> 오라클에서의 NOT은 자바의 논리부정연산자 !와 동일한 의미

-- ** BETWEEN AND연산자는 DATE형식간에서도 사용 가능
-- 입사일이 '90/01/01' ~ '03/01/01'인 사원들의 모든 컬럼 조회
SELECT
       *
  FROM
       EMPLOYEE
 WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
 
-- 입사일이 '09/01/01' ~ '03/01/01'이 아닌 사원들의 모든 컬럼 조회

SELECT
        *
  FROM
        EMPLOYEE
 WHERE NOT HIRE_DATE BETWEEN '09/01/01' AND '03/01/01';
 
-------------------------------------------------------------------
/*
    < LIKE '특정 패턴'>
    비교하려는 컬럼 값이 내가 지정한 특정 패턴에 만족할 경우 조회
    
    [ 표현법 ]
    비교대상컬럼명 LIKE '특정 패턴';
    
    -- 특정 패턴에 와일드카드 '%', '_'를 가지고 제시할 수 있음
    '%' : 0글자 이상 
        비교대상컬럼명 LIKE '문자%' => 컬럼값 중 '문자'로 시작하는 것을 조회
        비교대상컬럼명 LIKE '%문자' => 컬럼값 중 '문자'로 끝나는 것을 조회
        비교대상컬럼명 LIKE '%문자%' => 컬럼값 중 '문자'가 포함되는 것을 조회
    
    '_' : 1글자
        비교대상컬럼명 LIKE '_문자' => 해당 컬럼 값 중에 '문자'앞에 무조건 1글자가 있을 경우 조회
        비교대상컬럼명 LIKE '__문자' => 해당 컬럼 값 중에 '문자'앞에 무조건 2글자가 있을 경우 조회
        비교대상컬럼명 LIKE '__문자_' => 해당 컬럼 값 중에 '문자'앞에 2글자, 뒤에 1글자가 있을 경우 조회
    
*/

-- 성이 전씨인 사원들의 이름, 급여, 입사일 조회
SELECT
       EMP_NAME
      ,SALARY
      ,HIRE_DATE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT
       EMP_NAME
      ,EMP_NO
      ,DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '%하%';
       
-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT
       EMP_NO AS "사번"
      ,EMP_NAME AS "사원명"
      ,PHONE AS "전화번호"
      ,EMAIL AS  "이메일"
  FROM
       EMPLOYEE
 WHERE
       PHONE LIKE '___9%';
       
-- 이름 가운데 글자가 '지'인 사원들의 모든 컬럼
SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '_지_';

-- 그 외인 사원
SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME NOT LIKE '_지_';
  
---------------------------- 실습 문제 -------------------------------
-- 1. 이름이 '연'으로 끝나는 시원들의 이름, 입사일을 조회
SELECT
       EMP_NAME 이름
      ,HIRE_DATE  입사일
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '%연';
       
-- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT
       EMP_NAME AS 이름
      ,PHONE AS 전화번호
  FROM
       EMPLOYEE
 WHERE
       PHONE NOT LIKE '010%';

-- 3. DEPARTMENT테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT
       *
  FROM
       DEPARTMENT
 WHERE
       DEPT_TITLE LIKE '해외영업%';

------------------------------------------------------------

SELECT 
       *
  FROM
       EMPLOYEE;
  
/*
    < IS NULL >
    
    [ 표현법 ]
    비교대상컬럼 IS NULL : 컬럼값이 NULL인 경우
    비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닌 경우
*/
  
-- 보너스를 받지 않는 사원들(BONUS컬럼값이 NULL)인 사번, 이름, 급여, 보너스
SELECT
       EMP_ID
      ,EMP_NAME
      ,SALARY
      ,BONUS
  FROM
       EMPLOYEE
 WHERE
       BONUS IS NULL;

-- 보너스를 받는 사원들
SELECT
       EMP_ID
      ,EMP_NAME
      ,SALARY
      ,BONUS
  FROM
       EMPLOYEE
 WHERE 
       BONUS IS NOT NULL;

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT
       EMP_NAME
      ,MANAGER_ID
      ,DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       MANAGER_ID IS NULL;
       
-- 사수도 없고 부서배치도 받지 않은 사원들의 모든 컬럼 조회
SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       MANAGER_ID IS NULL
       AND
       DEPT_CODE IS NULL;
  
-- 부서배치는 받지 않았지만 보너스는 받는 사원 조회(사원명, 보너스, 부서코드)
SELECT
       EMP_NAME
      ,BONUS
      ,DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IS NULL
   AND BONUS IS NOT NULL;
       
----------------------------------------------------------------------

-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
-- WHERE
--       DEPT_CODE = 'D6'
--    OR DEPT_CODE = 'D8'
--    OR DEPT_CODE = 'D5';
 WHERE
       DEPT_CODE IN ('D6', 'D8', 'D5');
/*
    <IN>
    비교 대상 컬럼값에 내가 제시한 목록들 중에 일치하는 값이 있는지
    
    [ 표현법 ]
    비교대상컬럼 IN (값, 값, 값, ...)
*/

-- 그 외의 사원들
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE NOT IN ('D6', 'D8', 'D5');

-------------------------------------------------------------------------------
/*
    < 연결 연산자 || >
    여러 컬럼 값들을 마치 하나의 컬럼인 것처럼 연결시켜주는 연산자
    
    
*/

SELECT
       EMP_ID || EMP_NAME || SALARY AS "연결됨"
  FROM
       EMPLOYEE;
       

SELECT EMP_ID || '번 ' || EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여정부"
  FROM EMPLOYEE;
       
--------------------------------------------------------------------------------
/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자 
    2. 연결연산자
    3. 비교연산자
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND
    8. OR
*/
--------------------------------------------------------------------------------
/*
    < ORDER BY 절 >          이게 안써있으면 정렬이 안되어있다는 뜻
    SELECT문 가장 마지막에 기입하는 구문 뿐만아니라 실행순서 또한 가장 마지막
    
    
    < 표현법 >
    SELECT 조회할 컬럼, 컬럼, ...
      FROM 조회할 테이블 명
     WHERE 조건식 (생략가능)
     ORDER BY [정렬기준으로 세우고자하는 컬럼명/별칭/컬럼순번] [ASC/DESC] [NULLS FIRST/NULLS LAST](생략가능)
     
     -- ASC : 오름차순 정렬(생략 시 기본값)
     -- DESC : 내림차순 정렬
     
     -- NULLS FIRST : 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 앞으로 배치(내림차순 정렬일 경우 기본값)
     -- NULLS LAST  : 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 뒤로 배치(오름차순 정렬일 경우 기본값)
     
*/

SELECT
       *
  FROM
       EMPLOYEE
-- ORDER
--    BY BONUS;                  -- ASC 또는 DESC 생략 시 기본값이 ASC(오름차순)
-- ORDER
--    BY BONUS ASC;              -- ASC는 기본적으로 NULLS LAST임을 알 수 있다.
-- ORDER
--    BY BONUS ASC NULLS FIRST; 
--ORDER
--   BY BONUS DESC;              -- DESC는 기본적으로 NULLS FIRST임을 알 수 있다.
ORDER
   BY BONUS DESC, SALARY ASC;
-- 첫 번째로 제시한 정렬기준의 컬럼값이 일치할 경우 두 번째 정렬기준을 가지고 다시 정렬할 수 있음


SELECT
       EMP_NAME
      ,SALARY * 12 AS "연봉"
  FROM
       EMPLOYEE
 WHERE SALARY * 12 >= 200000
-- ORDER BY SALARY * 12 DESC;
 ORDER 
    BY 연봉 DESC;
-- ORDER BY 2 DESC;  -- 무슨 컬럼인지 알 수 없어서 권장X

       


