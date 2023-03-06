/*
    < 시퀀스 SEQUENCE >
    자동으로 번호를 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 생성해줌
    
    예 ) 회원번호, 사번, 게시글 번호 등등 채번할 때 주로 사용할 예정
    
    1. 시퀀스객체 생성 구문
    
    [ 표현법 ]
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자                      => 생략 가능, 처음 발생시킬 시작값 지정
    INCREMENT BY 증가값                     => 생략 가능, 몇 씩 증가시킬건지 결정 
    MAXVALUE 최대값                         => 생략 가능, 최대값 지정
    MINVALUE 최소값                         => 생략 가능, 최소값 지정
    CYCLE/NOCYCLE                          => 생략 가능, 값 순환 여부 지정
    CACHE 바이트크기/NOCACHE                 => 생략 가능, 캐시 메모리 여부 지정, CACHE_SIZE  기본값은 20BYTE
    
    * 캐시메모리 : 미리 발생될 값들을 생성해두는 저장공간
                매 번 호출할 때마다 새롭게 번호를 생성하는 것보다 
                캐시 메모리 공간에 미리 생성된 값들을 가져다 쓰게되면 속도가 빠름!!
                단, 접속이 끊기고나서 재접속 후 기존에 생성되있던 값들은 날아가고 없음!!!
*/

/*
    * 접두사
    - 테이블 : TB_
    - 뷰 : VW_
    - 시퀀스명 : SEQ_

*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;
-- UWER_TALBES, USER_VIEWS 복수형

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

--------------------------------------------------------------------------------

/*
    2. 시퀀스 사용 구문
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값(마지막으로 성공적으로 발생한 NEXTVAL 값)
    시퀀스명.NEXTVAL : 시퀀스 값을 증가시키고 증가된 시퀀스의 값
                    => 시퀀스 생성 후 첫 NEXTVAL은 STARTWITH로 지정된 시작값이 만들어짐
                    => 기존의 시퀀스값에서 INCREMENT BY 값만큼 증가된 값
                    (시퀀스명.CURRVAL + INCREMENT BY 값)
*/
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- NEXTVAL을 한번이라도 수행하지 않는 이상 CURRVAL을 수행할 수 없음
-- CURRVAL은 마지막에 성공적으로 수행한 NEXTVAL의 값을 저장해서 보여주는 임시값이기 때문!

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305 INCREMENT BY 5 로 지정해줬기 때문에

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER : 현재 상황에서 NEXTVAL을 수행할 경우 예정값
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 지정한 MAXVALUE값을(310) 초과했기 때문에 오류 발생

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

--------------------------------------------------------------------------------
/*
    3. 시퀀스 수정
    
    CREATE -> ALTER절로 INCREMENT BY, MAXVALUE, MINVALUE, CYCLE, CACHE 수정가능
    
    START WITH는 변경불가! => 정 바꾸고 싶다면 해당 시퀀스를 삭제했다가 다시 생성
*/

ALTER SEQUENCE SEQ_EMPNO
MAXVALUE 400
INCREMENT BY 10;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

-- SEQUENCE 삭제하기
DROP SEQUENCE SEQ_EMPNO;

































































