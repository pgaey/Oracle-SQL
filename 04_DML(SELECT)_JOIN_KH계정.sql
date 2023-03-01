/*
    < JOIN >
    
    �� �� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ����ϴ� ����
    ��ȸ ����� �ϳ��� RESULT SET���� ��
    
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����(�̻����, �ߺ��� �ּ�ȭ�ϱ� ���ؼ�)
    => JOIN������ �̿��ؼ� �������� ���̺� �� "����"�� �ξ ���� ��ȸ�ؾ� ��
    => ��, ������ JOIN�� �̿��ؼ� ��ȸ�ϴ� ���� �ƴ϶�
        ���̺� ���� "�����"�� �ش��ϴ� �÷��� ��Ī���Ѽ� ��ȸ�ؾ� ��
        
    JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI(�̱����� ǥ����ȸ)����"���� ������.
            ����Ŭ ���뱸��        |       ANSI(����Ŭ + �ٸ� DBMS) ����
    =================================================================
            �����              |     �������� (INNER JOIN) -> JOIN USING/ON
            (EQUAL JOIN)         |     �ܺ����� (OUTER JOIN) -> JOIN USING
    -----------------------------------------------------------------
            ��������              |     ���� �ܺ����� (LEFT OUTER JOIN)
            (LEFT OUTER)         |     ������ �ܺ����� (RIGHT OUTER JOIN)
            (RIGHT OUTER)        |     ��ü �ܺ����� (FULL OUTER JOIN) => ����Ŭ������ �Ұ�
    -----------------------------------------------------------------
            ī�׽þ� ��            |     ��������
           (CARTESIAN PRODUCT)   |     (CROSS JOIN)
    -----------------------------------------------------------------
            ��ü����(SELF JOIN)
            ������(NON EQUAL JOIN)
*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ������ ��ȸ
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
  FROM
       EMPLOYEE;

SELECT         
       DEPT_ID
      ,DEPT_TITLE
  FROM
       DEPARTMENT;
       
-- ��ü ������� ���, �����, �����ڵ�, ���޸���� ��ȸ
SELECT
       EMP_ID
      ,EMP_NAME
      ,JOB_CODE
  FROM
       EMPLOYEE;
       
--> JOIN�� ���ؼ� ������� �ش��ϴ� �÷��� ��Ī��Ų�ٸ� ��ġ �ϳ��� ������� ��ó�� ��ȸ ����
--------------------------------------------------------------------------------
/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εż� ��ȸ( == ��ġ�����ʴ� ������ ��ȸ�ؼ� ����)    
*/

--> ����Ŭ ���� ����
-- FROM���� ��ȸ�ϰ����ϴ� ���̺���� ����(,��)
-- WHERE ���� ��Ī��ų �÷���(�����)�� ���� ������ ������

-- ��ü ������� ���, �����, �μ��ڵ�, �μ��� ���� ��ȸ
-- 1) ������ �� �÷����� �ٸ� ���(EMPLOYEE - "DEPT_CODE" / DEPARTMENT - "DEPT_ID")
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,DEPT_TITLE
  FROM
       EMPLOYEE
      ,DEPARTMENT
 WHERE  
       DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� ���� ��ȸ���� ���ܵ� ���� Ȯ�� ����
-- DEPT_CODE�� NULL���̾��� 2���� ��������ʹ� ��ȸ�� �ȵ�, DEPT_ID�� D3, D4, D7�� �μ������ʹ� ��ȸX

-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ���(EMPLOYEE - "JOB_CODE" / JOB - "JOB_CODE")
/*
SELECT
       EMP_ID
      ,EMP_NAME
      ,JOB_CODE
      ,JOB_NAME
  FROM
       EMPLOYEE
      ,JOB
 WHERE JOB_CODE = JOB_CODE;
*/
 -- ambiguously : �ָ��ϴ�, ��ȣ�ϴ� => Ȯ���ϰ� � ���̺��� �÷������� �� ����������

-- ��� 1. ���̺���� �̿��ϴ� ���
SELECT
       EMP_ID
      ,EMP_NAME
      ,EMPLOYEE.JOB_CODE
      ,JOB.JOB_CODE
      ,JOB_NAME
  FROM
       EMPLOYEE
      ,JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ��� 2. ���̺��� ��Ī ��� ( �� ���̺��� ��Ī �ο� ���� )
SELECT                                  -- 3��
       EMP_ID
      ,EMP_NAME
      ,E.JOB_CODE
--      ,J.JOB_CODE
      ,JOB_NAME
  FROM                                  -- 1��
       EMPLOYEE "E"
      ,JOB "J"
 WHERE                                  -- 2��
       E.JOB_CODE = J.JOB_CODE;       

-->> ANSI ����
-- FROM ���� ���� ���̺��� �ϳ� ��� �� �� 
-- �� �ڿ� JOIN������ ���� ��ȸ�ϰ����ϴ� ���̺� ���( ��Ī��ų �÷��� ���� ���ǵ� ���� ���)
-- USING / ON ����

-- ���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE - "DEPT_CODE" / DEPARTMENT - "DEPT_ID" )
-- ������ ON������ ���� (USING���� ���Ұ��� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX)
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,DEPT_TITLE
  FROM
       EMPLOYEE
 /*INNER*/ JOIN                                  -- INNER ���� ����
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ���( EMPLOYEE - "JOB_CODE" / JOB - "JOB_CODE")
-- ON, USING
-- 2_1) ON���� �̿� : AMBIGUOUSLY�� �߻��� �� ������ Ȯ���� ����ؾ���!!
SELECT
       EMP_ID
      ,EMP_NAME
      ,E.JOB_CODE
      ,JOB_NAME
  FROM
       EMPLOYEE E
  JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
  
-- 2_2) USING���� �̿� : AMBIGUOUSLY �߻� X, ������ �÷��� �ϳ��� ���ָ� �˾Ƽ� ��Ī������
SELECT
       EMP_ID
      ,EMP_NAME
      ,JOB_CODE
      ,JOB_NAME
  FROM
       EMPLOYEE
  JOIN JOB USING(JOB_CODE);
  
  
-- NATURAL JOIN (�ڿ�����)
SELECT
       EMP_ID
      ,EMP_NAME
      ,JOB_CODE
      ,JOB_NAME
  FROM
       EMPLOYEE
NATURAL JOIN JOB;
-- �ΰ��� ���̺� ������ ����, �� ���Ե� �� ���� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �� �� �����Ѵ�!!(JOB_CODE)=> ��Ī�� �˾Ƽ� ����

-- �߰����� ������ ���� ���� 
-- ������ �븮�� ������� ���� ��ȸ

-- > ����Ŭ ���� ����
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       JOB_NAME
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       JOB_NAME = '�븮';
       
       
-- > ANSI ����
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       JOB_NAME = '�븮';


------------------------------ �ǽ� ���� ------------------------------
-- 1. �μ��� '�λ������'�� ������� ���, �����, ���ʽ��� ��ȸ
-- ����Ŭ
SELECT 
       EMP_ID,
       EMP_NAME,
       BONUS
  FROM
       EMPLOYEE E,
       DEPARTMENT D
 WHERE
       E.DEPT_CODE = D.DEPT_ID
   AND    
       D.DEPT_TITLE = '�λ������';

-- ANSI
SELECT
       EMP_ID,
       EMP_NAME,
       BONUS
  FROM
       EMPLOYEE E
  JOIN
       DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
 WHERE
       DEPT_TITLE = '�λ������';


-- 2. �μ��� '�ѹ���'�� �ƴ� ������� �����, �޿�, �Ի����� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME,
       SALARY,
       HIRE_DATE
  FROM
       EMPLOYEE E,
       DEPARTMENT D
 WHERE
       D.DEPT_ID = E.DEPT_CODE
   AND
       NOT D.DEPT_TITLE = '�ѹ���';


-- ANSI
SELECT
       EMP_NAME,
       SALARY,
       HIRE_DATE
  FROM
       EMPLOYEE E
  JOIN
       DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
 WHERE 
       NOT D.DEPT_TITLE = '�ѹ���';


-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-- ����Ŭ
SELECT
       EMP_ID,
       EMP_NAME,
       BONUS,
       DEPT_TITLE
  FROM
       EMPLOYEE E,
       DEPARTMENT D
 WHERE
       E.DEPT_CODE = D.DEPT_ID
   AND
       E.BONUS IS NOT NULL;
       

-- ANSI
SELECT
       EMP_ID,
       EMP_NAME,
       BONUS,
       DEPT_TITLE
  FROM
       EMPLOYEE E
  JOIN
       DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
 WHERE
       BONUS IS NOT NULL;

-- 4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME) ��ȸ
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
-- ����Ŭ
SELECT
       DEPT_ID,
       DEPT_TITLE,
       LOCATION_ID,
       LOCAL_NAME
  FROM
       DEPARTMENT,
       LOCATION
 WHERE
       LOCAL_CODE = LOCATION_ID;

-- ANSI
SELECT
       DEPT_ID,
       DEPT_TITLE,
       LOCATION_ID,
       LOCAL_NAME
  FROM  
       LOCATION
  JOIN
       DEPARTMENT ON (LOCAL_CODE = LOCATION_ID);
       
-- ����� / �������� : ��ġ���� �ʴ� ����� ���ʿ� ��ȸ���� ����
       
--------------------------------------------------------------------------------

/*
    2. �������� / �ܺ����� ( OUTER JOIN )
    
    ���̺� ���� JOIN�� ��ġ���� �ʴ� �ൿ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT�� �����ؾ��� (������ �Ǵ� ���̺��� �����ؾ���)
*/

-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
SELECT
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL�� �� ���� ����� ��ȸ X
-- �μ��� ������ ����� ���� �μ�(D3, D4, D7)���� ��� ��ȸ X

-- 1) LEFT [ OUTER ] JOIN : �� ���̺� �߿� ���� ����� ���̺��� �������� JOIN
--                          ���� �Ǿ��� ���� ���� ����� ���̺��� �����ʹ� ������ ��ȸ�ǰ� �Ѵ�.(��ġ���� �ʴ���)
--> ANSI����
SELECT
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE
  LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--> EMPLOYEE ���̺��� �������� ��ȸ�߱� ������ EMPLOYEE�� �����ϴ� �����ʹ� ���� �Ǿ��� ���� ��ȸ�ǰԲ� �Ѵ�.  

--> ����Ŭ ���� ����
SELECT
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID(+);
--> ���� �������� ���� ���̺��� �÷����� �ƴ� �ݴ� ���̺��� �÷��� (+)�� �ٿ��ش�.

-- 2) RIGHT [ OUTER ] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
--                           ���� �Ǿ��� ���� ������ ����� �����ʹ� ������ ��ȸ�ǰ� �Ѵ�.
--> ANSI����
SELECT
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE
 RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
 
--> ����Ŭ ���� ����
SELECT
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [ OUTER ] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ����

--> ANSI ����
SELECT 
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE
  FULL OUTER JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE);
  
--> ����Ŭ ���� ( ����Ŭ ���������� ��� �Ұ� )
SELECT
       EMP_NAME,
       SALARY,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT
 WHERE
       DEPT_CODE(+) = DEPT_ID(+);
--------------------------------------------------------------------------------

/*
    �� ���� �ȵǴ� ���� ��
    3. ī�׽þ� ��(CARTESIAN PRODUCT) / ��������(CROSS JOIN)
    ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ��(������)
    
    
    �� ���̺��� ����� ��� ������ ����� ���� ��� => ����� ������ ��� => �������� ����
    �� ���� �ȵǴ� ���� ��
*/

-- �����, �μ���
--> ����Ŭ ���뱸��
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT; --> 23 * 9 => 207�� �� ��ȸ
       
--> ANSI����
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
 CROSS JOIN DEPARTMENT;
--------------------------------------------------------------------------------
/*
    4. �� ���� (NON EQUAL JOIN)
    '=' ��ȣ�� ������� �ʴ� ���ι�
*/
-- �����, �޿�
SELECT
       EMP_NAME,
       SALARY
  FROM 
       EMPLOYEE;
       
SELECT
       *
  FROM
       SAL_GRADE;
       
-- �����, �޿�, �޿����(SAL_LEVEL)
-- ����Ŭ ����
SELECT
       EMP_NAME,
       SALARY,
       S.SAL_LEVEL
  FROM
       EMPLOYEE E,
       SAL_GRADE S
 WHERE
       MIN_SAL <= SALARY AND SALARY <= MAX_SAL;

-- ANSI����(ON����)
SELECT
       EMP_NAME,
       SALARY,
       S.SAL_LEVEL
  FROM  
       EMPLOYEE E
  JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL );
--  JOIN SAL_GRADE S ON (MIN_SAL <= SALARY AND SALARY <= MAX_SAL);

--------------------------------------------------------------------------------

/*
    5. ��ü ����(SELF JOIN) �� ���� �� ��
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    �ڱ� �ڽ��� ���̺�� �ٽ� ������ �δ� ��� 
*/

SELECT
       EMP_ID "��� ���",
       EMP_NAME "�����",
       SALARY "��� �޿�",
       MANAGER_ID "��� ���"
  FROM
       EMPLOYEE;

SELECT * FROM EMPLOYEE; -- ����� ���� ���� ����� ���̺� MANAGER_ID
SELECT * FROM EMPLOYEE; -- ����� ���� ���� ����� ���̺� EMP_ID --> �����, ����޿�

-- ��� ���, �����, ��� �μ��ڵ�, ��� �޿�
-- ��� ���, �����, ��� �μ��ڵ�, ��� �޿�
--> ����Ŭ ���� ����
SELECT
       E.EMP_ID "��� ���",
       E.EMP_NAME "�����",
       E.DEPT_CODE "��� �μ��ڵ�",
       E.SALARY "��� �޿�",
       
       M.EMP_ID "��� ���",
       M.EMP_NAME "�����",
       M.DEPT_CODE "��� �μ��ڵ�",
       M.SALARY "��� �޿�"
  FROM
       EMPLOYEE E,
       EMPLOYEE M
 WHERE
       E.MANAGER_ID = M.EMP_ID(+);
       
--> ANSI
SELECT
       E.EMP_ID "��� ���",
       E.EMP_NAME "�����",
       D1.DEPT_TITLE "��� �μ���",
       E.SALARY "��� �޿�",
       
       M.EMP_ID "��� ���",
       M.EMP_NAME "�����",
       D2.DEPT_TITLE "��� �μ���",
       M.SALARY "��� �޿�"
  FROM
       EMPLOYEE E
  LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
       JOIN DEPARTMENT D1 ON (E.DEPT_CODE = D1.DEPT_ID)
       JOIN DEPARTMENT D2 ON (M.DEPT_CODE = D2.DEPT_ID);

--------------------------------------------------------------------------------
/*
    < ���� JOIN >         � �÷��� ������ ���̺��� �������� �����ؾ���
*/

-- ���, �����, �μ���, ���޸�, ������(LOCAL_NAME)
SELECT * FROM EMPLOYEE;     -- DEPT_CODE    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID                  LOCATION_ID
SELECT * FROM JOB;          --              JOB_CODE
SELECT * FROM LOCATION;     --                          LOCAL_CODE                           


--> ����Ŭ ���뱸��
SELECT
       EMP_ID "���",
       EMP_NAME "�����",
       DEPT_TITLE "�μ���",
       JOB_NAME "���޸�",
       LOCAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E,
       DEPARTMENT D,
       JOB J,
       LOCATION L
 WHERE
       DEPT_CODE = DEPT_ID(+)
   AND LOCATION_ID = LOCAL_CODE(+)
   AND E.JOB_CODE = J.JOB_CODE(+);

--> ANSI ����                         �� �������� : LOCATION�� DEPARTMENT ���� JOIN�� �ȉ� 
SELECT                               
       EMP_ID "���",
       EMP_NAME "�����",
       DEPT_TITLE "�μ���",
       JOB_NAME "���޸�",
       LOCAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E
  LEFT JOIN JOB USING (JOB_CODE)
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  LEFT JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID);
--> ���� JOIN�� ���� ���� �߿�(LOCATION ���̺��� DEPARTMENT���� ���� ���εǸ� ����)

-- �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����
SELECT * FROM EMPLOYEE;     -- EMP_NAME          DEPT_CODE   JOB_CODE                                SAL_LEVEL
SELECT * FROM DEPARTMENT;   -- DEPT_TITLE        DEPT_ID                 LOCAL_CODE
SELECT * FROM JOB;          -- JOB_NAME                      JOB_CODE    
SELECT * FROM LOCATION;     -- LOCAL_NAME                                LOCAL_CODE  NATIONAL_CODE
SELECT * FROM NATIONAL;     -- NATIONAL_NAME                                         NATIONAL_CODE
SELECT * FROM SAL_GRADE;    -- SAL_LEVEL                                                             SAL_LEVEL

--> ANSI����
SELECT
       E.EMP_NAME "�����",
       D.DEPT_TITLE "�μ���", 
       J.JOB_NAME "���޸�",
       L.LOCAL_NAME "�ٹ�������",
       N.NATIONAL_NAME "�ٹ�������",
       S.SAL_LEVEL "�޿����"
  FROM
       EMPLOYEE E
  LEFT JOIN JOB J USING(JOB_CODE)
  LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
  LEFT JOIN LOCATION L ON (LOCATION_ID = LOCATION_CODE)
  LEFT JOIN NATIONAL N USING (NATIONAL_CODE)
  LEFT JOIN SAL_GRADE S ON (E.SALARY BETWEEN MIN_SAL AND MAX_SAL);
  
--------------------------------------------------------------------------------
-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� �������� ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-- 2. 70�����̸鼭 �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-- 3. �̸��� '��'�ڰ� ����ִ� �������� ���, �����, ���޸��� ��ȸ�Ͻÿ�
-- 4. �ؿܿ������� �ٹ��ϴ� �������� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-- 5. ���ʽ��� �޴� �������� �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- 6. �μ��� �ִ� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- 7. '�ѱ�' �� '�Ϻ�' �� �ٹ��ϴ� �������� �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7 �� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �� ��, ���п� �ش��ϴ� ����
--    �޿������ S1, S2 �� ��� '���'
--    �޿������ S3, S4 �� ��� '�߱�'
--    �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ� �� ��, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��) �� ��ȸ�Ͻÿ� ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�

-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� �������� ���, �����, ���޸�, �μ���, �ٹ�������, �޿���ȸ
-- ����Ŭ
SELECT
       EMP_ID "���",
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������", 
       SALARY "�޿�"
  FROM
       EMPLOYEE E,
       DEPARTMENT D,
       JOB J,
       LOCATION L
 WHERE
       JOB_NAME = '�븮'
   AND LOCAL_NAME LIKE 'ASIA%'
   AND E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE;             

-- ANSI
SELECT
       EMP_ID,                      
       EMP_NAME,
       JOB_NAME, -- JOB
       DEPT_TITLE, -- DEPARTMENT
       LOCAL_NAME, -- LOCATION
       SALARY
  FROM
       EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION L ON (LOCAL_CODE = LOCATION_ID)
 WHERE
       J.JOB_NAME = '�븮'
   AND
       L.LOCAL_NAME LIKE 'ASIA%';
       
-- 2.70�����̸鼭 �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME,
       EMP_NO,
       DEPT_TITLE,
       JOB_NAME
  FROM
       EMPLOYEE E,
       DEPARTMENT D,
       JOB J
 WHERE
       E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE
   AND SUBSTR(EMP_NO, 8, 1) = '2'
   AND SUBSTR(EMP_NO, 1, 1) = '7'
   AND SUBSTR(EMP_NAME, 1, 1) = '��';
   
-- ANSI
SELECT
       EMP_NAME,
       EMP_NO,
       DEPT_TITLE,
       JOB_NAME
  FROM
       EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB USING(JOB_CODE)
 WHERE
       SUBSTR(EMP_NO, 8, 1) = '2'
   AND SUBSTR(EMP_NO, 1, 1) = '7'
   AND SUBSTR(EMP_NAME, 1, 1) = '��';
   
-- 3. �̸��� '��'�ڰ� ����ִ� �������� ���, �����, ���޸��� ��ȸ
-- ����Ŭ
SELECT
       EMP_ID "���",
       EMP_NAME "�����",
       JOB_NAME "���޸�"
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND EMP_NAME LIKE '%��%';
    
-- ANSI
SELECT
       EMP_ID "���",
       EMP_NAME "�����",
       JOB_NAME "���޸�"
  FROM
       EMPLOYEE E
  JOIN JOB USING (JOB_CODE)
  WHERE
       EMP_NAME LIKE '%��%';
   
-- 4. �ؿܿ������� �ٹ��ϴ� �������� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       DEPT_ID "�μ��ڵ�",
       DEPT_TITLE "�μ���"
  FROM
       EMPLOYEE E,
       DEPARTMENT D,
       JOB J
 WHERE
       E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE
   AND DEPT_TITLE LIKE '%�ؿܿ���%';

-- ANSI
SELECT
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       DEPT_ID "�μ��ڵ�",
       DEPT_TITLE "�μ���"
  FROM
       EMPLOYEE E
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN JOB USING (JOB_CODE)
 WHERE
       DEPT_TITLE LIKE '%�ؿܿ���%';
       
-- 5. ���ʽ��� �޴� �������� �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME "�����",
       BONUS "���ʽ�",
       (SALARY + (SALARY * BONUS)) * 12 AS "����",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E,
       DEPARTMENT D,
       LOCATION L
 WHERE
       E.DEPT_CODE = D.DEPT_ID(+)
   AND D.LOCATION_ID = L.LOCAL_CODE(+)
   AND E.BONUS IS NOT NULL;
   
-- ANSI
SELECT
       EMP_NAME "�����",
       BONUS "���ʽ�",
       (SALARY + (SALARY * BONUS)) * 12 AS "����",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
  LEFT JOIN LOCATION L ON (D.LOCATION_ID = LOCAL_CODE)
 WHERE E.BONUS IS NOT NULL;
    
-- 6. �μ��� �ִ� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E,
       JOB J,
       DEPARTMENT D,
       LOCATION L
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND DEPT_CODE IS NOT NULL;
       
-- ANSI
SELECT
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 WHERE
       DEPT_CODE IS NOT NULL;

-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME "�����",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������",
       NATIONAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E,
       DEPARTMENT D,
       LOCATION L,
       NATIONAL N
 WHERE
       DEPT_CODE = DEPT_ID
   AND LOCATION_ID = LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');
   
-- ANSI
SELECT
       EMP_NAME "�����",
       DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������",
       NATIONAL_NAME "�ٹ�������"
  FROM
       EMPLOYEE E
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE
       NATIONAL_NAME IN ('�ѱ�', '�Ϻ�'); 

-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� �������� �����, ���޸�, �޿��� ��ȸ
-- ����Ŭ
SELECT
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       SALARY "�޿�"
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND BONUS IS NULL
   AND E.JOB_CODE IN ('J4', 'J7');
   
-- ANSI
SELECT
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       SALARY "�޿�"
  FROM
       EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
 WHERE
       BONUS IS NULL
   AND JOB_CODE IN ('J4', 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �� ��, ���п� �ش��ϴ� ����
--    �޿������ S1, S2 �� ��� '���'
--    �޿������ S3, S4 �� ��� '�߱�'
--    �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
-- ����Ŭ
SELECT
       EMP_ID "���",
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       S.SAL_LEVEL "�޿����",
       CASE
            WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '���'
            WHEN S.SAL_LEVEL IN ('S3', 'S4') THEN '�߱�'
            WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '�ʱ�'
       END "����"
  FROM EMPLOYEE E,
       JOB J,
       SAL_GRADE S
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
--   AND E.SAL_LEVEL = S.SAL_LEVEL;                 -- �̰͵� ����
   
-- ANSI
SELECT
       EMP_ID "���",
       EMP_NAME "�����",
       JOB_NAME "���޸�",
       S.SAL_LEVEL "�޿����",
       CASE
            WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '���'
            WHEN S.SAL_LEVEL IN ('S3', 'S4') THEN '�߱�'
            WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '�ʱ�'
       END "����"
  FROM EMPLOYEE E
  JOIN JOB J USING (JOB_CODE)
  JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL); -- ��� ����
--  JOIN SAL_GRADE S USING (SAL_LEVEL);                          -- ��͵� ����
    
-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ� �� ��, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-- ����Ŭ
SELECT
       DEPT_TITLE,
       SUM(SALARY)
  FROM
       EMPLOYEE E,
       DEPARTMENT D
 WHERE
       E.DEPT_CODE = D.DEPT_ID
 GROUP
    BY
       DEPT_TITLE
HAVING
       SUM(SALARY) >= 10000000;

-- ANSI
SELECT
       DEPT_TITLE,
       SUM(SALARY)
  FROM
       EMPLOYEE E
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP
    BY
       DEPT_TITLE
HAVING
       SUM(SALARY) >= 10000000;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��) �� ��ȸ�Ͻÿ� ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�
-- ����Ŭ
SELECT
       DEPT_TITLE "�μ���",
       ROUND(AVG(SALARY)) "��ձ޿�"
  FROM
       EMPLOYEE E,
       DEPARTMENT D
 WHERE
       DEPT_CODE = DEPT_ID(+)
 GROUP
    BY
       DEPT_TITLE;

-- ANSI
SELECT
       DEPT_TITLE "�μ���",
       ROUND(AVG(SALARY)) "��ձ޿�"
  FROM
       EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
 GROUP
    BY
       DEPT_TITLE;
    



















































