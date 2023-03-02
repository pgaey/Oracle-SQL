
-- 한 줄 주석
/*
    여러 줄
    주석
*/

-- 일반 사용자 계정을 만들 수 있는 권한은 관리자 계정에 있음
-- 사용자 계정을 생성하는 방법
-- [ 표현법 ] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH; -- 유저명은 소문자로 쳐도 대문자로 들어감, 비번은 구분함

-- 생성된 사용자 계정에게 최소한의 권한(접속, 기본적인 데이터 관리) 부여
-- [ 표현법 ] GRANT 권한1, 권한2, .. TO 계정명;
GRANT CONNECT, RESOURCE TO KH;


SELECT * FROM DBA_USERS;







