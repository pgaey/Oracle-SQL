
CREATE TABLE TEST(
    TEST_ID NUMBER
);


-- 3-1. SAMPLE ������ ���̺��� ������ �� �ִ� ���ѱ� ���� ������ �����߻�
-- ORA-01031: insufficient privileges
-- 01031. 00000 -  "insufficient privileges"


-- CREATE TABLE ���� �ο� ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_2. TABLE SPACE�� �Ҵ���� �ʾƼ� ���� �߻�
-- ORA-01950: no privileges on tablespace 'SYSTEM'
-- 01950. 00000 -  "no privileges on tablespace '%s'"

-- TABLE SPACE �Ҵ� ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- ���̺� ���� �Ϸ�

-- ���� ���̺� ���������� �ο��ް� �Ǹ�
-- ������ �����ϰ� �ִ� ���̺���� �����ϴ� �͵� ��������
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- �� ������
CREATE VIEW V_TEST
    AS SELECT * FROM TEST;
-- 4. �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ���� ������ ���� �߻�
-- ORA-01031: insufficient privileges
-- 01031. 00000 -  "insufficient privileges"

-- CREATE VIEW ���� �ο����� ��
CREATE VIEW V_TEST
AS SELECT * FROM TEST;
-- �� ���� �Ϸ�

--------------------------------------------------------------------------------

-- SAMPLE �������� KH������ ���̺� �����ؼ� ��ȸ�غ���
SELECT *
  FROM KH.EMPLOYEE;
-- 5. KH������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������ ���� ������ ���� �߻�
-- ORA-00942: table or view does not exist

-- SELECT ON ���� �ο� ��
SELECT * 
  FROM KH.EMPLOYEE;
-- EMPLOYEE ���̺� ��ȸ ����

SELECT *
  FROM KH.DEPARTMENT;
-- KH������ DEPARTMENT���̺� ������ �� �ִ� ������ ���� ������ ����

-- SAMPLE �������� KH������ ���̺� �����ؼ� INSERT�غ���
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');
-- ORA-00942: table or view does not exist
-- 6. KH������ ���̺� �����ؼ� INSERT�� �� �ִ� ������ ���� ������ ���� �߻�

-- INSERT ON ���� �ο� ���� �� 
INSERT INTO KH.DEPARTMENT VALUES ('D0', 'ȸ���', 'L2');
-- KH.DEPARTMENT ���̺� �� INSERT ����!!

ROLLBACK;


-- ���̺� ����� ����
CREATE TABLE TEST2(
    TEST_ID NUMBER
);

-- 7. SAMPLE�������� ���̺��� ������ �� ������ ������ ȸ���߱� ������ ���� �߻�
-- 01031. 00000 -  "insufficient privileges"













































