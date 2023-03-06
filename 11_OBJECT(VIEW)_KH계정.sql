/*
    < VIEW �� >
    SELECT(������)�� �����ص� �� �ִ� ��ü
    (���� ����ϴ� ���̰� �� SELECT���� �����صθ� �� �� �ٽ� ����� �ʿ� ���� VIEW�� �ÿ��ؼ� ���ϰ� ��밡��!!)
    �ӽ����̺� ���� ����(���� �����Ͱ� ���� ����!!!)
*/

------------------------------------- ���� --------------------------------------

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸��� ��ȸ�Ͻð�!!
SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_TITLE,
       SALARY,
       NATIONAL_NAME,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING (NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '�ѱ�';

--------------------------------------------------------------------------------

/*
    1. VIEW ���� ���
    [ ǥ���� ]
    CREATE VIEW ���
    AS ��������;
    
    CREATE OR REPLACE VIEW ���
    AS ��������; -> OR REPLACE�� ���� ����!
    
*/

CREATE VIEW VW_EMPLOAEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_ID = DEPT_CODE)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING (NATIONAL_CODE);
-- ORA-01031: insufficient privileges
-- KH������ �� ���������� ����!!
-- �����ڰ�������  GRANT CREATE VIEW TO KH; ���ָ� �ذ�!!!

CREATE VIEW VW_EMPLOYEE
    AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
          FROM
               EMPLOYEE
          JOIN
               DEPARTMENT ON (DEPT_ID = DEPT_CODE)
          JOIN
               JOB USING (JOB_CODE)
          JOIN
               LOCATION ON (LOCATION_ID = LOCAL_CODE)
          JOIN
               NATIONAL USING (NATIONAL_CODE));
    -- VW_EMLPYOEE

SELECT * FROM VW_EMPLOYEE;
-- ������ �������� ��� ����� �׶��׶� �ʿ��� �����͵鸸 ��ȸ�� �����ϴ� 
-- ���������� ����ϴ°ͺ��� �ξ� �����ϰ� �ذ� ����

SELECT * FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '�ѱ�';
 
SELECT * FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '���þ�';

SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME FROM VW_EMPLOYEE
 WHERE NATIONAL_NAME = '�Ϻ�';


SELECT BONUS FROM VW_EMPLOYEE;
-- VW-EMPLOYEE �信 BONUSĿ���� �������� �ʱ� ������ ���� �߻�

CREATE OR REPLACE VIEW VW_EMPLOYEE
    AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
          FROM
               EMPLOYEE
          JOIN
               DEPARTMENT ON (DEPT_ID = DEPT_CODE)
          JOIN
               JOB USING (JOB_CODE)
          JOIN
               LOCATION ON (LOCATION_ID = LOCAL_CODE)
          JOIN
               NATIONAL USING (NATIONAL_CODE));
-- ���ʽ��÷��� ���� �俴�µ� ���ʽ� �÷��� ��ȸ�� �ϰ�ʹ�.
-- CREATE OR REPLACE�� ���!!

SELECT BONUS FROM VW_EMPLOYEE;
-- ������ ������ �����!!
/*
    OR REPLACE
    �� ���� �� ������ �ߺ��� �̸��� �䰡 �������� �ʴ´ٸ� ���Ӱ� �並 �����ϰ�
             ���࿡ �ߺ��� �䰡 �ִٸ� �ش� �並 ����(����)�ϴ� �ɼ�
*/

-- VIEW�� ������ �������̺� (�������� X)
-- ���� �����͸� �����ϰ� ���� ����!!(�������� TEXT���·� �����ϰ� ����)
SELECT * FROM USER_VIEWS;
--------------------------------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
    ���������� SELECT���� �Լ��� ���������� ����Ǵ� ��� �ݵ�� ��Ī ����
*/
-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��� ����
CREATE OR REPLACE VIEW VIEW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
              EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
         FROM EMPLOYEE
         JOIN JOB USING(JOB_CODE);
-- ��Ī�� �������� �ʾ� ���� �߻�
-- ORA-00998: must name this expression with a column alias

CREATE OR REPLACE VIEW VIEW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����,
              EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
         FROM EMPLOYEE
         JOIN JOB USING(JOB_CODE);
-- �� ���� ����

SELECT * FROM VIEW_EMP_JOB;

-- ��Ī�ο��� �ٸ����!!(��, ��� �÷��� ���� ��Ī�� �� �ο��ؾ���!!)
CREATE OR REPLACE VIEW VIEW_EMP_JOB (���, �����, ���޸�, ����, �ٹ����)
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
              DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
              EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
         FROM EMPLOYEE
         JOIN JOB USING(JOB_CODE);

SELECT �����, �ٹ����
  FROM VIEW_EMP_JOB;

SELECT *
  FROM VIEW_EMP_JOB
 WHERE �ٹ���� >= 20;

-- �並 �����Ϸ��� �Ѵٸ�??
DROP VIEW VIEW_EMP_JOB;

--------------------------------------------------------------------------------

/*
    * ������ �並 �̿��ؼ� DML(DELETE, INSERT, UPDATE) ��밡��
    ��, �並 ���ؼ� DML������ �����ϰ� �Ǹ� ���� �����Ͱ� ����ִ� ���̺�(���̽����̺�)���� ������ �ȴ�!!
*/
CREATE OR REPLACE VIEW VW_JOB
    AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;

-- �信 INSERT
INSERT INTO VW_JOB VALUES('J8', '����');

SELECT * FROM JOB;

-- VIEW UPDATE!
UPDATE VW_JOB
   SET JOB_NAME = '�˹�'
 WHERE JOB_CODE = 'J8';

-- VIEW DELETE
DELETE FROM VW_JOB
 WHERE JOB_CODE = 'J8';
 
 SELECT * FROM JOB;

--------------------------------------------------------------------------------
/*
    VIEW�� ������ DML�� �Ұ����� ���!!!
    
    1) VIEW�� ���ǵ��� ���� �÷��� �����ϴ� ���
    2) VIEW�� ���ǵ��� ���� Ŀ�� �߿� ���̽����̺� NOT NULL���������� �����Ǿ��ִ� ���
    3) �������� �Ǵ� �Լ��� ���ؼ� ������ ���
    4) GROUP BY �׷��Լ� ���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���    
*/
--------------------------------------------------------------------------------
/*
    * VIEW �ɼ� 
    
    [ ��ǥ���� ]
    CREATE OR REPLACE FORCE/NOFORCE VIEW ���
    AS ��������
    WITH CHECK OPTION
    WITH READ ONLY;
    
    1) OR REPLACE : �ش� �䰡 �������� ������ ���� ���� / �ش� �䰡 �����Ѵٸ� ���Ž����ִ� �ɼ�
    2) FORCE / NOFORCE
        - FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 ����
        - NOFORCE(������ �⺻��) : ���������� ����� ���̺��� �ݵ�� �����ؾ߸� �䰡 ����
    3) WITH CHECK OPTION : ���������� �������� ����� ���뿡 �����ϴ� �����θ� DML�� ����
                           ���ǿ� �������� ���� ������ �����ϴ� ��� ���� �߻�
    4) WITH READ ONLY : �信 ���� ��ȸ�� ����(DML ���� �Ұ�)
*/

-- 2) FORCE / NOFORCE 
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_TEST
    AS SELECT TCODE, TNAME, TCONTENT
         FROM T;
-- ORA-00942: table or view does not exist
-- T��� ���̺��� �������� �ʱ� ������ ���� �߻�!

CREATE OR REPLACE FORCE VIEW VW_TEST
    AS SELECT TCODE, TNAME, TCONTENT
         FROM T;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_TEST;
-- ���� �߻�
-- ��, ���� �ǿ��� KH-�並 ����� VW_TEST�䰡 ������ �� ���� Ȯ���� ����!

CREATE TABLE T(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(40)
);

SELECT * FROM VW_TEST;
-- T ���̺� ���� �� �ٽ� �並 ��ȸ�ϸ� ���������� Ȯ���� ����!!


-- 3) WITH CHECK OPTION
CREATE OR REPLACE VIEW VW_EMP
    AS SELECT *
         FROM EMPLOYEE
        WHERE SALARY >= 3000000
  WITH CHECK OPTION; -- ���� ����� WHERE ������  

SELECT * FROM VW_EMP;

UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 200;
-- ���������� ����� �������� �������� �ʱ� ������ ���� �Ұ�

UPDATE VW_EMP
   SET SALARY = 5000000
 WHERE EMP_ID = 200;
-- ���������� ����� ���ǿ� �����ϱ� ������ ���氡��! 

SELECT * FROM VW_EMP;

ROLLBACK;


-- 4) WITH READ ONLY   -- �ٿ��� RO��� ��

CREATE OR REPLACE VIEW VW_EMPBONUS
    AS SELECT EMP_ID, EMP_NAME, BONUS
         FROM EMPLOYEE
        WHERE BONUS IS NOT NULL
  WITH READ ONLY;
  
SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
 WHERE EMP_ID = 207;
-- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view
-- DML ����Ұ�!!

















































