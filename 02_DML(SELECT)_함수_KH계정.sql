/*
    < 함수 FUNCTION >
    자바로 따지면 메소드와 같은 존재
    전달된 값들을 읽어가지고 계산한 결과를 반환
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 반환( 매 행마다 함수 실행 후 결과 반환 )
    - 그룹 함수★ : N개의 값을 읽어서 1개의 결과를 반환( 하나의 그룹별로 함수 실행 후 결과 반환 )
    
    단일행 함수와 그룹함수는 함께 사용할 수 없음 : 결과 행의 개수가 다르기 때문
*/

----------------------- < 단일행 함수 >------------------------

/*
    < 문자열과 관련된 함수 >
    LENGTH() / LENGTHB()    -- B 가 붙음
    
    - LENGTH(STR)  : 해당 전달된 문자열의 글자 수 반환
    - LENGTHB(STR) : 해당 전달된 문자열의 바이트 수 반환
    
    결과값은 NUMBER타입으로 반환
    STR : '문자열' / 문자열에 해당하는 컬럼
    
    숫자, 영문, 특수문자 : '!', '~', 'A', '1' => 한 글자당 1BYTE로 취급
    한글 : 'ㄱ', 'ㅏ', '강', ... => 한 글자당 3BYTE로 취급
*/

SELECT
       LENGTH('ORACLE')
      ,LENGTHB('ORACLE')
      ,LENGTH('오라클')
      ,LENGTHB('오라클') AS "LENGTHB"
  FROM DUAL; -- 가상의 테이블 (BUMMY TABLE)

SELECT 
       EMAIL
      ,LENGTH(EMAIL)
      ,LENGTHB(EMAIL)
      ,EMP_NAME
      ,LENGTH(EMP_NAME)
      ,LENGTHB(EMP_NAME)
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------
/*
    INSTR
    
    - INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환
    
    INSTR(STR, '특정 문자', 찾을 위치의 시작 값, 순번)
    
    결과값은 NUMBER타입으로 반환
    찾을 위치의 시작값, 순번은 생략 가능
    
    찾을 위치의 시작값
    1  : 앞에서부터 찾겠다. (생략 시 기본값)
    -1 : 뒤에서부터 찾겠다.
*/

SELECT
       INSTR('AABAACAABBAA', 'B')
  FROM
       DUAL; -- 찾을 위치, 순번 생략 시 기본적으로 앞에서부터 첫 번째 글자의 위치 검색

SELECT
       INSTR('AABAACAABBAA', 'B', 1)
  FROM
       DUAL; -- 해당 문자열의 앞에서부터 첫 번째에 B가 몇번째에 나오는지 출력 : 3번째 위치

SELECT
       INSTR('AABAACAABBAA', 'B', -1)
  FROM
       DUAL; -- 해당 문자열의 뒤에서부터 첫 번째에 B가 몇번째에 나오는지 출력 : 10번째 위치

SELECT
       INSTR('AABAACAABBAA', 'B', 1, 2)
  FROM
       DUAL; -- 해당 문자열의 앞에서부터 두 번째에 위치한 B가 몇번째에 나오는지 출력 : 9번째 위치
  
SELECT
       INSTR('AABAACAABBAA', 'B', -1, 2)
  FROM
       DUAL; -- 해당 문자열의 뒤에서부터 두 번째에 위치한 B가 몇번재에 나오는지 출력 : 9번째 위치

-- EMAIL에서 @의 위치를 찾아주세요!
SELECT
       EMAIL, INSTR(EMAIL, '@') AS "@의 위치"
  FROM
       EMPLOYEE;

-------------------------------------------------------------------------------
/*
    SUBSTR
    
    - SUB(STR, POSITION, LENGTH) : 문자열로부터 특정 문자열을 추출해서 반환
                                    (자바로 따지면 문자열.substring() 메소드와 유사)
                                    
    결과값은 CHARACTER타입으로 반환
    LENGTH는 생략 가능
    
    - STR : '문자열' 또는 문자 타입 컬럼
    - POSITION : 문자열을 추출할 시작 위치값(음수도 제시가능) POSITION번째 문자부터 추출
    - LENGTH : 추출할 문자 개수(생략 시 끝까지 의미)
    
*/

SELECT 
       SUBSTR('아무문자열이나상관없습니다', 8)  -- RESULT SET : 상관없습니다
  FROM
       DUAL;

SELECT
       SUBSTR('아무문자열이나상관없습니다', 10, 4)
  FROM
       DUAL;

SELECT 
       SUBSTR('아무문자열이나상관없습니다', -6, 2)
  FROM
       DUAL;   -- 시작위치가 음수일 경우 뒤에서부터 N번째 위치로부터 문자를 추출하겠다 라는 뜻

SELECT
       *
  FROM
       EMPLOYEE;

-- 주민번호에서 성별 부분을 추출해서 남자(1)/여자(2)를 체크
SELECT
       EMP_NAME 
      ,SUBSTR(EMP_NO, 8, 1) AS "성별"
  FROM
       EMPLOYEE;
       
-- 여성 사원들의 사원명과 급여만 조회
SELECT
       EMP_NAME, SALARY
  FROM
       EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
 WHERE
       SUBSTR(EMP_NO,8, 1) IN ('2', '4');
    
-- 이메일에서 ID부분만 추출, 이름, 이메일
SELECT
       EMP_NAME
      ,EMAIL
      ,SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) "ID"
  FROM
       EMPLOYEE;
       
-------------------------------------------------------------------------------
/*
    LPAD / RPAD
    
    - LPAD/RPAD(STR, 최종적으로 반환할 문자의 길이(바이트), 덧붙이고자하는 문자)
    : 제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N만큼의 문자열을 반환
    
    결과값은 CHARACTER 타입으로 반환
    덧붙이고자하는 문자는 생략이 가능
    
    - STR : '문자열' 또는 문자 타입 컬럼
*/

SELECT
       LPAD(EMAIL, 20)
  FROM
       EMPLOYEE;

SELECT
       RPAD(EMAIL, 20, '#')
  FROM
       EMPLOYEE;
       
-- 660101-3****** => 총 글자수 14 글자
SELECT
       RPAD('660101-3', 14, '*')
  FROM
       DUAL;

-- 모든 직원의 주민등록번호 뒤 6자리를 마스킹처리 ↑처럼 해서 표현해보자
-- 1단계. SUBSTR을 이용해서 주민등록번호 앞 8자리만 추출
SELECT
       EMP_NAME
      ,RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "주민번호"
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------
/*
    LTRIM / RTRIM

    - LTRIM / RTRIM(STR, 제거시키고자 하는 문자)
    : 문자열의 왼쪽 또는 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
    
    결과값은 CHARACTER타입으로 반환
    제거하고자하는 문자를 생략 가능
    
    - STR : '문자열' 또는 문자 타입 컬럼
*/

SELECT
       LTRIM('         문    자')
  FROM
       DUAL;

SELECT
       LTRIM('00012300456000', '0')
  FROM
       DUAL;
        
SELECT
       LTRIM('123123KH123', '123')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    TRIM
    
    - TRIM(BOTH/LEADING/TRAILING '제거시키고 싶은 문자' FROM STR)
    : 문자열을 앞/뒤/양쪽에 있는 특정 문자를 제거한 나머지 문자열을 반환
    
    결과값은 CHARACTER타입으로 반환
    BOTH, LEADING, TRAILING은 생략가능/ 생략시 기본값인 BOTH로 적용
    
    - STR : '문자열' 또는 문자 타입 컬럼
*/

-- 기본적으로 양쪽에 있는 문자 제거
SELECT
       TRIM('    문  자    ')
  FROM
       DUAL;
       
SELECT
       TRIM('ㅋ' FROM 'ㅋㅋㅋㅋ문잨ㅋㅋㅋ')
  FROM
       DUAL;    -- BOTH : 양쪽(생략 시 기본값)
       
SELECT
       TRIM(LEADING 'ㅋ' FROM 'ㅋㅋㅋ문잨ㅋㅋㅋ')
  FROM
       DUAL;
       
SELECT
       TRIM(TRAILING 'ㅋ' FROM 'ㅋㅋㅋ문ㅋㅋ잨ㅋㅋㅋ')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    LOWER/UPPER/INITCAP
    
    - LOWER(STR)
    : 다 소문자로 변경
    
    - UPPER(STR)
    : 다 대문자로 변경
    
    - INITCAP(STR)
    : 각 단어 앞글자만 대문자로 변경
    
    결과값은 CHARACTER 타입으로 반환
    
    - STR : '문자열' 또는 문자 타입 컬럼
*/

SELECT
       LOWER('HELLO WORLD!')
  FROM
       DUAL;
       
SELECT
       UPPER('hello world!')
  FROM
       DUAL;
       
SELECT
       INITCAP('hello world!')
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    CONCAT
    
    - CONCAT(STR1, STR2)
    : 전달된 두 개의 문자열을 하나로 합친 결과를 반환
    
    결과값은 CHARACTER타입으로 반환
    
    - STR : '문자열' 또는 문자 타입 컬럼
*/

SELECT
       CONCAT('ㅋㅋ', 'ㄲㅋㅋ')
  FROM
       DUAL;

SELECT 
       'ㅋㅋ' || 'rㅋㅋ'
  FROM
       DUAL;

--------------------------------------------------------------------------------
/*
    REPLACE
    
    - REPLACE(STR, 찾을 문자, 바꿀 문자)
    : STR로부터 찾을 문자를 찾아서 바꿀문자로 바꾼 문자열을 반환
    
    결과값은 CHARACTER 타입으로 반환
    
    - STR : '문자열' 또는 문자 타입 컬럼
*/

SELECT
       REPLACE('서울시 중구 남대문로', '남대문로', '***로')
  FROM
       DUAL;
       
SELECT
       REPLACE(EMAIL, 'kh.or.kr', 'ioi.or.kr')
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------
/*
    < 숫자와 관련된 함수 >
    
    ABS
    - ABS(NUMBER) : 절대값 구해주는 함수
*/

SELECT 
       ABS(-10)
  FROM
       DUAL;

SELECT 
       ABS(-10.8)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    MOD
    
    - MOD(NUMBER1, NUMBER2) : 두 수를 나눈 나머지 값을 반환해주는 함수
    
*/

SELECT
       MOD(10, 3)
  FROM
       DUAL;
       
SELECT
       MOD(10.9, 3)
  FROM 
       DUAL;
--------------------------------------------------------------------------------

/*
    ROUND(NUMBER, 위치) : 반올림 처리해주는 함수
    
    위치 : 소수점 아래 N번째 수에서 반올림
    생략 가능, 생략 시 기본값이 0 = 소수점을 없앰
*/

SELECT
       ROUND(123.456)
  FROM
       DUAL; -- 123
       
SELECT
       ROUND(123.456, 1)
  FROM
       DUAL; -- 123.5

SELECT
       ROUND(123.456, 2)
  FROM
       DUAL; -- 123.46
       
SELECT
       ROUND(123.456, 3)
  FROM
       DUAL; -- 123.456
       

SELECT  
       ROUND(123.456, -1)
  FROM
       DUAL;
       
SELECT
       ROUND(123.456, -2)
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    CEIL
    - CEIL(NUMBER) : 소수점 아래의 수를 무조건 올림 처리해주는 함수
*/

SELECT
       CEIL(123.456)
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    FLOOR
    
    - FLOOR(NUMBER) : 소수점 아래의 수를 무조건 버림 처리해주는 함수
*/

SELECT
       FLOOR(123.999)
  FROM
       DUAL;

-- 각 직원별로 고용일로부터 오늘까지 근무일수 조회

SELECT
       EMP_NAME
      ,CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일')  AS "근무일수"
  FROM
       EMPLOYEE;

-------------------------------------------------------------------------------

/*
    TRUNC
    
    - TRUNC(NUMBER, 위치) : 위치를 지정가능한 버림처림해주는 함수
    
    - 위치는 생략 가능, 단 생략 시 기본값은 0
*/
       
SELECT
       TRUNC(123.456)
  FROM
       DUAL;
       
SELECT
       TRUNC(123.456, 2)
  FROM  
       DUAL;

--------------------------------------------------------------------------------

/*
    < 날짜 관련 함수 >
    
    DATE 타입 : 년, 월, 일, 시, 분, 초를 다 포함한 자료형
*/

-- SYSDATE : 현재 시스템 날짜 반환
SELECT
       SYSDATE
  FROM
       DUAL;

-- MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월 수 반환(NUMBER타입 반환, DATE2가 더 먼 미래일 경우 음수가 나올 수 있다.)
-- 각 직원별로 고용일로부터 오늘까지 근무일수와 근무개월수 조회
SELECT
       EMP_NAME
      ,FLOOR(SYSDATE - HIRE_DATE) || '일' "근무일수"
      ,FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "근무개월수"
  FROM
       EMPLOYEE;

-- ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월수를 더한 날짜 반환(DATE타입 반환)
SELECT
       ADD_MONTHS(SYSDATE, 4)   -- 오늘 날짜로부터 4개월 뒤
  FROM
       DUAL;

-- 전체 사원들의 직원명, 입사일, 입사 후 3개월이 흘렀을 대의 날짜 조회
SELECT
       EMP_NAME "이름"
      ,HIRE_DATE AS "입사일"
      ,ADD_MONTHS(HIRE_DATE, 3) AS "입사 후 3개월"
  FROM
       EMPLOYEE;

-- NEXT_DAY(DATE, 요일(문자/숫자)) : 특정 날짜에서 가장 가까운 해당 요일 찾아 그 날짜 반환
SELECT
       NEXT_DAY(SYSDATE, '일요일')
  FROM 
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, '일')
  FROM
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, 1) -- 1: 일요일 2: 월요일 3:화요일 .... 7: 토요일
  FROM
       DUAL;
       
-- 현재 언어가 KOREAN이기 때문에 에러가 난다.
SELECT
       NEXT_DAY(SYSDATE, 'SUNDAY')
  FROM
      DUAL;

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY(DATE) : 해당 특정 날짜 달의 마지막 날짜를 구해서 반환(DATE 타입 반환)
SELECT
       LAST_DAY(SYSDATE)
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    EXTRACT : 년도 또는 월 또는 일 정보를 추출해서 반환(NUMBER타입 반환)
    
    - EXTRACT(YEAR FROM DATE) : 특정 날짜로부터 년도만 추출
    - EXTRACT(MONTH FROM DATE): 특정 날짜로부터 월만 추출
    - EXTRACT(DAY FROM DATE) :  특정 날짜로부터 일만 추출
*/

-- 사원명, 입사년도, 입사월, 입사일 조회
SELECT
       EMP_NAME
      ,EXTRACT(YEAR FROM HIRE_DATE) "입사년도"
      ,EXTRACT(MONTH FROM HIRE_DATE) "입사월"
      ,EXTRACT(DAY FROM HIRE_DATE) "입사일"
  FROM
       EMPLOYEE
 ORDER
    BY
       "입사년도", "입사월";

--------------------------------------------------------------------------------

/*
    < 형변환 함수 >
    
    NUMBER/DATE => CHARACTER
    
    - TO_CHAR(NUMBER/DATE, 포맷) : 숫자형 또는 날짜형 데이터를 문자형 타입으로 변환(CHARACTER 타입 변환)
*/

SELECT 
       TO_CHAR(1234)
  FROM
       DUAL;
       
SELECT
       TO_CHAR(1234, '0000000')
  FROM
       DUAL;  -- 1234가 => '0001234' : 빈칸을 0으로 채움
       
SELECT
       TO_CHAR(1234, '999999')
  FROM
       DUAL; -- '1234' : 반칸을 공백으로 채움
       
SELECT
       TO_CHAR(1234, 'L00000')
  FROM
       DUAL;  -- '￦01234' : 현재 설정된 나라(LOCAL)의 화폐단위
       
SELECT
       TO_CHAR(1234, 'L999999999')
  FROM
       DUAL; -- '￦1234' : 현재 설정된 나라 (LOCAL)의 화폐단위
       
SELECT
       TO_CHAR(123456789,'9,999,999,999')
  FROM  
       DUAL;
       
-- 급여정보를 3자리마다 ,로 구분하여 출력
SELECT  
       EMP_NAME
      ,TO_CHAR(SALARY, 'L999,999,999') AS "급여정보"
  FROM
       EMPLOYEE;

-- DATE(년월일시분초) => CHARACTER
SELECT
       TO_CHAR(SYSDATE)
  FROM
       DUAL;

SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
  FROM
       DUAL;
       
SELECT
       TO_CHAR(SYSDATE, 'PM HH:MI:SS')
  FROM
       DUAL;
       
SELECT  
       TO_CHAR(SYSDATE, 'HH24:MI:SS')
  FROM
       DUAL;
       
SELECT
       TO_CHAR(SYSDATE, 'MON DY, YYYY')
  FROM
       DUAL;

-- 년도로써 쓸 수 있는 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY')
      ,TO_CHAR(SYSDATE, 'RRRR')
      ,TO_CHAR(SYSDATE, 'YY')
      ,TO_CHAR(SYSDATE, 'RR')
      ,TO_CHAR(SYSDATE, 'YEAR')
  FROM
       DUAL;  

-- 월로써 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'MM')
      ,TO_CHAR(SYSDATE, 'MON')
      ,TO_CHAR(SYSDATE, 'MONTH')
      ,TO_CHAR(SYSDATE, 'RM')
  FROM
       DUAL;
       
-- 일로써 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'D') -- 1주일 기준(일요일부터 시작해서 몇번째냐)
      ,TO_CHAR(SYSDATE, 'DD') -- 1달 기준(1일부터 시자해서 며칠째냐)
      ,TO_CHAR(SYSDATE, 'DDD') -- 1년 기준으로 며칠이나 지났나
  FROM
       DUAL;

-- 요일로써 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'DY')
      ,TO_CHAR(SYSDATE, 'DAY')
  FROM
       DUAL;

-- 2023년 02월 24일 (금) 포맷으로 출력
SELECT
       TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" (DY)') "오늘날짜"
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    CHARACTER => NUMBER
    
    - TO_NUMBER(CHARACTER, 포맷) : 문자형데이터를 숫자형으로 변환(NUMBER타입 반환)
*/

SELECT
       '123' + '123'
  FROM
       DUAL; -- 자동형변환 후 산술연산까지 진행

SELECT
       '10,000,000' + '550,000'
  FROM
       DUAL;
       
SELECT
       TO_NUMBER('10,000,000', '99,999,999') +  TO_NUMBER('550,000', '99,999,999')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    < NULL 처리 함수 >
    
*/

-- NVL(컬럼명, 해당 컬럼값이 NULL일 경우 반환할 결과값)
-- 해당 컬럼에 값이 존재할 경우 기존의 컬럼값 반환, 해당 컬럼에 NULL값이 들어있을 경우 내가 제시한 특정값을 반환

-- 사원명, 보너스, 보너스가 없는 경우 0으로 조회
SELECT
       EMP_NAME
      ,BONUS
      ,NVL(BONUS, 0) -- 내가 적은 값으로 대체
  FROM
       EMPLOYEE;

-- 보너스 포함 연봉 조회
SELECT
       EMP_NAME
      ,TO_CHAR((SALARY + SALARY * NVL(BONUS, 0)) * 12, '999,999,999,999' )AS "연봉"
  FROM
       EMPLOYEE;
       
-- 사원명, 부서코드(부서코드가 없는 경우 '없음')
SELECT
       EMP_NAME
      ,NVL(DEPT_CODE, '없음')
  FROM
       EMPLOYEE;
       
-- NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼에 값이 존재할경우 결과값1 반환
-- 해당 컬럼에 값이 NULL일 경우 결과값2 반환

SELECT
       EMP_NAME
      ,BONUS
      ,NVL2(BONUS, 0.5, 0)
  FROM
       EMPLOYEE;

SELECT
       EMP_NAME
      ,NVL2(DEPT_CODE, '부서배치완료', '부서미정')
  FROM
       EMPLOYEE;
       
-- NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 동일한 경우 NULL반환
-- 두 개의 값이 동일하지 않은 경우 비교대상1 반환 

SELECT
       NULLIF('123', '123')
  FROM
       DUAL;
       
SELECT
       NULLIF('123', '456')
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    < 선택 함수 >
    
    DECODE(비교대상(컬럼명/산술연산/함수) 조건값1, 결과값1, 조건값2, 결과값2, ....,  결과값)
    
    - 자바에서의 switch문과 유사
*/

-- 사번, 사원명, 주민등록번호로부터 성별 자리 추출
SELECT 
       EMP_NO
      ,EMP_NAME
      ,DECODE(
               SUBSTR(EMP_NO, 8, 1),
               1, '남', 
               2, '여'
               ) "성별"
  FROM
       EMPLOYEE;

-- 직원들의 급여를 인상시켜서 조회
-- 직급코드가 'J7'인 사원은 급여를 10% 인상해서 조회
-- 직급코드가 'J6'인 사원은 급여를 15% 인상해서 조회
-- 직급코드가 'J5'인 사원은 급여를 20% 인상해서 조회
-- 사원명, 직급코드, 인상전 급여, 인상후 급여
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
      ,DECODE(JOB_CODE,
      'J7', (SALARY + (SALARY)*0.1),
      'J6', (SALARY + (SALARY)*0.15),
      'J5', (SALARY + (SALARY)*0.2),
      (SALARY + (SALARY)*0.05)) AS "인상 후 급여"
/*default 값은 그냥 비워주면 된다
 'J7', ...
 'J6', ... 
 'J5', ...
  여백, ... 
*/
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
    CASE WHEN THEN 구문
    
    - DECODE와 비교하면 DECODE는 조건검사 시 동등비교만을 수행
      CASE WHEN THEN 구문으로 특정 조건 제시시 "내마음대로" 조건식 기술가능
      
    - 자바에서의 IF - ELSE IF문 같은 느낌
    
    [ 표현법 ]
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ...
         ELSE 결과값
    END
*/

-- 사번, 사원명, 주민번호로부터 성별자리 추출 : DECODE 함수
SELECT
       EMP_ID
      ,EMP_NAME
      ,DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') AS "성별"
  FROM
       EMPLOYEE;
       
SELECT
       EMP_ID
      ,EMP_NAME
      ,CASE
            WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남'
            ELSE '여'
       END "성별"
  FROM
       EMPLOYEE;
       
-- 사원명, 급여, 급여등급("많이", "중간", "적게")
-- SALARY값이 500만원 초과일 경우 "많이"
-- 500만원 이하 350만원 초과일 경우 "중간"
-- 350만원 이하일 경우 "적게
SELECT
       EMP_NAME
      ,SALARY
      ,CASE
            WHEN SALARY > 5000000 THEN '많이'
            WHEN 3500000 < SALARY AND SALARY <= 5000000 THEN '중간'
            ELSE '적게'
       END "급여등급"
  FROM
       EMPLOYEE;

---------------------------------< 그룹 함수 >-----------------------------------
/*
    N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행 결과 반환)
*/























