/*
    < ������ SEQUENCE >
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������
    
    �� ) ȸ����ȣ, ���, �Խñ� ��ȣ ��� ä���� �� �ַ� ����� ����
    
    1. ��������ü ���� ����
    
    [ ǥ���� ]
    CREATE SEQUENCE ��������
    START WITH ���ۼ���                      => ���� ����, ó�� �߻���ų ���۰� ����
    INCREMENT BY ������                     => ���� ����, �� �� ������ų���� ���� 
    MAXVALUE �ִ밪                         => ���� ����, �ִ밪 ����
    MINVALUE �ּҰ�                         => ���� ����, �ּҰ� ����
    CYCLE/NOCYCLE                          => ���� ����, �� ��ȯ ���� ����
    CACHE ����Ʈũ��/NOCACHE                 => ���� ����, ĳ�� �޸� ���� ����, CACHE_SIZE  �⺻���� 20BYTE
    
    * ĳ�ø޸� : �̸� �߻��� ������ �����صδ� �������
                �� �� ȣ���� ������ ���Ӱ� ��ȣ�� �����ϴ� �ͺ��� 
                ĳ�� �޸� ������ �̸� ������ ������ ������ ���ԵǸ� �ӵ��� ����!!
                ��, ������ ������� ������ �� ������ �������ִ� ������ ���ư��� ����!!!
*/

/*
    * ���λ�
    - ���̺� : TB_
    - �� : VW_
    - �������� : SEQ_

*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;
-- UWER_TALBES, USER_VIEWS ������

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

--------------------------------------------------------------------------------

/*
    2. ������ ��� ����
    
    ��������.CURRVAL : ���� �������� ��(���������� ���������� �߻��� NEXTVAL ��)
    ��������.NEXTVAL : ������ ���� ������Ű�� ������ �������� ��
                    => ������ ���� �� ù NEXTVAL�� STARTWITH�� ������ ���۰��� �������
                    => ������ ������������ INCREMENT BY ����ŭ ������ ��
                    (��������.CURRVAL + INCREMENT BY ��)
*/
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- NEXTVAL�� �ѹ��̶� �������� �ʴ� �̻� CURRVAL�� ������ �� ����
-- CURRVAL�� �������� ���������� ������ NEXTVAL�� ���� �����ؼ� �����ִ� �ӽð��̱� ����!

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305 INCREMENT BY 5 �� ��������� ������

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER : ���� ��Ȳ���� NEXTVAL�� ������ ��� ������
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- ������ MAXVALUE����(310) �ʰ��߱� ������ ���� �߻�

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

--------------------------------------------------------------------------------
/*
    3. ������ ����
    
    CREATE -> ALTER���� INCREMENT BY, MAXVALUE, MINVALUE, CYCLE, CACHE ��������
    
    START WITH�� ����Ұ�! => �� �ٲٰ� �ʹٸ� �ش� �������� �����ߴٰ� �ٽ� ����
*/

ALTER SEQUENCE SEQ_EMPNO
MAXVALUE 400
INCREMENT BY 10;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

-- SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;

































































