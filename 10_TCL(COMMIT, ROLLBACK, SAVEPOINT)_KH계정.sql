/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    트랜잭션을 제어하는 언어
    
    * 트랜잭션(TRANSACTION)     -> 작업단위
    - 데이터베이스의 논리적 연산단위
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
    - 데이터의 변동사항(DML)들을 하나의 트랜잭션에 묶어서 처리
    COMMIT(확정)하기 전가지의 변경사항들을 하나의 트랜잭션으로 담게 됨
    
    
    COMMIT(트랜잭션 종료처리 후 확정), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시저장점 잡기)
    
    * 트랜잭션의 종류
    - COMMIT; 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는 것을 의미
                    실제 DB에 반영시킨 후 트랜잭션은 비워짐
    - ROLLBACK; 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 삭제한 후 마지막 COMMIT시점으로 돌아감
    - SAVEPOINT 포인트명; : 현재 이 시점에 임시저장점을 만들겠다.
    - ROLLBACK 포인트명; : 전체 변경사항을 날리는 것이 아니라 해당 포인트 지점까지의 트랜잭션만 롤백하겠다.
    
*/

SELECT * FROM EMP_01;
-- 사번이 901인 사원 삭제
DELETE FROM EMP_01
 WHERE EMP_ID = 901;

-- 사번이 900인 사원 삭제
DELETE FROM EMP_01
 WHERE EMP_ID = 900;

ROLLBACK;

--------------------------------------------------------------------------------
-- 사번이 200번인 사원 삭제
DELETE FROM EMP_01
 WHERE EMP_ID = 200;
 
SELECT * FROM EMP_01;

-- 사번이 800,, 이름 홍길동, 부서는 총무부인 사원 추가
INSERT INTO EMP_01
VALUES(800,'홍길동', '총무부');

COMMIT;

SELECT * FROM EMP_01;

ROLLBACK;
--------------------------------------------------------------------------------

-- 사번이 217, 216, 214인 사원 삭제
DELETE FROM EMP_01
 WHERE EMP_ID IN (217, 216, 214);

-- 3개의 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;

DELETE FROM EMP_01
 WHERE EMP_ID = 218;

-- 사번 801, 이름 김말똥, 부서 인사부 사원 추가
INSERT INTO EMP_01
VALUES(801, '김말똥', '인사부');

-- SP1로 ROLLBACK
ROLLBACK TO SP1;

COMMIT;

SELECT * FROM EMP_01;
--------------------------------------------------------------------------------

-- 사번이 900, 901인 사원 삭제
DELETE FROM EMP_01
 WHERE EMP_ID IN (900, 901);
       
DELETE FROM EMP_01
 WHERE EMP_ID = 209;
 
-- DDL 구문 사용 
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

SELECT * FROM EMP_01 ORDER BY EMP_ID;

/*
    DDL(CREATE, ALTER, DROP)을 실행하는 순간
    기존 트랜잭션에 있던 모든 변경사항을 무조건 실제 DB에 반영(COMMIT)시킨 후에 DDL이 수행
    => DDL수행 전 변경사항들이 있다면 정확히 트랜잭션처리(COMMIT, ROLLBACK)를 하고 DDL을 실행해야 함!!!

*/



















































