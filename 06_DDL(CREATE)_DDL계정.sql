/*
    * DDL(DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT)��
    ���Ӱ� �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� �����ϴ� (DROP)�ϴ� ��ɾ�
    ��, ���� ��ü�� �����ϴ� ���� �ַ� DB ������, �����ڰ� �����
    
    ����Ŭ������ ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE)
                        , �ε���(INDEX), ��Ű��(PAKAGE), Ʈ����(TRIGGER)
                        , ��������(PROCEDURE), �Լ�(FUCTION)
                        , ���Ǿ�(SYNONYM), �����(USER)
        
*/

/*
    < CREATE TABLE >
    
    ���̺��̶� ? : ��(ROW), ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
    ��� �����Ͱ� ���̺��� ���ؼ� ����� (�����͸� �����ϰ��� �Ѵٸ� ���̺��� ������ ��)
    
    [ ǥ���� ]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...
    );
    
    < �ڷ��� >
    
    - ����(CHAR(ũ��) / VARCHAR2(ũ��)) : ũ��� BYTE������ 
                                    (����, ������, Ư������ => 1���ڴ� 1BYTE // �ѱ� => 1���ڴ� 3BYTE)
      CHAR(����Ʈ��) : �ִ� 2000BYTE���� ��������
                     ��������(�ƹ��� �������� ���͵� �������� �����ڸ��� ä���� ó�� �Ҵ��� ũ�� ����)
                     �ַ� ���� ���� ���ڼ��� ���������� ���
                     �� ) ���� : ��/��, M/F
      VARCHAR2(����Ʈ��) : �ִ� 4000BYTE���� ��������
                         ��������(���� ���� ������ ��� ���� ���缭 ũ�Ⱑ �پ��)
                         VAR�� '����'�� �ǹ�, 2�� '2��'�� �ǹ�
    
    - ����(NUMBER) : ���� / �Ǽ� ������� NUMBER
    
    
    - ��¥(DATE)
    

*/

-->> ȸ������ ������(���̵�, ��й�ȣ, �̸�, ȸ��������)�� ��� ���� MEMBER ���̺� �����ϱ�

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);
                 
SELECT * FROM MEMBER; -- ������ ������� ������ ���� ����

/*
    �÷��� �ּ��ޱ�(�÷��� ���� ����)
    
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����'

*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ��������';

SELECT * FROM USER_TABLES;

SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM MEMBER;

-- �����͸� �߰��� �� �ִ� ����(INSERT : �� ������ �߰�, ���� ���� �߿�)
-- INSERT INTO ���̺�� VALUES(ù ��° �÷��� ��, �� ��° �÷��� ��, �� ��° �÷��� ��, ....);
INSERT INTO 
MEMBER VALUES('user01', 'pass01', 'ȫ�浿', '2023-02-28');
INSERT INTO 
MEMBER VALUES('user02', 'pass02', 'ȫ�ҵ�', '23/02/28');
INSERT INTO 
MEMBER VALUES('user03', 'pass03', 'ȫ����', SYSDATE);
INSERT INTO 
MEMBER VALUES(NULL, NULL, NULL, SYSDATE); -- ���̵�, ��й�ȣ, �̸��� NULL���� �����ؼ��� �ȉ�
INSERT INTO 
MEMBER VALUES('user03', 'pass03', '�̽�ö', SYSDATE); -- �ߺ��� ���̵� ������

-- ���� NULL��/ �ߺ��� ���̵��� ��ȿ���� ���� ����!
-- ��ȿ�� �����Ͱ��� �����ϱ� ���ؼ� ���������� �ɿ������!!

--------------------------------------------------------------------------------
/*
    < �������� CONSTRAINTS >
    
    - ���ϴ� ������ ���� �����ϱ� ���ؼ�(�����ϱ� ���ؼ�) Ư�� �÷����� �����ϴ� ����(�������� ���Ἲ ������ ��������)
    - ���������� �ο��� �÷��� ���� �����Ͱ� ������ �ִ��� ������ �ڵ����� �˻�
    
    - ���� : NOT NULL, UNIQUE, CKECK, PRIMARY KEY, FOREIGN KEY
    
    - �÷��� ���������� �ο��ϴ� ��� : �÷����� / ���̺���
*/

/*
    1. NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ��� ��� ���(NULL ���� ���� ���ͼ��� �ȵǴ� Į���� �ο�)
    INSERT / UPGDATE �� NULL���� ������� �ʵ��� ���� 
    
    ��, NOT NULL���������� �÷����� ������θ� �ο��� ���� (���̺� X)
*/

-- NOT NULL���������� ������ ���̺� �����
-- �÷����� ��� : �÷��� �ڷ��� ��������  => ���������� �ο��ϰ��� �ϴ� �÷� �ڿ� ��ٷ� ��� 
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
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', SYSDATE);

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL �������� ����!! ���� �߻�!!

INSERT INTO MEM_NOTNULL
VALUES(2, 'user01', 'pass2', NULL, NULL, NULL, NULL); -- NOT NULL ���������� �ο��Ǿ��ִ� ��� �÷��� �ݵ�� ���� �����ؾ��Ѵ�!!

INSERT INTO MEM_NOTNULL
VALUES(3, 'user01', 'pass02', NULL, NULL, NULL, NULL); -- �ߺ���

--------------------------------------------------------------------------------

/*
    2. UNIQUE ��������
    �÷��� �ߺ����� �����ϴ� ��������
    INSERT / UPDATE �� ������ �ش� �÷��� �߿� �ߺ����� ���� ��� �߰� �Ǵ� ������ ���� �ʰ� ����
    
    �÷����� / ���̺��� ��� �� �� ����
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,    -- �÷����� ���. ������ �������
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
    UNIQUE(MEM_ID) -- ���̺��� ������� ������ �Ŵ� ���
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', SYSDATE);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '��浿', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user02', 'pass03', '�ӽñ�', NULL, NULL, NULL);
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT�� ����

/*
    - �������� �ο� �� �������Ǹ� �����ϴ� ���
    
    > �÷����� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� CONSTRAINT �������Ǹ� ��������,
        �÷��� �ڷ���,
        ...
    );
    
    > ���̺��� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...
        CONSTRAINT �������Ǹ� ��������(�÷���)
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

INSERT INTO MEM_CON_NM VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL);
INSERT INTO MEM_CON_NM VALUES(2, 'user01', 'pass02', 'ȫ�浿', NULL, NULL, NULL);
-- ORA-00001: unique constraint (DDL.MEM_ID_UQ) violated ���� ���� �������Ǹ��� ����
SELECT * FROM MEM_CON_NM;

INSERT INTO MEM_CON_NM VALUES(3, 'user03', 'pass03', 'ȫ�浿', '��', NULL, NULL);
-- GENDER�÷����� '��' �Ǵ� '��' ���� ���� �ϰ� ����
--------------------------------------------------------------------------------

/*
    3. CHECK ��������
    �÷��� ����� �� �ִ� ���� ���� ������ �����ص� �� ����
    
    CHECK (���ǽ�)
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE NOT NULL
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-1234', SYSDATE);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�̽�ö', '��', '010-1234-5678', SYSDATE);

INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '��¼��', NULL, NULL, NULL);
-- CHECK �������ǿ� NULL���� INSERT�� ����(NULL���� �������� �ϰ� �ʹٸ� NOT NULL�������ǵ� �ο��ϸ��!!)

SELECT * FROM MEM_CHECK;
-- ȸ���������� �׻� SYSDATE������ �ְ� ������... ���̺��� ���� ����!! -> ���������� �ƴ�!!




































