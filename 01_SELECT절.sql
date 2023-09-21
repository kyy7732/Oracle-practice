-- ����Ŭ�� �� �� �ּ��Դϴ�.

/*
���� �� �ּ��Դϴ�.
ȣȣȣ~
*/

-- SELECT [�÷���(���� �� ����)] FROM [���̺� �̸�]
-- SQL�� ��ҹ��� ������ ������ Ű����� �빮�ڷ� �ۼ��� ����
SELECT
    *
FROM
    employees;
    
SELECT employee_id, first_name, last_name
FROM employees;

SELECT email, phone_number, hire_date
FROM employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�.
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1 AS ������ -- salary�� 0.1�� ���Ѵ�
FROM employees;

-- NULL ���� Ȯ�� (���� 0�̳� �����̶��� �ٸ� �����Դϴ�.)
SELECT department_id, commission_pct
FROM employees;

-- alias(AS) (�÷���, ���̺���� �̸��� �����ؼ� ��ȸ�մϴ�.)
SELECT 
    first_name AS �̸�,
    last_name AS ��,
    salary AS �޿�
FROM employees;

/*
 ����Ŭ�� �C����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� �C����ǥ��
 ǥ���ϰ� �ʹٸ� ''�� �� �� �������� ���ø� �˴ϴ�.
 ������ �����ϰ� �ʹٸ� || �� ����մϴ�.
*/
SELECT
    first_name ||  ' ' || last_name || '''s salary is $' || salary
    AS �޿�����
FROM employees;
    
-- DISTINCT (�ߺ� ���� ����)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees; -- �ߺ������ϰ� ������ �˷����

-- ROWNUM, ROWID
-- (**�ο��: ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ���)
-- (�ο���̵�: �����ͺ��̽� ���� ���� �ּҸ� ��ȯ)
SELECT ROWNUM, ROWID, employee_id
FROM employees;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    