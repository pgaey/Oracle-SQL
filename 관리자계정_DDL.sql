

-- DDL을 연습할 새로운 계정 생성
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER DDL IDENTIFIED BY DDL;

-- 최소한의 권한 부여 (DCL)
-- GRANT 권한1, 권한2, ...... TO 계정명;
GRANT CONNECT, RESOURCE TO DDL;