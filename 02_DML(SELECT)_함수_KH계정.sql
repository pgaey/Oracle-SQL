/*
    < �Լ� FUNCTION >
    �ڹٷ� ������ �޼ҵ�� ���� ����
    ���޵� ������ �о���� ����� ����� ��ȯ
    
    - ������ �Լ� : N���� ���� �о N���� ����� ��ȯ( �� �ึ�� �Լ� ���� �� ��� ��ȯ )
    - �׷� �Լ��� : N���� ���� �о 1���� ����� ��ȯ( �ϳ��� �׷캰�� �Լ� ���� �� ��� ��ȯ )
    
    ������ �Լ��� �׷��Լ��� �Բ� ����� �� ���� : ��� ���� ������ �ٸ��� ����
*/

----------------------- < ������ �Լ� >------------------------

/*
    < ���ڿ��� ���õ� �Լ� >
    LENGTH() / LENGTHB()    -- B �� ����
    
    - LENGTH(STR)  : �ش� ���޵� ���ڿ��� ���� �� ��ȯ
    - LENGTHB(STR) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ
    
    ������� NUMBERŸ������ ��ȯ
    STR : '���ڿ�' / ���ڿ��� �ش��ϴ� �÷�
    
    ����, ����, Ư������ : '!', '~', 'A', '1' => �� ���ڴ� 1BYTE�� ���
    �ѱ� : '��', '��', '��', ... => �� ���ڴ� 3BYTE�� ���
*/

SELECT
       LENGTH('ORACLE')
      ,LENGTHB('ORACLE')
      ,LENGTH('����Ŭ')
      ,LENGTHB('����Ŭ') AS "LENGTHB"
  FROM DUAL; -- ������ ���̺� (BUMMY TABLE)

SELECT 
       EMAIL
      ,LENGTH(EMAIL)
      ,LENGTHB(EMAIL)
      ,EMP_NAME
      ,LENGTH(EMP_NAME)
      ,LENGTHB(EMP_NAME)
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------
/*
    INSTR
    
    - INSTR(STR) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    
    INSTR(STR, 'Ư�� ����', ã�� ��ġ�� ���� ��, ����)
    
    ������� NUMBERŸ������ ��ȯ
    ã�� ��ġ�� ���۰�, ������ ���� ����
    
    ã�� ��ġ�� ���۰�
    1  : �տ������� ã�ڴ�. (���� �� �⺻��)
    -1 : �ڿ������� ã�ڴ�.
*/

SELECT
       INSTR('AABAACAABBAA', 'B')
  FROM
       DUAL; -- ã�� ��ġ, ���� ���� �� �⺻������ �տ������� ù ��° ������ ��ġ �˻�

SELECT
       INSTR('AABAACAABBAA', 'B', 1)
  FROM
       DUAL; -- �ش� ���ڿ��� �տ������� ù ��°�� B�� ���°�� �������� ��� : 3��° ��ġ

SELECT
       INSTR('AABAACAABBAA', 'B', -1)
  FROM
       DUAL; -- �ش� ���ڿ��� �ڿ������� ù ��°�� B�� ���°�� �������� ��� : 10��° ��ġ

SELECT
       INSTR('AABAACAABBAA', 'B', 1, 2)
  FROM
       DUAL; -- �ش� ���ڿ��� �տ������� �� ��°�� ��ġ�� B�� ���°�� �������� ��� : 9��° ��ġ
  
SELECT
       INSTR('AABAACAABBAA', 'B', -1, 2)
  FROM
       DUAL; -- �ش� ���ڿ��� �ڿ������� �� ��°�� ��ġ�� B�� ����翡 �������� ��� : 9��° ��ġ

-- EMAIL���� @�� ��ġ�� ã���ּ���!
SELECT
       EMAIL, INSTR(EMAIL, '@') AS "@�� ��ġ"
  FROM
       EMPLOYEE;

-------------------------------------------------------------------------------
/*
    SUBSTR
    
    - SUB(STR, POSITION, LENGTH) : ���ڿ��κ��� Ư�� ���ڿ��� �����ؼ� ��ȯ
                                    (�ڹٷ� ������ ���ڿ�.substring() �޼ҵ�� ����)
                                    
    ������� CHARACTERŸ������ ��ȯ
    LENGTH�� ���� ����
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
    - POSITION : ���ڿ��� ������ ���� ��ġ��(������ ���ð���) POSITION��° ���ں��� ����
    - LENGTH : ������ ���� ����(���� �� ������ �ǹ�)
    
*/

SELECT 
       SUBSTR('�ƹ����ڿ��̳���������ϴ�', 8)  -- RESULT SET : ��������ϴ�
  FROM
       DUAL;

SELECT
       SUBSTR('�ƹ����ڿ��̳���������ϴ�', 10, 4)
  FROM
       DUAL;

SELECT 
       SUBSTR('�ƹ����ڿ��̳���������ϴ�', -6, 2)
  FROM
       DUAL;   -- ������ġ�� ������ ��� �ڿ������� N��° ��ġ�κ��� ���ڸ� �����ϰڴ� ��� ��

SELECT
       *
  FROM
       EMPLOYEE;

-- �ֹι�ȣ���� ���� �κ��� �����ؼ� ����(1)/����(2)�� üũ
SELECT
       EMP_NAME 
      ,SUBSTR(EMP_NO, 8, 1) AS "����"
  FROM
       EMPLOYEE;
       
-- ���� ������� ������ �޿��� ��ȸ
SELECT
       EMP_NAME, SALARY
  FROM
       EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
 WHERE
       SUBSTR(EMP_NO,8, 1) IN ('2', '4');
    
-- �̸��Ͽ��� ID�κи� ����, �̸�, �̸���
SELECT
       EMP_NAME
      ,EMAIL
      ,SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) "ID"
  FROM
       EMPLOYEE;
       
-------------------------------------------------------------------------------
/*
    LPAD / RPAD
    
    - LPAD/RPAD(STR, ���������� ��ȯ�� ������ ����(����Ʈ), �����̰����ϴ� ����)
    : ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N��ŭ�� ���ڿ��� ��ȯ
    
    ������� CHARACTER Ÿ������ ��ȯ
    �����̰����ϴ� ���ڴ� ������ ����
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
*/

SELECT
       LPAD(EMAIL, 20)
  FROM
       EMPLOYEE;

SELECT
       RPAD(EMAIL, 20, '#')
  FROM
       EMPLOYEE;
       
-- 660101-3****** => �� ���ڼ� 14 ����
SELECT
       RPAD('660101-3', 14, '*')
  FROM
       DUAL;

-- ��� ������ �ֹε�Ϲ�ȣ �� 6�ڸ��� ����ŷó�� ��ó�� �ؼ� ǥ���غ���
-- 1�ܰ�. SUBSTR�� �̿��ؼ� �ֹε�Ϲ�ȣ �� 8�ڸ��� ����
SELECT
       EMP_NAME
      ,RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "�ֹι�ȣ"
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------
/*
    LTRIM / RTRIM

    - LTRIM / RTRIM(STR, ���Ž�Ű���� �ϴ� ����)
    : ���ڿ��� ���� �Ǵ� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
    
    ������� CHARACTERŸ������ ��ȯ
    �����ϰ����ϴ� ���ڸ� ���� ����
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
*/

SELECT
       LTRIM('         ��    ��')
  FROM
       DUAL;

SELECT
       LTRIM('00012300456000', '0')
  FROM
       DUAL;
        
SELECT
       LTRIM('123123KH123', '123')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    TRIM
    
    - TRIM(BOTH/LEADING/TRAILING '���Ž�Ű�� ���� ����' FROM STR)
    : ���ڿ��� ��/��/���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
    
    ������� CHARACTERŸ������ ��ȯ
    BOTH, LEADING, TRAILING�� ��������/ ������ �⺻���� BOTH�� ����
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
*/

-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT
       TRIM('    ��  ��    ')
  FROM
       DUAL;
       
SELECT
       TRIM('��' FROM '�����������󤻤���')
  FROM
       DUAL;    -- BOTH : ����(���� �� �⺻��)
       
SELECT
       TRIM(LEADING '��' FROM '���������󤻤���')
  FROM
       DUAL;
       
SELECT
       TRIM(TRAILING '��' FROM '�������������󤻤���')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    LOWER/UPPER/INITCAP
    
    - LOWER(STR)
    : �� �ҹ��ڷ� ����
    
    - UPPER(STR)
    : �� �빮�ڷ� ����
    
    - INITCAP(STR)
    : �� �ܾ� �ձ��ڸ� �빮�ڷ� ����
    
    ������� CHARACTER Ÿ������ ��ȯ
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
*/

SELECT
       LOWER('HELLO WORLD!')
  FROM
       DUAL;
       
SELECT
       UPPER('hello world!')
  FROM
       DUAL;
       
SELECT
       INITCAP('hello world!')
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    CONCAT
    
    - CONCAT(STR1, STR2)
    : ���޵� �� ���� ���ڿ��� �ϳ��� ��ģ ����� ��ȯ
    
    ������� CHARACTERŸ������ ��ȯ
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
*/

SELECT
       CONCAT('����', '������')
  FROM
       DUAL;

SELECT 
       '����' || 'r����'
  FROM
       DUAL;

--------------------------------------------------------------------------------
/*
    REPLACE
    
    - REPLACE(STR, ã�� ����, �ٲ� ����)
    : STR�κ��� ã�� ���ڸ� ã�Ƽ� �ٲܹ��ڷ� �ٲ� ���ڿ��� ��ȯ
    
    ������� CHARACTER Ÿ������ ��ȯ
    
    - STR : '���ڿ�' �Ǵ� ���� Ÿ�� �÷�
*/

SELECT
       REPLACE('����� �߱� ���빮��', '���빮��', '***��')
  FROM
       DUAL;
       
SELECT
       REPLACE(EMAIL, 'kh.or.kr', 'ioi.or.kr')
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------
/*
    < ���ڿ� ���õ� �Լ� >
    
    ABS
    - ABS(NUMBER) : ���밪 �����ִ� �Լ�
*/

SELECT 
       ABS(-10)
  FROM
       DUAL;

SELECT 
       ABS(-10.8)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    MOD
    
    - MOD(NUMBER1, NUMBER2) : �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
    
*/

SELECT
       MOD(10, 3)
  FROM
       DUAL;
       
SELECT
       MOD(10.9, 3)
  FROM 
       DUAL;
--------------------------------------------------------------------------------

/*
    ROUND(NUMBER, ��ġ) : �ݿø� ó�����ִ� �Լ�
    
    ��ġ : �Ҽ��� �Ʒ� N��° ������ �ݿø�
    ���� ����, ���� �� �⺻���� 0 = �Ҽ����� ����
*/

SELECT
       ROUND(123.456)
  FROM
       DUAL; -- 123
       
SELECT
       ROUND(123.456, 1)
  FROM
       DUAL; -- 123.5

SELECT
       ROUND(123.456, 2)
  FROM
       DUAL; -- 123.46
       
SELECT
       ROUND(123.456, 3)
  FROM
       DUAL; -- 123.456
       

SELECT  
       ROUND(123.456, -1)
  FROM
       DUAL;
       
SELECT
       ROUND(123.456, -2)
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    CEIL
    - CEIL(NUMBER) : �Ҽ��� �Ʒ��� ���� ������ �ø� ó�����ִ� �Լ�
*/

SELECT
       CEIL(123.456)
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    FLOOR
    
    - FLOOR(NUMBER) : �Ҽ��� �Ʒ��� ���� ������ ���� ó�����ִ� �Լ�
*/

SELECT
       FLOOR(123.999)
  FROM
       DUAL;

-- �� �������� ����Ϸκ��� ���ñ��� �ٹ��ϼ� ��ȸ

SELECT
       EMP_NAME
      ,CONCAT(FLOOR(SYSDATE - HIRE_DATE), '��')  AS "�ٹ��ϼ�"
  FROM
       EMPLOYEE;

-------------------------------------------------------------------------------

/*
    TRUNC
    
    - TRUNC(NUMBER, ��ġ) : ��ġ�� ���������� ����ó�����ִ� �Լ�
    
    - ��ġ�� ���� ����, �� ���� �� �⺻���� 0
*/
       
SELECT
       TRUNC(123.456)
  FROM
       DUAL;
       
SELECT
       TRUNC(123.456, 2)
  FROM  
       DUAL;

--------------------------------------------------------------------------------

/*
    < ��¥ ���� �Լ� >
    
    DATE Ÿ�� : ��, ��, ��, ��, ��, �ʸ� �� ������ �ڷ���
*/

-- SYSDATE : ���� �ý��� ��¥ ��ȯ
SELECT
       SYSDATE
  FROM
       DUAL;

-- MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� ��ȯ(NUMBERŸ�� ��ȯ, DATE2�� �� �� �̷��� ��� ������ ���� �� �ִ�.)
-- �� �������� ����Ϸκ��� ���ñ��� �ٹ��ϼ��� �ٹ������� ��ȸ
SELECT
       EMP_NAME
      ,FLOOR(SYSDATE - HIRE_DATE) || '��' "�ٹ��ϼ�"
      ,FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
  FROM
       EMPLOYEE;

-- ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥ ��ȯ(DATEŸ�� ��ȯ)
SELECT
       ADD_MONTHS(SYSDATE, 4)   -- ���� ��¥�κ��� 4���� ��
  FROM
       DUAL;

-- ��ü ������� ������, �Ի���, �Ի� �� 3������ �귶�� ���� ��¥ ��ȸ
SELECT
       EMP_NAME "�̸�"
      ,HIRE_DATE AS "�Ի���"
      ,ADD_MONTHS(HIRE_DATE, 3) AS "�Ի� �� 3����"
  FROM
       EMPLOYEE;

-- NEXT_DAY(DATE, ����(����/����)) : Ư�� ��¥���� ���� ����� �ش� ���� ã�� �� ��¥ ��ȯ
SELECT
       NEXT_DAY(SYSDATE, '�Ͽ���')
  FROM 
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, '��')
  FROM
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, 1) -- 1: �Ͽ��� 2: ������ 3:ȭ���� .... 7: �����
  FROM
       DUAL;
       
-- ���� �� KOREAN�̱� ������ ������ ����.
SELECT
       NEXT_DAY(SYSDATE, 'SUNDAY')
  FROM
      DUAL;

-- ��� ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY(DATE) : �ش� Ư�� ��¥ ���� ������ ��¥�� ���ؼ� ��ȯ(DATE Ÿ�� ��ȯ)
SELECT
       LAST_DAY(SYSDATE)
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    EXTRACT : �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� ��ȯ(NUMBERŸ�� ��ȯ)
    
    - EXTRACT(YEAR FROM DATE) : Ư�� ��¥�κ��� �⵵�� ����
    - EXTRACT(MONTH FROM DATE): Ư�� ��¥�κ��� ���� ����
    - EXTRACT(DAY FROM DATE) :  Ư�� ��¥�κ��� �ϸ� ����
*/

-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT
       EMP_NAME
      ,EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵"
      ,EXTRACT(MONTH FROM HIRE_DATE) "�Ի��"
      ,EXTRACT(DAY FROM HIRE_DATE) "�Ի���"
  FROM
       EMPLOYEE
 ORDER
    BY
       "�Ի�⵵", "�Ի��";

--------------------------------------------------------------------------------

/*
    < ����ȯ �Լ� >
    
    NUMBER/DATE => CHARACTER
    
    - TO_CHAR(NUMBER/DATE, ����) : ������ �Ǵ� ��¥�� �����͸� ������ Ÿ������ ��ȯ(CHARACTER Ÿ�� ��ȯ)
*/

SELECT 
       TO_CHAR(1234)
  FROM
       DUAL;
       
SELECT
       TO_CHAR(1234, '0000000')
  FROM
       DUAL;  -- 1234�� => '0001234' : ��ĭ�� 0���� ä��
       
SELECT
       TO_CHAR(1234, '999999')
  FROM
       DUAL; -- '1234' : ��ĭ�� �������� ä��
       
SELECT
       TO_CHAR(1234, 'L00000')
  FROM
       DUAL;  -- '��01234' : ���� ������ ����(LOCAL)�� ȭ�����
       
SELECT
       TO_CHAR(1234, 'L999999999')
  FROM
       DUAL; -- '��1234' : ���� ������ ���� (LOCAL)�� ȭ�����
       
SELECT
       TO_CHAR(123456789,'9,999,999,999')
  FROM  
       DUAL;
       
-- �޿������� 3�ڸ����� ,�� �����Ͽ� ���
SELECT  
       EMP_NAME
      ,TO_CHAR(SALARY, 'L999,999,999') AS "�޿�����"
  FROM
       EMPLOYEE;

-- DATE(����Ͻú���) => CHARACTER
SELECT
       TO_CHAR(SYSDATE)
  FROM
       DUAL;

SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
  FROM
       DUAL;
       
SELECT
       TO_CHAR(SYSDATE, 'PM HH:MI:SS')
  FROM
       DUAL;
       
SELECT  
       TO_CHAR(SYSDATE, 'HH24:MI:SS')
  FROM
       DUAL;
       
SELECT
       TO_CHAR(SYSDATE, 'MON DY, YYYY')
  FROM
       DUAL;

-- �⵵�ν� �� �� �ִ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY')
      ,TO_CHAR(SYSDATE, 'RRRR')
      ,TO_CHAR(SYSDATE, 'YY')
      ,TO_CHAR(SYSDATE, 'RR')
      ,TO_CHAR(SYSDATE, 'YEAR')
  FROM
       DUAL;  

-- ���ν� �� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'MM')
      ,TO_CHAR(SYSDATE, 'MON')
      ,TO_CHAR(SYSDATE, 'MONTH')
      ,TO_CHAR(SYSDATE, 'RM')
  FROM
       DUAL;
       
-- �Ϸν� �� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'D') -- 1���� ����(�Ͽ��Ϻ��� �����ؼ� ���°��)
      ,TO_CHAR(SYSDATE, 'DD') -- 1�� ����(1�Ϻ��� �����ؼ� ��ĥ°��)
      ,TO_CHAR(SYSDATE, 'DDD') -- 1�� �������� ��ĥ�̳� ������
  FROM
       DUAL;

-- ���Ϸν� �� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'DY')
      ,TO_CHAR(SYSDATE, 'DAY')
  FROM
       DUAL;

-- 2023�� 02�� 24�� (��) �������� ���
SELECT
       TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" (DY)') "���ó�¥"
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    CHARACTER => NUMBER
    
    - TO_NUMBER(CHARACTER, ����) : �����������͸� ���������� ��ȯ(NUMBERŸ�� ��ȯ)
*/

SELECT
       '123' + '123'
  FROM
       DUAL; -- �ڵ�����ȯ �� ���������� ����

SELECT
       '10,000,000' + '550,000'
  FROM
       DUAL;
       
SELECT
       TO_NUMBER('10,000,000', '99,999,999') +  TO_NUMBER('550,000', '99,999,999')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
    < NULL ó�� �Լ� >
    
*/

-- NVL(�÷���, �ش� �÷����� NULL�� ��� ��ȯ�� �����)
-- �ش� �÷��� ���� ������ ��� ������ �÷��� ��ȯ, �ش� �÷��� NULL���� ������� ��� ���� ������ Ư������ ��ȯ

-- �����, ���ʽ�, ���ʽ��� ���� ��� 0���� ��ȸ
SELECT
       EMP_NAME
      ,BONUS
      ,NVL(BONUS, 0) -- ���� ���� ������ ��ü
  FROM
       EMPLOYEE;

-- ���ʽ� ���� ���� ��ȸ
SELECT
       EMP_NAME
      ,TO_CHAR((SALARY + SALARY * NVL(BONUS, 0)) * 12, '999,999,999,999' )AS "����"
  FROM
       EMPLOYEE;
       
-- �����, �μ��ڵ�(�μ��ڵ尡 ���� ��� '����')
SELECT
       EMP_NAME
      ,NVL(DEPT_CODE, '����')
  FROM
       EMPLOYEE;
       
-- NVL2(�÷���, �����1, �����2)
-- �ش� �÷��� ���� �����Ұ�� �����1 ��ȯ
-- �ش� �÷��� ���� NULL�� ��� �����2 ��ȯ

SELECT
       EMP_NAME
      ,BONUS
      ,NVL2(BONUS, 0.5, 0)
  FROM
       EMPLOYEE;

SELECT
       EMP_NAME
      ,NVL2(DEPT_CODE, '�μ���ġ�Ϸ�', '�μ�����')
  FROM
       EMPLOYEE;
       
-- NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� ������ ��� NULL��ȯ
-- �� ���� ���� �������� ���� ��� �񱳴��1 ��ȯ 

SELECT
       NULLIF('123', '123')
  FROM
       DUAL;
       
SELECT
       NULLIF('123', '456')
  FROM
       DUAL;

--------------------------------------------------------------------------------

/*
    < ���� �Լ� >
    
    DECODE(�񱳴��(�÷���/�������/�Լ�) ���ǰ�1, �����1, ���ǰ�2, �����2, ....,  �����)
    
    - �ڹٿ����� switch���� ����
*/

-- ���, �����, �ֹε�Ϲ�ȣ�κ��� ���� �ڸ� ����
SELECT 
       EMP_NO
      ,EMP_NAME
      ,DECODE(
               SUBSTR(EMP_NO, 8, 1),
               1, '��', 
               2, '��'
               ) "����"
  FROM
       EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ����� �޿��� 10% �λ��ؼ� ��ȸ
-- �����ڵ尡 'J6'�� ����� �޿��� 15% �λ��ؼ� ��ȸ
-- �����ڵ尡 'J5'�� ����� �޿��� 20% �λ��ؼ� ��ȸ
-- �����, �����ڵ�, �λ��� �޿�, �λ��� �޿�
SELECT
       EMP_NAME
      ,DEPT_CODE
      ,SALARY
      ,DECODE(JOB_CODE,
      'J7', (SALARY + (SALARY)*0.1),
      'J6', (SALARY + (SALARY)*0.15),
      'J5', (SALARY + (SALARY)*0.2),
      (SALARY + (SALARY)*0.05)) AS "�λ� �� �޿�"
/*default ���� �׳� ����ָ� �ȴ�
 'J7', ...
 'J6', ... 
 'J5', ...
  ����, ... 
*/
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
    CASE WHEN THEN ����
    
    - DECODE�� ���ϸ� DECODE�� ���ǰ˻� �� ����񱳸��� ����
      CASE WHEN THEN �������� Ư�� ���� ���ý� "���������" ���ǽ� �������
      
    - �ڹٿ����� IF - ELSE IF�� ���� ����
    
    [ ǥ���� ]
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����
    END
*/

-- ���, �����, �ֹι�ȣ�κ��� �����ڸ� ���� : DECODE �Լ�
SELECT
       EMP_ID
      ,EMP_NAME
      ,DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') AS "����"
  FROM
       EMPLOYEE;
       
SELECT
       EMP_ID
      ,EMP_NAME
      ,CASE
            WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '��'
            ELSE '��'
       END "����"
  FROM
       EMPLOYEE;
       
-- �����, �޿�, �޿����("����", "�߰�", "����")
-- SALARY���� 500���� �ʰ��� ��� "����"
-- 500���� ���� 350���� �ʰ��� ��� "�߰�"
-- 350���� ������ ��� "����
SELECT
       EMP_NAME
      ,SALARY
      ,CASE
            WHEN SALARY > 5000000 THEN '����'
            WHEN 3500000 < SALARY AND SALARY <= 5000000 THEN '�߰�'
            ELSE '����'
       END "�޿����"
  FROM
       EMPLOYEE;

---------------------------------< �׷� �Լ� >-----------------------------------
/*
    N���� ���� �о 1���� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ���� ��� ��ȯ)
*/























