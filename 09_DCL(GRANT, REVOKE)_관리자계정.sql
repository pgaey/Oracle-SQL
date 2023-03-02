/*
    < DCL : DATA CONTROL LANTUAGE >
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REMOVE)�ϴ� ���
    
    * ���Ѻο�(GRANT)
    - �ý��۱��� : Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    - ��ü������ȯ : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
    
    [ ǥ���� ]
    GRANT ����1, ����2, .... TO ������;
    
    * �ý��۱����� ����
    - CREATE SESSION : ������ ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �並 ������ �� �ִ� ����
    - CREATE SEQUENCE : �������� ������ �� �ִ� ����
    - CREATE USER : ������ ������ �� �ִ� ����
    ....
*/

-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE; -- ����� ��ҹ��ڸ� ����. ���̵�� ���� X

-- 2. SAMPLE������ �����ϱ� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. SAMPLE������ ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. SAMPLE ������ ���̺� �����̽��� �Ҵ����ֱ�(SAMPLE���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- 2M : 2Mega Byte

-- 4. SAMPLE ������ �並 ������ �� �մ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

--------------------------------------------------------------------------------

/*
    * ��ü ����
    Ư�� ��ü���� ����(SELECT, INSERT, UPDATE, DELETE) �� �� �ִ� ����
    
    [ ǥ���� ]
    GRANT �������� ON Ư����ü TO ������
    
    * ��ü������ ����
    �������� | Ư����ü
    ----------------
    SELECT | TABLE, VIEW, SEQUENCE
    INSERT | TABLE, VIEW
    UPDATE | TABLE, VIEW
    DELETE | TABLE, VIEW
*/

-- 5. SAMPLE ������ KH.EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE ������ KH.DEPARTMENT ���̺� INSERT�� �� �ִ� ���� �ο� 
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
--------------------------------------------------------------------------------

-- �ּ����� ������ �ο��սô� ~ CONNECT, RESOURCE�� �ο�
-- GRANT CONNECT, RESOURCE TO ������;

SELECT *
  FROM ROLE_SYS_PRIVS
 WHERE ROLE IN ('CONNECT', 'RESOURCE');

/*
    < �� ROLE >
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : CREATE SESSION(�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE(Ư�� ��ü���� ���� �� ������ �� �ִ� ����)

*/

--------------------------------------------------------------------------------

/*
    * ���� ȸ��(REVOKE)
    ������ ȸ���� �� ����ϴ� ��ɾ�
    
    [ ǥ���� ]
    REVOKE ����1, ����2... FROM ������̸�
*/

-- 7. SAMPLE�������� ���̺��� ������ �� ������ ���� ȸ��
REVOKE CREATE TABLE FROM SAMPLE;































































