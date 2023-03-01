/*
    < SUBQUERY 서브쿼리 >
   
   하나의 주된 SQL문(SELECT, INSERT, QPDATE, CREATE...) 안에 포함된 또 하나의 QUERY문
   MAIN SQL문을 위해 보조역할을 하는 쿼리문
*/

-- 간단 서브쿼리 예시!
SELECT
       *
  FROM
       EMPLOYEE;
-- 노옹철 사원과 같은 부서인 사원들의 사원명을 조회하고 싶다!
-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '노옹철';  -- 노옹철 사원의 부서코드는 D9

-- 2) 부서코드가 D9인 사원들 조회
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = 'D9';
       
       
-- 위의 두 단계를 하나의 쿼리문으로 합치기
SELECT
       EMP_NAME                                         -- MAINQUERY
  FROM
       EMPLOYEE E   
 WHERE
       DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM
                           EMPLOYEE                     -- 이걸 SUBQUERY 라고 함
                     WHERE
                           EMP_NAME = '노옹철');

-- 간단 서브쿼리 예시2
-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름, 직급코드 조회
-- 1) 전체 사원의 평균 급여 구하기
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE;
       
-- 2) 급여가 3,047,662원 이상인 사원들 조회
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3047662;
       
       
-- 위의 두 단계를 하나의 쿼리문으로 합치기
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY >= (SELECT
                         AVG(SALARY)
                    FROM
                         EMPLOYEE);
--------------------------------------------------------------------------------
/*
    서브쿼리 구분
    
    서브쿼리를 수행한 결과값이 몇 행 몇 열이냐에 따라서 분류
    
    - 단일행 [단일열] 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개 일 때
    - 다중행 [단일열] 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행일 때
    - [단일행] 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일 때
    - 다중행 다중열 서브쿼리   : 서브쿼리를 수행한 결과값이 여러 행, 여러 열일 때
    
    => 서브쿼리를 수행한 결과가 몇 행 몇 열이냐에 따라서 사용가능한 연산자가 달라짐
*/

/*
    1. 단일 행 서브쿼리(SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값이 오로지 1개 일 때
    
    일반 연산자(=, !=, <=, >....)
*/

-- 전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
-- 1)
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE;        -- 결과값이 1행 1열, 오로지 1개의 값
       
SELECT
       EMP_NAME,
       JOB_CODE,
       SALARY
  FROM 
       EMPLOYEE
 WHERE
       SALARY < (SELECT
                        AVG(SALARY)
                   FROM
                        EMPLOYEE);

-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
SELECT
       MIN(SALARY)
  FROM
       EMPLOYEE;            -- 결과값이 1행 1열 1개의 값
       
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE,
       SALARY,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE
       SALARY = (SELECT
                        MIN(SALARY)
                   FROM
                        EMPLOYEE);
                        
-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서명, 급여 조회
SELECT
       SALARY
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '노옹철';
       
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_TITLE,
       SALARY
  FROM
       EMPLOYEE E,
       DEPARTMENT D
 WHERE
       SALARY > (SELECT
                        SALARY
                   FROM
                        EMPLOYEE
                  WHERE
                        EMP_NAME = '노옹철')
   AND
       DEPT_CODE = DEPT_ID;
                        
-- 조인도 가능!

-- 전지연과 같은 부서인 사원들의 사번, 사원명, 전화번호, 직급명 조회(단, 전지연은 제외)
SELECT 
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '전지연';
    
SELECT
       EMP_ID,
       EMP_NAME,
       PHONE,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN JOB USING (JOB_CODE)
 WHERE
       DEPT_CODE = (SELECT 
                           DEPT_CODE
                      FROM
                           EMPLOYEE
                     WHERE
                           EMP_NAME = '전지연')
   AND EMP_NAME != '전지연';
   
-- 부서별 급여 합이 가장 큰 부서 하나만을 조회// 부서코드, 부서명, 급여합 조회

SELECT
       MAX(SUM(SALARY))
  FROM
       EMPLOYEE
  JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
 GROUP
    BY DEPT_TITLE;
    
SELECT
       DEPT_CODE,
       DEPT_TITLE,
       SUM(SALARY)
  FROM
       EMPLOYEE
  JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
 GROUP
    BY DEPT_TITLE, DEPT_CODE
HAVING SUM(SALARY) = (SELECT
                             MAX(SUM(SALARY))
                        FROM
                             EMPLOYEE
                        JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
                       GROUP
                          BY DEPT_TITLE);
    
SELECT                                          -- 내가 한거// 안됌.
       DEPT_CODE,
       DEPT_TITLE,
       SUM(SALARY)
  FROM
       EMPLOYEE
 WHERE
       SUM(SALARY) = (SELECT
                             MAX(SUM(SALARY))
                        FROM
                             EMPLOYEE E
                        JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
                       GROUP
                          BY DEPT_TITLE);
                          
                          
--------------------------------------------------------------------------------
/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
    서브쿼리의 조회 결과가 여러 행일 때
    
    - IN (10, 20, 30) 서브쿼리 : 여러 개의 결과값 중에서 하나라도 일치하는 값이 있으면
    
    - > ANY (10, 20, 30) 서브쿼리 : 여러 개의 결과값 중에서 "하나라도" 클 경우
                                   여러 개의 결과값 중에서 가장 작은 값 보다 클 경우
    - < ANY (10, 20, 30) 서브쿼리 : 여러 개의 결과값 중에서 "하나라도" 작을 경우
                                   여러 개의 결과값 중에서 가장 큰 값 보다 작을 경우
    ALL : 모든 AND
    - > ALL 서브쿼리 :  여러개의 결과값의 "모든"값보다 클 경우 == 여러개의 결과값 중에서 가장 큰 값 보다 클 경우
    - < ALL 서브쿼리 :  여러개의 결과값의 "모든"값보다 작을 경우 == 여러개의 결과값 중에서 가장 작은 값 보다 작을 경우
    
*/

-- 각 부서별로 최고 급여를 받는 사원의 이름, 직급코드, 급여 조회
-- 1) 각 부서별 최고 급여 조회
SELECT
       MAX(SALARY)
  FROM 
       EMPLOYEE
 GROUP
    BY DEPT_CODE;
    
-- 2) 위의 급여를 받는 사원들 조회
SELECT
       EMP_NAME,
       JOB_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY IN (SELECT
                         MAX(SALARY)
                    FROM 
                         EMPLOYEE
                   GROUP
                      BY DEPT_CODE);
                      
-- 선동일 또는 유재식 사원과 같은 부서인 사원들을 조회하시고(사원명, 부서코드, 급여)
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME IN ('유재식', '선동일');
       
SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IN (SELECT
                            DEPT_CODE
                       FROM
                            EMPLOYEE
                      WHERE
                            EMP_NAME IN ('유재식', '선동일'));
                            
select * from job;
-- 사원 < 대리 < 과장 < 차장 <부장
-- 대리직급임에도 불구하고 과장직급의 급여보다 많이 받는 직원(사번, 이름, 직급명, 급여)
-- 1) 과장 직급의 급여를 조회
SELECT
       SALARY
  FROM
       EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
 WHERE
       JOB_NAME = '과장'; -- 2200000, 2500000, 3760000

-- 2) 위의 급여보다 높은 급여를 받는 직원들 조회

SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       SALARY
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND SALARY > ANY (2200000, 2500000, 3760000);

-- 3) 위의 쿼리문을 하나의 쿼리문으로 합치기 + 대리직급만 조회
       
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       SALARY
  FROM
       EMPLOYEE
  JOIN JOB USING (JOB_CODE)
 WHERE
       JOB_NAME = '대리'
   AND
       SALARY > ANY(SELECT
                           SALARY
                      FROM
                           EMPLOYEE E
                      JOIN JOB J USING (JOB_CODE)
                     WHERE
                           JOB_NAME = '과장');
       
-- 사원 < 대리 < 과장 < 차장 < 부장
-- 과장 직급임에도 불구하고 모든 차장직급의 급여보다 더 많이 받는 직원 조회(사번, 이름, 직급명, 급여)
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       SALARY
  FROM
       EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
 WHERE
       JOB_NAME = '과장'
   AND SALARY > ALL(SELECT
                           SALARY
                      FROM
                           EMPLOYEE
                      JOIN JOB J USING (JOB_CODE)
                     WHERE
                           JOB_NAME = '차장');
/*
    ALL : 모든 AND
    - > ALL 서브쿼리 :  여러개의 결과값의 "모든"값보다 클 경우 == 여러개의 결과값 중에서 가장 큰 값 보다 클 경우
    - < ALL 서브쿼리 :  여러개의 결과값의 "모든"값보다 작을 경우 == 여러개의 결과값 중에서 가장 작은 값 보다 작을 경우
*/                           

--------------------------------------------------------------------------------

/*
    3. [ 단일행 ] 다중열 서브쿼리
    조회 결과 값은 한 행이지만 나열된 컬럼 수가 여러 개일 때
*/
-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회

-- > 하이유 사원의 부서코드와 직급코드 먼저 조회
SELECT
       DEPT_CODE,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '하이유';        -- D5 / J5

-- > 부서코드가 D5이면서 직급코드가 J5인 사원 조회
SELECT
       EMP_NAME,
       DEPT_CODE,
       JOB_CODE,
       HIRE_DATE
  FROM
       EMPLOYEE E
 WHERE
       DEPT_CODE = 'D5'
   AND JOB_CODE = 'J5';
   
-- >
SELECT
       EMP_NAME,
       SALARY
  FROM
       EMPLOYEE E
 WHERE
       DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM
                           EMPLOYEE
                     WHERE
                           EMP_NAME = '하이유')
   AND JOB_CODE = (SELECT
                          JOB_CODE
                     FROM
                          EMPLOYEE
                    WHERE
                          EMP_NAME = '하이유');

--> 다중열 서브쿼리
SELECT
       EMP_NAME,
       DEPT_CODE,
       JOB_CODE,
       HIRE_DATE
  FROM
       EMPLOYEE E
 WHERE
       (DEPT_CODE, JOB_CODE) = (SELECT
                                       DEPT_CODE,
                                       JOB_CODE
                                  FROM
                                       EMPLOYEE
                                 WHERE
                                       EMP_NAME = '하이유');
                                       
-- 박나라 사원과 같은 직급코드, 같은 사수사번을 가진 사원들의 사번, 이름, 직급코드, 사수사번 조회
SELECT
       JOB_CODE,
       MANAGER_ID
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '박나라';
       
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE,
       MANAGER_ID
  FROM
       EMPLOYEE
 WHERE (JOB_CODE, MANAGER_ID) = (SELECT
                                        JOB_CODE,
                                        MANAGER_ID
                                   FROM
                                        EMPLOYEE
                                  WHERE
                                        EMP_NAME = '박나라');

--------------------------------------------------------------------------------
/*
    4. 다중행 다중열 서브쿼리
    서브쿼리 조회 결과값이 여러 행 여러 컬럼일 경우!
*/
 
-- 각 직급별 최소 급여를 받는 사원들 조회(사번, 이름, 직급코드, 급여)

--> 각 직급별 최소 급여

SELECT
       JOB_CODE,
       MIN(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY JOB_CODE;

SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE,
       SALARY
  FROM
       EMPLOYEE
-- 내용들을 하나로 합쳐서 하나의 쿼리문으로 만들기
 WHERE
       (JOB_CODE, SALARY) IN (SELECT
                                     JOB_CODE,
                                     MIN(SALARY)
                                FROM
                                     EMPLOYEE
                               GROUP
                                  BY JOB_CODE);
       
-- 각 부서별로 최고 급여를 받는 사원들 조회(사번, 이름, 부서코드, 급여)
SELECT
       NVL(DEPT_CODE, '부서없음'),
       MAX(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY DEPT_CODE;
    
SELECT
       EMP_ID,
       EMP_NAME,
       NVL(DEPT_CODE, '부서없음') "부서",
       SALARY
  FROM
       EMPLOYEE
 WHERE
       (NVL(DEPT_CODE, '부서없음'), SALARY) IN (SELECT
                                                     NVL(DEPT_CODE, '부서없음'),
                                                     MAX(SALARY)
                                                FROM
                                                     EMPLOYEE
                                               GROUP
                                                  BY DEPT_CODE)
 ORDER
    BY 
    "부서" ASC ;
--------------------------------------------------------------------------------
/*
    5. 인라인 뷰(INLINE - VIEW) ★ 많이 사용
    FROM절에 서브쿼리를 제시하는 것
    
    서브쿼리를 수행한 결과(RESULT SET)를 테이블 대신 사용!
*/

-- 보너스 포함 연봉이 3000만원 이상인 사원들의 사번, 이름, 보너스 포함 연봉, 부서코드를 조회
SELECT
       EMP_ID,
       EMP_NAME,
       (SALARY + (NVL(BONUS, 0)*SALARY)) * 12 "연봉",
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       (SALARY + (NVL(BONUS, 0)*SALARY)) * 12 >= 30000000;

SELECT
       *
  FROM
       (SELECT
               EMP_ID,
               EMP_NAME,
               (SALARY + (NVL(BONUS, 0)*SALARY)) * 12 "보너스 포함 연봉",
               DEPT_CODE
          FROM
               EMPLOYEE)
 WHERE "보너스 포함 연봉" >= 30000000;
    
--> 인라인 뷰를 주로 사용하는 예
-- TOP-N분석 : 데이터베이스 상에 있는 자료 중 최상위 몇 개의 자료를 보기 위해 사용하는 방법

-- 전 직원 중 급여가 가장 높은 상위 5명
-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 붙여줌
SELECT
       ROWNUM,
       EMP_NAME, 
       SALARY
  FROM
       EMPLOYEE
 WHERE ROWNUM <= 5
 ORDER BY
       SALARY DESC;

-- ORDER BY절을 사용해서 정렬한 RESULTSET을 가지고 ROWNUM순번 부여후에 ROWNUM <= 5
SELECT
       ROWNUM "순번",
       E.*
FROM ( SELECT EMP_NAME, SALARY
         FROM
              EMPLOYEE
        ORDER BY
              SALARY DESC) E
 WHERE
       ROWNUM <= 5;

-- 각 부서별 평균 급여가 높은 3개 부서의 부서코드, 평균 급여 조회
SELECT
       DEPT_CODE,
       ROUND(AVG(SALARY))
  FROM
       EMPLOYEE
 GROUP BY
       DEPT_CODE
 ORDER BY
       ROUND(AVG(SALARY)) DESC;

SELECT
       ROWNUM,
       E.*
  FROM (SELECT
               DEPT_CODE,
               ROUND(AVG(SALARY))
          FROM
               EMPLOYEE
         GROUP BY
               DEPT_CODE
         ORDER BY
               ROUND(AVG(SALARY))DESC) E
WHERE ROWNUM <= 3;


-- 가장 최근에 입사한 사원 5명 조회   사원명, 급여, 입사일
SELECT
       EMP_NAME,
       SALARY,
       HIRE_DATE
  FROM 
       EMPLOYEE
 ORDER BY
       HIRE_DATE DESC;
    
SELECT
       ROWNUM,
       E.*
  FROM (SELECT
               EMP_NAME,
               SALARY,
               HIRE_DATE
          FROM 
               EMPLOYEE
         ORDER BY
               HIRE_DATE DESC) E
WHERE ROWNUM <= 5;

--------------------------------------------------------------------------------
/*
    6. 순위 매기는 함수
    RANK() OVER(정렬기준)
    DENSE_RANK() OVER(정렬기준)
    
    단, 위의 함수들은 오로지 SELECT절에서만 작성 가능(WHERE절 같은 곳에 쓸 수가 없음)
    
    
*/
SELECT                                      -- 공동순위 후에 그만큼 숫자가 지남
       EMP_NAME,
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC)
  FROM
       EMPLOYEE;
       
SELECT                                      -- 공동순위 후에도 다음 순자로 순위가 이어짐
       EMP_NAME,
       SALARY,
       DENSE_RANK() OVER(ORDER BY SALARY DESC)
  FROM
       EMPLOYEE;

SELECT
       *
  FROM
       (SELECT                                      
               EMP_NAME,
               SALARY,
               RANK() OVER(ORDER BY SALARY DESC) "순위"
          FROM
               EMPLOYEE) 
 WHERE 순위 <= 5;









