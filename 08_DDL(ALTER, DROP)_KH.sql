/*
    < DDL : DATA DEFINITION LANGUAGE >
    데이터 정의 언어
    
    객체들을 새롭게 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문

    1. ALTER 
    객체 구조를 수정하는 구문
    
    < 테이블 수정 >
    ALTER TABLE 테이블명 수정할 내용;
    - 수정할 내용
    1) 컬럼 추가 / 수정 / 삭제
    2) 제약조건 추가 / 삭제 => 수정은 불가(수정하고 싶으면 삭제 한 다음에 다시 추가)
    3) 테이블명 / 컬럼명 / 제약조건명
*/

-- 1) 컬럼 추가 / 수정 / 삭제
-- 1_1) 컬럼추가 (ADD) : ADD 추가할 컬럼명 데이터타입  DEFAULT 기본값(DEFAULT 기본값은 생략 가능)
SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- 새로운 컬럼이 만들어지고 NULL값이 들어감

-- LNAME컬럼 추가 DEFAULT값 지정
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
-- 새로운 컬럼이 만들어지고 LNAME 컬럼에 DEFAULT 값이 들어감

-- 1_2) 컬럼 수정(MODIFY)
--   데이터 타입 수정  : MODIFY 수정할컬럼명 바꾸고자하는데이터타입 
--   DEFAULT 값 수정  : MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는기본값

-- DEPT_ID 컬럼의 데이터 타입을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(10);
-- 현재 변경하고자 하는 컬럼에 이미 담겨있는 값과 완전히 다른 타입으로는 변경이 불가능하다!!
-- 예) 문자 -> 숫자(X) // 문자열 사이즈 축소(X) // 문자열 사이즈 확대(OOOOOO)


-- DEPT_TITLE컬럼의 데이터타입을 VARCHAR2(40)로
-- LOCATION_ID 컬럼의 ㅣ데이터타입을 VARCHAR2(5)로
-- LANME컬럼의 기본값을 '미국'
ALTER TABLE DEPT_COPY
      MODIFY DEPT_TITLE VARCHAR2(40)
      MODIFY LOCATION_ID VARCHAR2(5)
      MODIFY LNAME DEFAULT '미국';
      
SELECT * FROM DEPT_COPY;

CREATE TABLE DEPT_COPY2
    AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- 1_3) 컬럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자 하는 컬럼명

-- DEPT_COPY2로부터 DEPT_ID컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

ROLLBACK;
-- DDL구문은 복구 불가능
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME; -- 마지막 컬럼 삭제는 오류가 발생!! : 테이블에 최소 한개의 컬럼은 존재해야함!!
--------------------------------------------------------------------------------

-- 2) 제약조건 추가 / 삭제

/*
    2_1) 제약조건 추가
    
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명 (참조할컬럼명)
    - UNIQUE      : ADD UNIQUE(컬럼명)
    - CHECK       : ADD CHECK(컬럼에 대한 조건);
    - NOT NULL    : MODIFY 컬럼명 NOT NULL;
*/

-- DEPT_COPY 테이블에
-- DEPT_ID컬럼에 PRIMARY KEY 제약조건추가
-- DEPT_TITLE컬럼에 UNIQUE제약조건 추가
-- LNAME컬럼에 NOT NULL 제약조건 추가

ALTER TABLE DEPT_COPY ADD PRIMARY KEY(DEPT_ID) ADD UNIQUE(DEPT_TITLE) MODIFY LNAME NOT NULL;
SELECT * FROM DEPT_COPY;

/*
    2_2) 제약조건 삭제
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
    NOT NULL : MODIFY 컬럼명 NULL
*/

-- PK제약조건 지우기
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007236;

-- NOT NULL 제약 조건 지우기
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;

--------------------------------------------------------------------------------

-- 3) 컬럼명 / 제약조건명 / 테이블 변경 (RENAME)

-- 3_1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007231 TO CHECK_CONSTRAINT;

-- 3_3) 테이븖명 변경 : RENAME 기존테이블명 TO 바꿀테이블명
--                          기존테이블명을 생략 가능!! ALTER TABLE 기존테이블에서 기술하기 때문에!!
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;


/*
    2. DROP
    객체를 삭제하는 구문

*/

DROP TABLE DEPT_TEST;
-- 단, 어딘가에서 참조되고 있는 부모테이블들은 삭제되지 않는다.

-- 만약에 삭제하고 싶다면
-- 1. 자식테이블을 날리고 부모테이블을 삭제
DROP TABLE 자식테이블;
DROP TABLE 부모테이블;

-- 2. 부모테이블만 지우는데 맞물려있는 제약조건도 지우고싶다
DROP TABLE 부모테이블명 CASCADE CONSTRAINT;























































