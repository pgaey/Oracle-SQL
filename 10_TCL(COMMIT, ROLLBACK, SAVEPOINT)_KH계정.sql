/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    Ʈ������� �����ϴ� ���
    
    * Ʈ�����(TRANSACTION)     -> �۾�����
    - �����ͺ��̽��� ���� �������
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)
    - �������� ��������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
    COMMIT(Ȯ��)�ϱ� �������� ������׵��� �ϳ��� Ʈ��������� ��� ��
    
    
    COMMIT(Ʈ����� ����ó�� �� Ȯ��), ROLLBACK(Ʈ����� ���), SAVEPOINT(�ӽ������� ���)
    
    * Ʈ������� ����
    - COMMIT; ���� : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڴٴ� ���� �ǹ�
                    ���� DB�� �ݿ���Ų �� Ʈ������� �����
    - ROLLBACK; ���� : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ������ �� ������ COMMIT�������� ���ư�
    - SAVEPOINT ����Ʈ��; : ���� �� ������ �ӽ��������� ����ڴ�.
    - ROLLBACK ����Ʈ��; : ��ü ��������� ������ ���� �ƴ϶� �ش� ����Ʈ ���������� Ʈ����Ǹ� �ѹ��ϰڴ�.
    
*/

SELECT * FROM EMP_01;
-- ����� 901�� ��� ����
DELETE FROM EMP_01
 WHERE EMP_ID = 901;

-- ����� 900�� ��� ����
DELETE FROM EMP_01
 WHERE EMP_ID = 900;

ROLLBACK;

--------------------------------------------------------------------------------
-- ����� 200���� ��� ����
DELETE FROM EMP_01
 WHERE EMP_ID = 200;
 
SELECT * FROM EMP_01;

-- ����� 800,, �̸� ȫ�浿, �μ��� �ѹ����� ��� �߰�
INSERT INTO EMP_01
VALUES(800,'ȫ�浿', '�ѹ���');

COMMIT;

SELECT * FROM EMP_01;

ROLLBACK;
--------------------------------------------------------------------------------

-- ����� 217, 216, 214�� ��� ����
DELETE FROM EMP_01
 WHERE EMP_ID IN (217, 216, 214);

-- 3���� ���� ������ ������ SAVEPOINT ����
SAVEPOINT SP1;

DELETE FROM EMP_01
 WHERE EMP_ID = 218;

-- ��� 801, �̸� �踻��, �μ� �λ�� ��� �߰�
INSERT INTO EMP_01
VALUES(801, '�踻��', '�λ��');

-- SP1�� ROLLBACK
ROLLBACK TO SP1;

COMMIT;

SELECT * FROM EMP_01;
--------------------------------------------------------------------------------

-- ����� 900, 901�� ��� ����
DELETE FROM EMP_01
 WHERE EMP_ID IN (900, 901);
       
DELETE FROM EMP_01
 WHERE EMP_ID = 209;
 
-- DDL ���� ��� 
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

SELECT * FROM EMP_01 ORDER BY EMP_ID;

/*
    DDL(CREATE, ALTER, DROP)�� �����ϴ� ����
    ���� Ʈ����ǿ� �ִ� ��� ��������� ������ ���� DB�� �ݿ�(COMMIT)��Ų �Ŀ� DDL�� ����
    => DDL���� �� ������׵��� �ִٸ� ��Ȯ�� Ʈ�����ó��(COMMIT, ROLLBACK)�� �ϰ� DDL�� �����ؾ� ��!!!

*/



















































