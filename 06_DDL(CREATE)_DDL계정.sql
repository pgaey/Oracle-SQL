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

--------------------------------------------------------------------------------
/*
    * 특정 컬럼에 들어올 값에 대한 기본값을 설정 => 제약조건은 아님
*/

DROP TABLE MEM_CHECK;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL  
);

/*
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, 컬럼명 4)
    VALUES(값1, 값2, 값3, 값4)
    지정하지 않은 곳에는 NULL 값이 들어감
*/

INSERT INTO MEM_CHECK (MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES (1, 'user01', 'pass01', '홍길동');

SELECT * FROM MEM_CHECK;
-- 지정을 하지 않은 컬럼에는 기본적으로 NULL값이 들어가지만
-- 만일 DEFAULT값이 부여되어 있다면 NULL값이 아닌 DEFAULT값으로 INSERT된다!!

--------------------------------------------------------------------------------

/*
    4. PRIMARY KEY(기본키)(흔히 PK라고 함) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 컬럼에 부여하는 제약조건
    => 각 행들을 구분할 수 있는 식별자의 역할
    예 ) 회원번호, 주문번호, 사번, 학번, 예약번호, .....
    => 중복되지 않고 값이 존재해야만 하는 컬럼에 RPIMARY KEY부여(NOT NULL + UNIQUE)
    
    단, 한 테이블당 한 번만 설정 가능
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, -- 컬럼레벨 방식 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE
    -- PRIMARY KEY(MEM_NO)  -- 테이블 레벨 방식
);


INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user01', 'pass01', '홍길동', '남', NULL, NULL);

INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user02', 'pass02', '머시기', '여', NULL, NULL);
-- ORA-00001: unique constraint (DDL.MEM_PK) violated
-- 기본키 컬럼에 중복값이 발생해서 오류가 발생!!

INSERT INTO MEM_PRIMARYKEY1
VALUES(NULL, 'user02', 'pass02', '머시기', '여', NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRIMARYKEY1"."MEM_NO")
-- 기본키 컬럼에 NULL값으로 인해 오류가 발생!!

INSERT INTO MEM_PRIMARYKEY1
VALUES(2, 'user02', 'pass02', '머시기', '여', NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY1;


CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE
);
-- PRIMARYKEY가 한 테이블에 두 개가 될 수 없다.
-- ORA-02260: table can have only one primary key
-- 두 개의 컬럼을 하나로 묶어서 PRIMARY KEY 하나로 설정 가능!

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(MEM_NO, MEM_ID)    -- 컬럼을 묶어서 PRIMARY KEY 하나로 설정 => 복합키
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '홍길동', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2,'user02', 'pass03', '홍길동', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user03', 'pass04', '홍길동', NULL, NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRIMARYKEY2"."MEM_NO")
-- 기본키로 설정되어있는 컬럼들에는 NULL값이 들어올 수 없음!!!

SELECT * FROM MEM_PRIMARYKEY2;
--------------------------------------------------------------------------------

-- 회원 등급에 대한 데이터(등급코드, 등급명) 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEM_GRADE VALUES ('G1', '일반회원');
INSERT INTO MEM_GRADE VALUES ('G2', '우수회원');
INSERT INTO MEM_GRADE VALUES ('G3', '특별회원');

DROP TABLE MEM_GRADE;

SELECT * FROM MEM_GRADE;

/*
    5. FOREIGN KEY(외래키) 제약조건
    해당 컬럼에 다른 테이블에 존재하는 값만 들어와야하는 경우에 부여하는 제약조건
    => 다른 테이블(부모테이블)을 참조한다고 표현
        참조된 다른 테이블이 제공하고 있는 값만 들어올 수 있음
    => FOREIGN KEY제약조건으로 다른 테이블간의 관계를 형성할 수 있음
    
    [ 표현법 ]
    - 컬럼레벨 방식
    컬럼명 자료형 CONSTRAINT 제약조건명 REFERENCES 참조할테이블명(참조할 컬럼명)
    
    - 테이블레벨 방식
    CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명)
    
    두 방식 모두 참조할 컬럼명은 생략 가능하다.
    참조할 컬럼명을 생략한 경우 참조할 테이블의 PRIMARY KEY 컬럼으로 참조할컬럼명이 잡힌다.
    CONSTRAINT제약조건명 또한 생략이 가능하다.

*/

-- 자식 테이블
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),      -- 컬럼레벨
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    PHONE VARCHAR2(15)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- 테이블레벨 방식
);

INSERT INTO MEM
VALUES (1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES (2, 'user02', 'pass02', '홍길동', 'G2', NULL, NULL);

INSERT INTO MEM
VALUES (3, 'user03', 'pass03', '머시기', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES (4, 'user04', 'pass04', '낫널', NULL, NULL, NULL);
-- 외래키 제약조건이 걸려있는 컬럼에도 기본적으로 NULL값이 들어갈 수 있음

INSERT INTO MEM
VALUES (5, 'user05', 'pass05', '없는거', 'G4', NULL, NULL);
-- parent key not found 발생!!
-- G4등급은 MEM_GRADE 테이블의 GRADE_CODE컬럼에서 제공하는 값이 아니기 때문에 오류 발생!!
-- ORA-02291: integrity constraint (DDL.SYS_C007194) violated - parent key not found

SELECT * FROM MEM;

-- 부모테이블(MEM_GRADE)에서 데이터가 삭제된다면??
-- MEM_GRADE테이블로부터 GRADE_CODE가 G1인 [데이터] 지우기
DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G1';
-- 자식테이블(MEM)에서 G1을 사용하고 있기 때문에 삭제할 수 없음
-- 외래키 제약조건을 부여할 때 삭제옵션을 부여하지 않았음
-- 삭제옵션을 따로 설정하지 않는다면 삭제제한옵션이 걸림!!
-- ORA-02292: integrity constraint (DDL.SYS_C007194) violated - child record found

DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G3';
-- 자식테이블에서 사용하고 있는 값이 아니기 때문에 삭제 가능

ROLLBACK;

DROP TABLE MEM;

--------------------------------------------------------------------------------

/*
    * 자식 테이블 생성 시(외래키 제약조건 부여 시)
      부모테이블의 데이터가 삭제되었을 때 자식테이블에서는 어떻게 처리할 지를 옵션으로 정해놓을 수 있음
      
    
    * FOREIGN KEY 삭제 옵션
    삭제옵션을 별도로 제시하지 않으면 ON DELETE RESTRICTED(삭제 제한) 으로 기본설정!
*/

-- 1) ON DELETE SET NULL : 부모 데이터 삭제 시 해당데이터를 사용하고 있는 자식데이터를 NULL로 변경시키는 옵션
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')),
    PHONE VARCHAR2(15),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL -- 테이블 레벨 방식     
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '홍길은', 'G2', NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '홍길금', 'G1', NULL, NULL);

-- 부모테이블 (MEM_GRADE)의 GRADE_CODE가 G1인 데이터 삭제
DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G1';

-- 문제없이 잘 삭제됨!
-- 자식테이블(MEM)의 GRADE_ID가 G1인 부분이 모두 NULL이 되어버림!!!

SELECT * FROM MEM;

DROP TABLE MEM;

-- 2) ON DELETE CASCADE : 부모데이터 삭제 시 해당 데이터를 사용하고 있는 자식데이터도 같이 삭제해버리는 옵션

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    FOREIGN KEY (GRADE_ID) REFERENCES MEM_GRADE/*(GRADE_CODE)*/ ON DELETE CASCADE
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '홍길은', 'G2', NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '홍길금', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '널값', NULL, NULL, NULL);

DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G1';
-- 자식테이블(MEM)의 GRADE_ID가 G1인 행들이 모두 함께 삭제 !!!

ROLLBACK;

-- 전체회원의 회원번호, 아이디, 비밀번호, 이름, 등급명 조회
--> 오라클 전용구문
SELECT
       MEM_NO,
       MEM_ID,
       MEM_PWD,
       MEM_NAME,
       GRADE_NAME
  FROM
       MEM M,
       MEM_GRADE MG
 WHERE
       GRADE_ID = GRADE_CODE(+);

--> ANSI 구문
SELECT
       MEM_NO,
       MEM_ID,
       MEM_PWD,
       MEM_NAME,
       GRADE_NAME
  FROM
       MEM M
  LEFT JOIN
       MEM_GRADE MG ON (M.GRADE_ID = MG.GRADE_CODE);
       
/*
    굳이 외래키 제약조건이 걸려있지 않더라도 JOIN 가능함
    다만, 두 컬럼에 동일한 의미에 데이터가 담겨있다면 매칭해서 JOIN할 수 있음!!!
*/

DROP TABLE MEM;

--------------------------------------------------------------------------------
/*
    ---- 여기서부터 실행은 KH계정에서!! ----
    
    * SUBQUERY를 이용한 테이블 생성(테이블 복사 뜨는 개념)
    
    메인 SQL문의 보조역할을 하는 쿼리문 => 서브쿼리
    
    [ 표현법 ]
    CREATE TABLE 테이블명
    AS 서브쿼리;
    
    해당 서브쿼리를 수행한 결과로 새로운 테이블을 생성할 수 있음!
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성(EMPLOYEE_COPY)

CREATE TABLE EMPLOYEE_COPY
    AS SELECT *
       FROM EMPLOYEE;
--> 컬럼들, 조회결과의 데이터값들
--> 제약조건같은 경우는! NOT NULL만 복사됨!

SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE테이블에 있는 컬럼의 구조만 복사하고 싶음! 데이터값은 필요없음!!!
CREATE TABLE EMPLOYEE_COPY2
    AS SELECT *
       FROM EMPLOYEE
       WHERE 1 = 0; -- 1 = 0은 FALSE를 의미!

SELECT * FROM EMPLOYEE_COPY2;


-- 전체 사원들 중 급여가 300만원 이상인 사원들의 사번, 이름, 부서코드, 급여 컬럼 복사
CREATE TABLE EMPLOYEE_COPY3
    AS
       SELECT
              EMP_ID,
              EMP_NAME,
              DEPT_CODE,
              SALARY
       FROM
              EMPLOYEE
       WHERE
              SALARY >= 3000000;
              
-- 전체사원의 사번, 사번명, 급여, 연봉 조회 결과 테이블 생성
CREATE TABLE EMPLOYEE_COPY4
    AS 
       SELECT
               EMP_ID,
               EMP_NAME,
               SALARY,
               SALARY*12
       FROM
               EMPLOYEE;
-- ORA-00998: must name this expression with a column alias
-- 00998. 00000 -  "must name this expression with a column alias"
CREATE TABLE EMPLOYEE_COPY4 AS
SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 연봉
  FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY4;
-- 서브쿼리의 SELECT절 산술연산 또는 함수식이 기술된 경우 반드시 별칭을 부여해야함!!!!!

--------------------------------------------------------------------------------

/*
    * 테이블이 다 생성된 후 뒤늦게 제약조건 추가(ALTER TABLE 테이블명 XXXXX)
   
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명 (참조할컬럼명);
    - CHECK       : ADD CHECK(조건식);
    - UNIQUE      : ADD UNIQUE(컬럼명);
    - NOT NULL    : MODIFY 컬럼명 NOT NULL;
*/

-- EMPLOYEE_COPY 테이블에 없는 PRIMARY KEY 제약조건 추가 EMP_ID 컬럼에
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

-- EMPLOYEE 테이블에 DEPT_CODE 컬럼에 외래키 제약조건 추가(DEPARTMENT의 DEPT_ID 를 참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- EMPLOYEE 테이블에 JOB_CODE 컬럼에 외래키 제약조건 추가(JOB의 JOB_CODE참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);





























































