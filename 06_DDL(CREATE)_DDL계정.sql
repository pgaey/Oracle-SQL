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

--------------------------------------------------------------------------------
/*
    * Ư�� �÷��� ���� ���� ���� �⺻���� ���� => ���������� �ƴ�
*/

DROP TABLE MEM_CHECK;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL  
);

/*
    INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3, �÷��� 4)
    VALUES(��1, ��2, ��3, ��4)
    �������� ���� ������ NULL ���� ��
*/

INSERT INTO MEM_CHECK (MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES (1, 'user01', 'pass01', 'ȫ�浿');

SELECT * FROM MEM_CHECK;
-- ������ ���� ���� �÷����� �⺻������ NULL���� ������
-- ���� DEFAULT���� �ο��Ǿ� �ִٸ� NULL���� �ƴ� DEFAULT������ INSERT�ȴ�!!

--------------------------------------------------------------------------------

/*
    4. PRIMARY KEY(�⺻Ű)(���� PK��� ��) ��������
    ���̺��� �� ����� ������ �����ϰ� �ĺ��� �� �ִ� �÷��� �ο��ϴ� ��������
    => �� ����� ������ �� �ִ� �ĺ����� ����
    �� ) ȸ����ȣ, �ֹ���ȣ, ���, �й�, �����ȣ, .....
    => �ߺ����� �ʰ� ���� �����ؾ߸� �ϴ� �÷��� RPIMARY KEY�ο�(NOT NULL + UNIQUE)
    
    ��, �� ���̺�� �� ���� ���� ����
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, -- �÷����� ��� 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE
    -- PRIMARY KEY(MEM_NO)  -- ���̺� ���� ���
);


INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', NULL, NULL);

INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user02', 'pass02', '�ӽñ�', '��', NULL, NULL);
-- ORA-00001: unique constraint (DDL.MEM_PK) violated
-- �⺻Ű �÷��� �ߺ����� �߻��ؼ� ������ �߻�!!

INSERT INTO MEM_PRIMARYKEY1
VALUES(NULL, 'user02', 'pass02', '�ӽñ�', '��', NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRIMARYKEY1"."MEM_NO")
-- �⺻Ű �÷��� NULL������ ���� ������ �߻�!!

INSERT INTO MEM_PRIMARYKEY1
VALUES(2, 'user02', 'pass02', '�ӽñ�', '��', NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY1;


CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE
);
-- PRIMARYKEY�� �� ���̺� �� ���� �� �� ����.
-- ORA-02260: table can have only one primary key
-- �� ���� �÷��� �ϳ��� ��� PRIMARY KEY �ϳ��� ���� ����!

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    MEM_DATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(MEM_NO, MEM_ID)    -- �÷��� ��� PRIMARY KEY �ϳ��� ���� => ����Ű
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', 'ȫ�浿', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2,'user02', 'pass03', 'ȫ�浿', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(NULL, 'user03', 'pass04', 'ȫ�浿', NULL, NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRIMARYKEY2"."MEM_NO")
-- �⺻Ű�� �����Ǿ��ִ� �÷��鿡�� NULL���� ���� �� ����!!!

SELECT * FROM MEM_PRIMARYKEY2;
--------------------------------------------------------------------------------

-- ȸ�� ��޿� ���� ������(����ڵ�, ��޸�) �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEM_GRADE VALUES ('G1', '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES ('G2', '���ȸ��');
INSERT INTO MEM_GRADE VALUES ('G3', 'Ư��ȸ��');

DROP TABLE MEM_GRADE;

SELECT * FROM MEM_GRADE;

/*
    5. FOREIGN KEY(�ܷ�Ű) ��������
    �ش� �÷��� �ٸ� ���̺� �����ϴ� ���� ���;��ϴ� ��쿡 �ο��ϴ� ��������
    => �ٸ� ���̺�(�θ����̺�)�� �����Ѵٰ� ǥ��
        ������ �ٸ� ���̺��� �����ϰ� �ִ� ���� ���� �� ����
    => FOREIGN KEY������������ �ٸ� ���̺��� ���踦 ������ �� ����
    
    [ ǥ���� ]
    - �÷����� ���
    �÷��� �ڷ��� CONSTRAINT �������Ǹ� REFERENCES ���������̺��(������ �÷���)
    
    - ���̺��� ���
    CONSTRAINT �������Ǹ� FOREIGN KEY(�÷���) REFERENCES ���������̺��(�������÷���)
    
    �� ��� ��� ������ �÷����� ���� �����ϴ�.
    ������ �÷����� ������ ��� ������ ���̺��� PRIMARY KEY �÷����� �������÷����� ������.
    CONSTRAINT�������Ǹ� ���� ������ �����ϴ�.

*/

-- �ڽ� ���̺�
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),      -- �÷�����
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(15)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- ���̺��� ���
);

INSERT INTO MEM
VALUES (1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES (2, 'user02', 'pass02', 'ȫ�浿', 'G2', NULL, NULL);

INSERT INTO MEM
VALUES (3, 'user03', 'pass03', '�ӽñ�', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES (4, 'user04', 'pass04', '����', NULL, NULL, NULL);
-- �ܷ�Ű ���������� �ɷ��ִ� �÷����� �⺻������ NULL���� �� �� ����

INSERT INTO MEM
VALUES (5, 'user05', 'pass05', '���°�', 'G4', NULL, NULL);
-- parent key not found �߻�!!
-- G4����� MEM_GRADE ���̺��� GRADE_CODE�÷����� �����ϴ� ���� �ƴϱ� ������ ���� �߻�!!
-- ORA-02291: integrity constraint (DDL.SYS_C007194) violated - parent key not found

SELECT * FROM MEM;

-- �θ����̺�(MEM_GRADE)���� �����Ͱ� �����ȴٸ�??
-- MEM_GRADE���̺�κ��� GRADE_CODE�� G1�� [������] �����
DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G1';
-- �ڽ����̺�(MEM)���� G1�� ����ϰ� �ֱ� ������ ������ �� ����
-- �ܷ�Ű ���������� �ο��� �� �����ɼ��� �ο����� �ʾ���
-- �����ɼ��� ���� �������� �ʴ´ٸ� �������ѿɼ��� �ɸ�!!
-- ORA-02292: integrity constraint (DDL.SYS_C007194) violated - child record found

DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G3';
-- �ڽ����̺��� ����ϰ� �ִ� ���� �ƴϱ� ������ ���� ����

ROLLBACK;

DROP TABLE MEM;

--------------------------------------------------------------------------------

/*
    * �ڽ� ���̺� ���� ��(�ܷ�Ű �������� �ο� ��)
      �θ����̺��� �����Ͱ� �����Ǿ��� �� �ڽ����̺����� ��� ó���� ���� �ɼ����� ���س��� �� ����
      
    
    * FOREIGN KEY ���� �ɼ�
    �����ɼ��� ������ �������� ������ ON DELETE RESTRICTED(���� ����) ���� �⺻����!
*/

-- 1) ON DELETE SET NULL : �θ� ������ ���� �� �ش絥���͸� ����ϰ� �ִ� �ڽĵ����͸� NULL�� �����Ű�� �ɼ�
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(15),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL -- ���̺� ���� ���     
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', 'ȫ����', 'G2', NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', 'ȫ���', 'G1', NULL, NULL);

-- �θ����̺� (MEM_GRADE)�� GRADE_CODE�� G1�� ������ ����
DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G1';

-- �������� �� ������!
-- �ڽ����̺�(MEM)�� GRADE_ID�� G1�� �κ��� ��� NULL�� �Ǿ����!!!

SELECT * FROM MEM;

DROP TABLE MEM;

-- 2) ON DELETE CASCADE : �θ����� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� �����ع����� �ɼ�

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2),
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    FOREIGN KEY (GRADE_ID) REFERENCES MEM_GRADE/*(GRADE_CODE)*/ ON DELETE CASCADE
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', 'ȫ����', 'G2', NULL, NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', 'ȫ���', 'G1', NULL, NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '�ΰ�', NULL, NULL, NULL);

DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 'G1';
-- �ڽ����̺�(MEM)�� GRADE_ID�� G1�� ����� ��� �Բ� ���� !!!

ROLLBACK;

-- ��üȸ���� ȸ����ȣ, ���̵�, ��й�ȣ, �̸�, ��޸� ��ȸ
--> ����Ŭ ���뱸��
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

--> ANSI ����
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
    ���� �ܷ�Ű ���������� �ɷ����� �ʴ��� JOIN ������
    �ٸ�, �� �÷��� ������ �ǹ̿� �����Ͱ� ����ִٸ� ��Ī�ؼ� JOIN�� �� ����!!!
*/

DROP TABLE MEM;

--------------------------------------------------------------------------------
/*
    ---- ���⼭���� ������ KH��������!! ----
    
    * SUBQUERY�� �̿��� ���̺� ����(���̺� ���� �ߴ� ����)
    
    ���� SQL���� ���������� �ϴ� ������ => ��������
    
    [ ǥ���� ]
    CREATE TABLE ���̺��
    AS ��������;
    
    �ش� ���������� ������ ����� ���ο� ���̺��� ������ �� ����!
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ����(EMPLOYEE_COPY)

CREATE TABLE EMPLOYEE_COPY
    AS SELECT *
       FROM EMPLOYEE;
--> �÷���, ��ȸ����� �����Ͱ���
--> �������ǰ��� ����! NOT NULL�� �����!

SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE���̺� �ִ� �÷��� ������ �����ϰ� ����! �����Ͱ��� �ʿ����!!!
CREATE TABLE EMPLOYEE_COPY2
    AS SELECT *
       FROM EMPLOYEE
       WHERE 1 = 0; -- 1 = 0�� FALSE�� �ǹ�!

SELECT * FROM EMPLOYEE_COPY2;


-- ��ü ����� �� �޿��� 300���� �̻��� ������� ���, �̸�, �μ��ڵ�, �޿� �÷� ����
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
              
-- ��ü����� ���, �����, �޿�, ���� ��ȸ ��� ���̺� ����
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
SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 ����
  FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY4;
-- ���������� SELECT�� ������� �Ǵ� �Լ����� ����� ��� �ݵ�� ��Ī�� �ο��ؾ���!!!!!

--------------------------------------------------------------------------------

/*
    * ���̺��� �� ������ �� �ڴʰ� �������� �߰�(ALTER TABLE ���̺�� XXXXX)
   
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺�� (�������÷���);
    - CHECK       : ADD CHECK(���ǽ�);
    - UNIQUE      : ADD UNIQUE(�÷���);
    - NOT NULL    : MODIFY �÷��� NOT NULL;
*/

-- EMPLOYEE_COPY ���̺� ���� PRIMARY KEY �������� �߰� EMP_ID �÷���
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

-- EMPLOYEE ���̺� DEPT_CODE �÷��� �ܷ�Ű �������� �߰�(DEPARTMENT�� DEPT_ID �� ����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- EMPLOYEE ���̺� JOB_CODE �÷��� �ܷ�Ű �������� �߰�(JOB�� JOB_CODE����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);





























































