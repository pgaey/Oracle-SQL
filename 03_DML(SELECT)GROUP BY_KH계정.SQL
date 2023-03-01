/*
    < GROUP BY 절 >

    그룹을 묶어줄 기준을 제시할 수 있는 구문

    여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

-- 전체 사원의 총 급여 합
SELECT
       SUM(SALARY)
  FROM  
       EMPLOYEE;        --> 현재 조회된 전체사원들을 하나의 그룹으로 묶어서 총 합을 구한 결과
       
SELECT
       *
  FROM
       EMPLOYEE;
       
-- 각 부서별 총 급여 합
SELECT
       DEPT_CODE
      ,SUM(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;

-- 전체 사원 수
SELECT
       COUNT(*)
  FROM
       EMPLOYEE;
       
-- 각 부서별 사원 수
SELECT
       DEPT_CODE
      ,COUNT(*)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
       
       
-- 각 부서별 총 급여합을 부서별 오름차순 정렬
SELECT                          -- 3. SELECT 절
       DEPT_CODE "부서"
      ,SUM(SALARY) "급여합"
  FROM                          -- 1. FROM 절
       EMPLOYEE
 GROUP
    BY                          -- 2. GROUP BY 절
       DEPT_CODE
 ORDER
    BY                          -- 4. ORDER BY 절
       "부서" ASC;
-- ★ 실행순서 FROM절(맨 처음) -> WHERE절 -> SELECT절 -> ORDER BY(맨 마지막) ★

-- 각 직급별 직급코드, 총 급여의 합, 사원 수, 보너스를 받는 사원 수, 평균급여, 최소급여, 최고급여
SELECT
       JOB_CODE
      ,SUM(SALARY)
      ,COUNT(EMP_ID)        -- EMP_NAME 같은 GROUP BY 와 관련 없는 것들은 사용 불가
      ,COUNT(BONUS)
      ,ROUND(AVG(SALARY))
      ,MAX(SALARY)
      ,MIN(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY                      -- GROUPING 하지 않은 SELECT은 사용할 수가 없다!
       JOB_CODE;

-- 성별 별 사원 수
SELECT
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '2', '여자') AS "성별"
      ,COUNT(*) "사원 수"
  FROM
       EMPLOYEE
 GROUP
    BY
       SUBSTR(EMP_NO, 8, 1);

--------------------------------------------------------------------------------

-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT
       DEPT_CODE
      ,ROUND(AVG(SALARY))
  FROM                                      -- 1. FROM
       EMPLOYEE
 WHERE                                      -- 2. WHERE ★ 그룹을 안나눴을 때.
       ROUND(AVG(SALARY)) >= 3000000
 GROUP
    BY                                      -- 3. GROUP BY
       DEPT_CODE;

/*
    < HAVING 절 >
    그룹에 대한 조건을 제시하고자 할 때 사용하는 구문
    ( 주로 그룹함수를 가지고 조건을 제시 )
*/

SELECT
       DEPT_CODE
      ,ROUND(AVG(SALARY))
  FROM
       EMPLOYEE
 GROUP
    BY                                   -- 1. 그룹을 나누고
       DEPT_CODE
HAVING                                   -- 2. 그룹을 나눈 것들을 가지고.
       AVG(SALARY) >= 3000000;       

-- 각 직급별 총 급여의 합이 1000만원 이상인 직급 코드, 급여 합을 조회
SELECT
       DEPT_CODE
      ,SUM(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       JOB_CODE
HAVING
       SUM(SALARY) >=10000000;
       
-- 각 부서별 보너스를 받는 사원이 없는 부서만을 조회
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       COUNT(BONUS) = 0;
       
--------------------------------------------------------------------------------
/*
    ★★★★★★★★★★★★★★★★★★★★ < 실행 순서 > ★★★★★★★★★★★★★★★★★★★
    
    SELECT       * / 조회하고자 하는 컬럼명 / 산술연산식 / 함수식 AS "별칭"                       5번
      FROM       조회하고자하는 테이블명                                                      1번
     WHERE       조건식                                                                    2번
     GROUP BY    그룹 기준에 해당하는 컬럼명 / 함수식                                           3번
    HAVING       그룹함수식에 대한 조건식                                                     4번
     ORDER BY    정렬 기준에 해당하는 컬럼명 / 별칭 / 컬럼순번 ASC/DESC NULL FIRST / NULL LAST   6번
    
    FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/
--------------------------------------------------------------------------------
/*
    < 집합 연산자 SET OPERATOR >
    
    여러 개의 쿼리문을 가지고 하나의 쿼리문을 만드는 연산자
    
    - UNION(AND대체 가능) : 합집합 ( 두 쿼리문을 수행한 결과값을 더한 후 중복되는 부분은 한번 뺀 것)
    - INTERSECT(OR대체 가능) : 교집합 (두 쿼리문을 수행한 결과값의 중복된 결과값 부분)
    - UNION ALL★ : 합집합 결과에 교집합이 더해진 개념 (두 쿼리문을 수행한 결과값을 무조건 더함, 합집합에서 중복제거를 하지 않은 결과)
    - MINUS(대체 가능) : 차집합 (선행 쿼리문 결과값 빼기 후행 쿼리문 결과값의 결과)  
*/

-- 1. UNION(합집합)     OR 연산자로 대체 가능함.
-- 부서코드가 D5거나 급여가 300만원을 초과한 사원들 조회(사번, 사원명, 부서코드, 급여)

-- 부서코드가 D5인 사원들
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5';    --> 6명 조회(박나라, 하이유, 김해솔, 심봉선, 윤은해, 대북혼)

-- 급여가 300만원 초과인 사원들만 조회
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3000000;  --> 8명 조회(선동일, 송종기, 노옹철, 유재식, 정중하, 심봉선, 대북혼, 전지연)

SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3000000; --> 12명 조회 (6명 + 8명 - 2명)
-- 두 쿼리의 SELECT절이 같아야한다.
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5' OR SALARY >= 3000000;    --> 위 행과 동일.

-- (부서코드, 부서별 급여합)
--SELECT
--       DEPT_CODE
--      ,SUM(SALARY)
--  FROM
--       EMPLOYEE
-- WHERE
--       DEPT_CODE = 'D1'
-- UNION
-- SELECT
--       SUM(SALARY)
--  FROM
--       EMPLOYEE
-- WHERE
--       DEPT_CODE = 'D2'
-- UNION
-- SELECT
--       SUM(SALARY)
--  FROM
--       EMPLOYEE
-- WHERE
--       DEPT_CODE = 'D5';
       
SELECT
       DEPT_CODE
      ,SUM(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
--------------------------------------------------------------------------------

-- 2. UNION ALL : 여러개의 쿼리 결과를 무조건 더하는 연산자(중복값이 여러개 들어갈 수 있음)
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
   ALL
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3000000;
--------------------------------------------------------------------------------

-- 3. INTERSECT : 교집합     AND연산자로 대체 가능
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3000000;
--AND로 연산 가능
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5' AND SALARY >= 3000000;
--------------------------------------------------------------------------------

-- 4. MINUS : 차집합
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원을 제외해서 조회
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 MINUS
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3000000;
       
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
  FROM
       EMPLOYEE
 WHERE DEPT_CODE = 'D5' AND SALARY < 3000000;
--------------------------------------------------------------------------------










































































