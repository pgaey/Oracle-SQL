/*
    * DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    오라클에서 제공하는 객체(OBJECT)를
    새롭게 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제하는 (DROP)하는 명령어
    즉, 구조 자체를 정의하는 언어로 주로 DB 관리자, 설계자가 사용함
    
    오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE)
                        , 인덱스(INDEX), 패키지(PAKAGE), 트리거(TRIGGER)
                        , 프로지셔(PROCEDURE), 함수(FUCTION)
                        , 동의어(SYNONYM), 사용자(USER)
        
*/

/*
    < CREATE TABLE >
    
    테이블이란 ? : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
    모든 데이터가 테이블을 통해서 저장됨 (데이터를 보관하고자 한다면 테이블을 만들어야 함)
    
    [ 표현법 ]
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형,
        ...
    );
    
    < 자료형 >
    
    - 문자(CHAR(크기) / VARCHAR2(크기)) : 크기는 BYTE단위로 
                                    (숫자, 영문자, 특수문자 => 1글자당 1BYTE // 한글 => 1글자당 3BYTE)
      CHAR(바이트수) : 최대 2000BYTE까지 지정가능
                     고정길이(아무리 작은값이 들어와도 공백으로 남은자리를 채워서 처음 할당한 크기 유지)
                     주로 들어올 값의 글자수가 정해져있을 경우
                     예 ) 성멸 : 남/여, M/F
      VARCHAR2(바이트수) : 최대 4000BYTE까지 지정가능
                         가변길이(작은 값이 들어오면 담긴 값에 맞춰서 크기가 줄어듬)
                         VAR는 '가변'을 의미, 2는 '2배'를 의미
    
    - 숫자(NUMBER) : 정수 / 실수 상관없이 NUMBER
    
    
    - 날짜(DATE)
    

*/

-->> 회원들의 데이터(아이디, 비밀번호, 이름, 회원가입일)를 담기 위한 MEMBER 테이블 생성하기

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);
                 
SELECT * FROM MEMBER; -- 구조만 만들었기 때문에 값이 없음

/*
    컬럼에 주석달기(컬럼에 대한 설명)
    
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용'

*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';

SELECT * FROM USER_TABLES;

SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- 데이터를 추가할 수 있는 구문(INSERT : 한 행으로 추가, 값의 순서 중요)
-- INSERT INTO 테이블명 VALUES(첫 번째 컬럼의 값, 두 번째 컬럼의 값, 세 번째 컬럼의 값, ....);
INSERT INTO 
MEMBER VALUES('user01', 'pass01', '홍길동', '2023-02-28');
INSERT INTO 
MEMBER VALUES('user02', 'pass02', '홍닐동', '23/02/28');
INSERT INTO 
MEMBER VALUES('user03', 'pass03', '홍딜동', SYSDATE);
INSERT INTO 
MEMBER VALUES(NULL, NULL, NULL, SYSDATE); -- 아이디, 비밀번호, 이름에 NULL값이 존재해서는 안됌
INSERT INTO 
MEMBER VALUES('user03', 'pass03', '이승철', SYSDATE); -- 중복된 아이디가 들어가버림

-- 위의 NULL값/ 중복된 아이디값은 유효하지 않은 값들!
-- 유효한 데이터값을 유지하기 위해서 제약조건을 걸워줘야함!!

--------------------------------------------------------------------------------
/*
    < 제약조건 CONSTRAINTS >
    
    - 원하는 데이터 값만 유지하기 위해서(보관하기 위해서) 특정 컬럼마다 설정하는 제약(데이터의 무결성 보장을 목적으로)
    - 제약조건이 부여된 컬럼에 들어올 데이터가 문제가 있는지 없는지 자동으로 검사
    
    - 종류 : NOT NULL, UNIQUE, CKECK, PRIMARY KEY, FOREIGN KEY
    
    - 컬럼에 제약조건을 부여하는 방식 : 컬럼레벨 / 테이블레벨
*/

/*
    1. NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야할 경우 사용(NULL 값이 절대 들어와서는 안되는 칼럼에 부여)
    INSERT / UPGDATE 시 NULL값을 허용하지 않도록 제한 
    
    단, NOT NULL제약조건은 컬럼레벨 방식으로만 부여가 가능 (테이블 X)
*/

-- NOT NULL제약조건을 설정한 테이블 만들기
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건  => 제약조건을 부여하고자 하는 컬럼 뒤에 곧바로 기술 
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    MEM_DATE DATE
    
);

SELECT * FROM MEM_NOTNULL;
       
INSERT INTO MEM_NOTNULL
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', SYSDATE);

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL 제약조건 위배!! 오류 발생!!

INSERT INTO MEM_NOTNULL
VALUES(2, 'user01', 'pass2', NULL, NULL, NULL, NULL); -- NOT NULL 제약조건이 부여되어있는 모든 컬럼에 반드시 값이 존재해야한다!!

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass02', NULL, NULL, NULL, NULL); -- 중복값

--------------------------------------------------------------------------------

/*
    2. UNIQUE 제약조건
    컬럼에 중복값을 제한하는 제약조건
    INSERT / UPDATE 시 기존에 해당 컬럼값 중에 중복값이 있을 경우 추가 또는 수정이 되지 않게 제약
    
    컬럼레벨 / 테이블레벨 방식 둘 다 가능
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    -- 컬럼레벨 방식. 순서는 상관없음
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    MEM_DATE DATE
);
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(30),
    PHONE VARCHAR2(15),
    MEM_DATE DATE,
    UNIQUE(MEM_ID) -- 테이블레벨 방식으로 조건을 거는 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', SYSDATE);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '김길동', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user02', 'pass03', '머시기', NULL, NULL, NULL);
-- UNIQUE 제약조건에 위배되었으므로 INSERT에 실패

/*
    - 제약조건 부여 시 제약조건명 설정하는 방법
    
    > 컬럼레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
        컬럼명 자료형,
        ...
    );
    
    > 테이블레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        ...
        CONSTRAINT 제약조건명 제약조건(컬럼명)
    )
*/

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    MEM_DATE DATE,
    CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID)
);

INSERT INTO MEM_CON_NM VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL);
INSERT INTO MEM_CON_NM VALUES(2, 'user01', 'pass02', '홍길동', NULL, NULL, NULL);
-- ORA-00001: unique constraint (DDL.MEM_ID_UQ) violated 내가 만든 제약조건명이 나옴
SELECT * FROM MEM_CON_NM;

INSERT INTO MEM_CON_NM VALUES(3, 'user03', 'pass03', '홍길동', '가', NULL, NULL);
-- GENDER컬럼에는 '남' 또는 '여' 값만 들어가게 하고 싶음
--------------------------------------------------------------------------------

/*
    3. CHECK 제약조건
    컬럼에 기록할 수 있는 값에 대한 조건을 설정해둘 수 있음
    
    CHECK (조건식)
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE NOT NULL
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-1234', SYSDATE);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '이승철', '가', '010-1234-5678', SYSDATE);

INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '어쩌고', NULL, NULL, NULL);
-- CHECK 제약조건에 NULL값도 INSERT가 가능(NULL값도 못들어오게 하고 싶다면 NOT NULL제약조건도 부여하면됨!!)

SELECT * FROM MEM_CHECK;
-- 회원가입일을 항상 SYSDATE값으로 넣고 싶은데... 테이블에서 지정 가능!! -> 제약조건은 아님!!




































