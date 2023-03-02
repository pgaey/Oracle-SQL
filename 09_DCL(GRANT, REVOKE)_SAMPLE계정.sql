
CREATE TABLE TEST(
    TEST_ID NUMBER
);


-- 3-1. SAMPLE 계정에 테이블을 생성할 수 있는 권한기 없기 때문에 오류발생
-- ORA-01031: insufficient privileges
-- 01031. 00000 -  "insufficient privileges"


-- CREATE TABLE 권한 부여 받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_2. TABLE SPACE가 할당되지 않아서 오류 발생
-- ORA-01950: no privileges on tablespace 'SYSTEM'
-- 01950. 00000 -  "no privileges on tablespace '%s'"

-- TABLE SPACE 할당 받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 테이블 생성 완료

-- 위의 테이블 생성권한을 부여받게 되면
-- 계정이 소유하고 있는 테이블들을 조작하는 것도 가능해짐
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 뷰 만들어보기
CREATE VIEW V_TEST
    AS SELECT * FROM TEST;
-- 4. 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없기 때문에 오류 발생
-- ORA-01031: insufficient privileges
-- 01031. 00000 -  "insufficient privileges"

-- CREATE VIEW 권한 부여받은 후
CREATE VIEW V_TEST
AS SELECT * FROM TEST;
-- 뷰 생성 완료

--------------------------------------------------------------------------------

-- SAMPLE 계정에서 KH계정의 테이블에 접근해서 조회해보기
SELECT *
  FROM KH.EMPLOYEE;
-- 5. KH계정의 테이블에 접근해서 조회할 수 있는 권한이 없기 때문에 오류 발생
-- ORA-00942: table or view does not exist

-- SELECT ON 권한 부여 후
SELECT * 
  FROM KH.EMPLOYEE;
-- EMPLOYEE 테이블 조회 성공

SELECT *
  FROM KH.DEPARTMENT;
-- KH계정에 DEPARTMENT테이블에 접근할 수 있는 권한이 없기 때문에 오류

-- SAMPLE 계정에서 KH계정의 테이블에 접근해서 INSERT해보기
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');
-- ORA-00942: table or view does not exist
-- 6. KH계정의 테이블에 접근해서 INSERT할 수 있는 권한이 없기 때문에 오류 발생

-- INSERT ON 권한 부여 받은 후 
INSERT INTO KH.DEPARTMENT VALUES ('D0', '회계부', 'L2');
-- KH.DEPARTMENT 테이블에 행 INSERT 성공!!

ROLLBACK;


-- 테이블 만들어 보기
CREATE TABLE TEST2(
    TEST_ID NUMBER
);

-- 7. SAMPLE계정에서 테이블을 생성할 수 없도록 권한을 회수했기 때문에 오류 발생
-- 01031. 00000 -  "insufficient privileges"













































