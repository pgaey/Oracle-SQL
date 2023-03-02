/*
    < DDL : DATA DEFINITION LANGUAGE >
    ������ ���� ���
    
    ��ü���� ���Ӱ� ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����

    1. ALTER 
    ��ü ������ �����ϴ� ����
    
    < ���̺� ���� >
    ALTER TABLE ���̺�� ������ ����;
    - ������ ����
    1) �÷� �߰� / ���� / ����
    2) �������� �߰� / ���� => ������ �Ұ�(�����ϰ� ������ ���� �� ������ �ٽ� �߰�)
    3) ���̺�� / �÷��� / �������Ǹ�
*/

-- 1) �÷� �߰� / ���� / ����
-- 1_1) �÷��߰� (ADD) : ADD �߰��� �÷��� ������Ÿ��  DEFAULT �⺻��(DEFAULT �⺻���� ���� ����)
SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- ���ο� �÷��� ��������� NULL���� ��

-- LNAME�÷� �߰� DEFAULT�� ����
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
-- ���ο� �÷��� ��������� LNAME �÷��� DEFAULT ���� ��

-- 1_2) �÷� ����(MODIFY)
--   ������ Ÿ�� ����  : MODIFY �������÷��� �ٲٰ����ϴµ�����Ÿ�� 
--   DEFAULT �� ����  : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ±⺻��

-- DEPT_ID �÷��� ������ Ÿ���� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(10);
-- ���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ���� ������ �ٸ� Ÿ�����δ� ������ �Ұ����ϴ�!!
-- ��) ���� -> ����(X) // ���ڿ� ������ ���(X) // ���ڿ� ������ Ȯ��(OOOOOO)


-- DEPT_TITLE�÷��� ������Ÿ���� VARCHAR2(40)��
-- LOCATION_ID �÷��� �ӵ�����Ÿ���� VARCHAR2(5)��
-- LANME�÷��� �⺻���� '�̱�'
ALTER TABLE DEPT_COPY
      MODIFY DEPT_TITLE VARCHAR2(40)
      MODIFY LOCATION_ID VARCHAR2(5)
      MODIFY LNAME DEFAULT '�̱�';
      
SELECT * FROM DEPT_COPY;

CREATE TABLE DEPT_COPY2
    AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- 1_3) �÷� ����(DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� �÷���

-- DEPT_COPY2�κ��� DEPT_ID�÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

ROLLBACK;
-- DDL������ ���� �Ұ���
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME; -- ������ �÷� ������ ������ �߻�!! : ���̺� �ּ� �Ѱ��� �÷��� �����ؾ���!!
--------------------------------------------------------------------------------

-- 2) �������� �߰� / ����

/*
    2_1) �������� �߰�
    
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    - FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺�� (�������÷���)
    - UNIQUE      : ADD UNIQUE(�÷���)
    - CHECK       : ADD CHECK(�÷��� ���� ����);
    - NOT NULL    : MODIFY �÷��� NOT NULL;
*/

-- DEPT_COPY ���̺�
-- DEPT_ID�÷��� PRIMARY KEY ���������߰�
-- DEPT_TITLE�÷��� UNIQUE�������� �߰�
-- LNAME�÷��� NOT NULL �������� �߰�

ALTER TABLE DEPT_COPY ADD PRIMARY KEY(DEPT_ID) ADD UNIQUE(DEPT_TITLE) MODIFY LNAME NOT NULL;
SELECT * FROM DEPT_COPY;

/*
    2_2) �������� ����
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT �������Ǹ�
    NOT NULL : MODIFY �÷��� NULL
*/

-- PK�������� �����
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007236;

-- NOT NULL ���� ���� �����
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;

--------------------------------------------------------------------------------

-- 3) �÷��� / �������Ǹ� / ���̺� ���� (RENAME)

-- 3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007231 TO CHECK_CONSTRAINT;

-- 3_3) ���̕��� ���� : RENAME �������̺�� TO �ٲ����̺��
--                          �������̺���� ���� ����!! ALTER TABLE �������̺��� ����ϱ� ������!!
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;


/*
    2. DROP
    ��ü�� �����ϴ� ����

*/

DROP TABLE DEPT_TEST;
-- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺���� �������� �ʴ´�.

-- ���࿡ �����ϰ� �ʹٸ�
-- 1. �ڽ����̺��� ������ �θ����̺��� ����
DROP TABLE �ڽ����̺�;
DROP TABLE �θ����̺�;

-- 2. �θ����̺� ����µ� �¹����ִ� �������ǵ� �����ʹ�
DROP TABLE �θ����̺�� CASCADE CONSTRAINT;























































