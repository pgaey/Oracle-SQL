/*
    < DML : DATA MANIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ���ο� �����͸� ����(INSERT) �ϰų�, ������ �����͸� ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����
    DML INSERT UPDATE DELETE 
*/

/*
    1. INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ ǥ���� ]
    1) INSERT INTO ���̺�� VALUES(��, ��, ��, ��, ....);
    => �ش� ���̺� ��� �÷��� ���� �߰��ϰ��� �� �� ���� ���� ���� �����ؼ� �� ���� INSERT �� �� ����
    ������ �� : �÷� ������ ���Ѽ� VALUES��ȣ �ȿ� ���� �����ؾ� ��
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES (900, 'ȫ�浿', '550101-1010101', 'HONG@NAVER.COM', '01012341234', 'D1', 'J1', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);

SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       EMP_ID = '900';

/*
    2) INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES(��, ��, ��);
    => �ش� ���̺� Ư�� �÷��� �����ؼ� �� �÷��� �߰��� ���� ������ �� ���
    �� �� ������ �߰��Ǳ� ������ ������ ���� ���� �÷��� �⺻������ NULL���� ��
    (��, DEFAULT(�⺻��)�� �����Ǿ����� ��� �⺻���� ��)
    �������� : NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� ���� �����ؾ���
            -> NOT NULL ���������� �ɷ��ִ� �÷��� �⺻���� �����Ǿ��ִٸ� ���� ���� �� ����
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL)          -- �ּ� �������� �� �� �˾ƾ���
VALUES (901,'��浿', '222222-0222222', 'D1', 'J2', 'S1');

SELECT * FROM EMPLOYEE;

/*
    3) INSERT INTO ���̺�� (��������)
    => VALUES�� ���� �����ϴ� ��� ���������� ��ȸ�� RESULT SET�� ��ä�� INSERT�ϴ� ����(���� ���� INSERT�� �� ����)
*/
-- ���ο� ���̺� ���� �����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ����� ��ȸ�� ����� EMP_01 ���̺� �߰�
INSERT INTO EMP_01
                    (
                      SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                        FROM EMPLOYEE, DEPARTMENT
                       WHERE DEPT_CODE = DEPT_ID(+)
                    );
                    
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------

/*
    2. INSERT ALL
    �� �� �̻��� ���̺� ���� INSERT�� �� ���
    �� �� ���Ǵ� ���������� ������ ���
*/

-- ���ο� ���̺� �����
-- ù��° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, ���޸��� ������ ���̺�
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);


-- �ι�° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, �μ����� ������ ���̺�
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- �޿��� 300���� �̻��� ������� ���, �̸�, ���޸�, �μ��� ��ȸ
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
 WHERE
       SALARY >= 3000000;

/*
    1) INSERT ALL
       INTO ���̺��1 VALUES(�÷���, �÷���, �÷���)
       INTO ���̺��2 VALUES(�÷���, �÷���, �÷���)
           ��������;
*/          

-- EMP_JOB ���̺��� �޿��� 300���� �̻��� ������� EMP_ID, EMP_NAME, JOB_NAME�� INSERT
-- EMP_DEPT ���̺��� �޿��� 300���� �̻��� ������� EMP_ID, EMP_NAME, DEPT_TITLE�� INSERT

INSERT ALL                                              
  INTO EMP_JOB VALUES (EMP_ID, EMP_NAME, JOB_NAME)      -- 9�� ���� �߰�
  INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_TITLE)   -- 9�� ���� �߰�  �� 18�� ��
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
 WHERE
       SALARY >= 3000000;

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- INSERT ALL�� ������ �߰��ؼ� �� ���̺� INSERT

-- ���, �����, �Ի���, �޿� (EMP_OLD) => 2010�⵵ ���� �Ի��� ���
CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
       WHERE 1 = 0;


-- ���, �����, �Ի���, �޿� (EMP_NEW) => 2010�⵵ ���� �Ի��� ���
CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
       FROM EMPLOYEE
       WHERE 1 = 0;

SELECT
       EMP_ID,
       EMP_NAME,
       HIRE_DATE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       HIRE_DATE >= '2010/01/01';
--       HIRE_DATE < '2010/01/01';

/*
    2) INSERT ALL
       WHEN ����1 THEN
       INTO ���̺��1 VALUES(�÷���, �÷���, �÷���)
       WHEN ����2 THEN
       INTO ���̺��2 VALUES(�÷���, �÷���, �÷���)
       ��������   
*/

INSERT ALL 
  WHEN HIRE_DATE < '2010/01/01' THEN
  INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
  WHEN HIRE_DATE >= '2010/01/01' THEN
  INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT
       EMP_ID,
       EMP_NAME,
       HIRE_DATE,
       SALARY
  FROM
       EMPLOYEE;
       
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

--------------------------------------------------------------------------------
/*
    3. UPDATE
    ���̺� ��ϵ� ������ �����͸� �����ϴ� ����
    
    [ ǥ���� ]
    UPDATE ���̺��
        SET �÷��� = �ٲ� ��
           ,�÷��� = �ٲ� ��
           ,�÷��� = �ٲ� ��
           ,... => ���� ���� �÷��� ���� ���� ����(,�� �����ؾ��� AND���� �ȵ�!!!)
     WHERE ����; => WHERE���� ���� ����, ���� �� ��ü ��� ���� �����Ͱ� �� �ٲ�----���� ���ٰ� ���� ��
*/

-- ���纻 ���̺� �ϳ� ����!
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;
    
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺� D9�μ��� �μ����� ������ȹ������ ����
UPDATE DEPT_COPY
   SET DEPT_TITLE = '������ȹ��' -- ��ü �� DEPT_TITLE�÷��� ��� ���� �� ������Î������ �ٲ��
 WHERE DEPT_TITLE = '�ѹ���';
-- DEPT_TITLE ���� �ѹ����� �μ����� ã�Ƽ� ����


CREATE TABLE EMP_SALARY
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
       FROM EMPLOYEE;
       
SELECT * FROM EMP_SALARY;

-- EMP_SALARY ���̺� ȫ�浿 ����� �޿��� 1000�������� ����
UPDATE EMP_SALARY
   SET SALARY = 10000000
 WHERE EMP_NAME = 'ȫ�浿';
 
-- ��ü����� �޿��� ������ �޿��� 20���� �λ��� �ݾ����� ����
UPDATE EMP_SALARY
   SET SALARY = SALARY * 1.2;
   

/*
    * UPDATE�� ���������� ���
    
    UPDATE ���̺��
       SET �÷��� = (��������)
*/

-- EMP_SALARY���̺� 'ȫ�浿'����� �μ��ڵ带 '������' ����� �μ��ڵ�� ����
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '������';


UPDATE EMP_SALARY
   SET DEPT_CODE = (SELECT
                          DEPT_CODE
                     FROM
                          EMPLOYEE
                    WHERE
                          EMP_NAME = '������')
 WHERE
       EMP_NAME = 'ȫ�浿';

SELECT * FROM EMP_SALARY;   


-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ������� ����
SELECT
       SALARY
      ,BONUS
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '�����';
       
       
UPDATE
       EMP_SALARY
   SET (SALARY ,BONUS)  = (SELECT SALARY ,BONUS
                             FROM EMP_SALARY
                            WHERE EMP_NAME = '�����')
 WHERE EMP_NAME = '����';
      
SELECT * FROM EMP_SALARY;

--------------------------------------------------------------------------------

-- ���߱� ����� ����� 200������ ����
UPDATE EMPLOYEE
   SET EMP_ID = 200
 WHERE EMP_NAME = '���߱�'; --PRIMARY KEY �������� ����!!
 
-- ����� 200���� ����� �̸��� NULL�� ����
UPDATE EMPLOYEE
   SET EMP_NAME = NULL
 WHERE EMP_ID = 200; -- NOT NULL �������ǿ� ����!!

-- UPDATE �ÿ��� ������ ���� �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�!!!

COMMIT; -- ��� ������׵��� Ȯ���ϴ� ��ɾ�

--------------------------------------------------------------------------------
/*
    4. DELETE
    ���̺� ��ϵ� �����͸� �����ϴ� ����
    
    [ ǥ���� ]
    DELETE FROM ���̺��
     WHERE ����; => WHERE ��������, ���� �� �ش� ���̺� ��ü �� ����
*/

DELETE FROM EMPLOYEE; -- EMPLOYEE ���̺� ��� �� ����

ROLLBACK; -- �ѹ� �� ������ Ŀ�� �������� ���ư�

SELECT * FROM EMPLOYEE;

-- ȫ�浿�� ��浿 ������ ������ �����
DELETE FROM EMPLOYEE
 WHERE EMP_NAME IN ('ȫ�浿', '��浿');

COMMIT;

-- DEPARTMENT ���̺�κ��� DEPT_ID�� D1�� �μ� ����
DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D1';


-- DEPARTMENT ���̺�κ��� DEPT_ID�� D3�� �μ� ����
DELETE FROM DEPARTMENT
 WHERE DEPT_ID = 'D3';
 
ROLLBACK;

/*
    * TRUNKCATE : ���̺��� ��ü ���� ������ �� ����ϴ� ����(����)
                  ������ ���� ���� �Ұ�, ROLLBACK�� �Ұ���!!!
                  DELETE���� ����ӵ��� �� ����!!!!!!
    [ ǥ���� ]
    
    TRUNCATE TABLE ���̺��;            |         DELETE FROM ���̺��;
 --------------------------------------------------------------------------
    ������ ���� ���� �Ұ�                 |          Ư�� ���� ���� ����
    ���� �ӵ� ����                       |            ����ӵ� ����
    ROLLBACK �Ұ���                     |            ROLLBACK�� ����   
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY; -- 0.042��

ROLLBACK;

TRUNCATE TABLE EMP_SALARY; -- 0.165��
-- Table EMP_SALARY��(��) �߷Ƚ��ϴ�.













