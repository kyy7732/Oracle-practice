
-- MERGE: ���̺� ����

/*
UPDATE�� INSERT�� �� �濡 ó��.

�� ���̺� �ش��ϴ� �����Ͱ� �ִٸ� UPDATE��,
������ INSERT�� ó���ض�.
*/

CREATE TABLE emps_it AS (SELECT * FROM employees);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (106, '���', '��', 'CHOONSIK', sysdate, 'IT_PROG');

SELECT * FROM emps_it;

SELECT * FROM employees
WHERE job_id = 'IT_PROG';


MERGE INTO emps_it a -- (������ �� Ÿ�� ���̺�)
    USING -- ���ս�ų ������
        (SELECT * FROM employees
        WHERE job_id = 'IT_PROG') b -- �����ϰ��� �ϴ� �����͸� ���������� ǥ��.
    ON -- ���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN -- ������ ��ġ�ϴ� ��쿡�� Ÿ�� ���̺� �̷��� �����϶�.
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
        
         /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
        */
    DELETE -- DELETE�� ����Ϸ��� UPDATE�� �ۼ��ϰ� ��� ����(���ʿ� ����Ÿ� ���� �÷� �ƹ��ų� �ۼ��� ����)
        WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN -- �������� �ʴ´ٸ� INSERT�� ����
    INSERT /* �Ӽ�(�÷�) */ VALUES 
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id); 
    
------------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');

SELECT * FROM emps_it;

/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
*/


MERGE INTO emps_it a
    USING
        (SELECT * FROM employees) b
    ON
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);

SELECT * FROM emps_it
ORDER BY employee_id ASC;

ROLLBACK;

-- ��1
CREATE TABLE depts AS
(SELECT department_id, department_name, manager_id, location_id
FROM departments);

INSERT INTO depts
VALUES (280, '����', null, 1800);
INSERT INTO depts
VALUES (290, 'ȸ���', null, 1800);
INSERT INTO depts
VALUES (300, '����', 301, 1800);
INSERT INTO depts
VALUES (310, '�λ�', 302, 1800);
INSERT INTO depts
VALUES (320, '����', 303, 1700);

SELECT * FROM depts;

-- ��2
-- 1
UPDATE depts SET department_name = 'IT_bank'
WHERE department_name = 'IT Support';
-- 2
UPDATE depts SET manager_id = 301
WHERE department_id = 290;
-- 3
UPDATE depts 
SET 
    department_name = 'IT Help' ,
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk';
-- 4
UPDATE depts
SET manager_id = 301
WHERE department_name = 'ȸ���'
OR department_name = '����'
OR department_name = '�λ�'
OR department_name = '����';
SELECT * FROM depts;

-- ��3
-- 1
DELETE FROM depts
WHERE department_id = 320;
-- 2
DELETE FROM depts
WHERE department_id = 220;

SELECT * FROM depts;
-- ��4
-- 1
DELETE FROM depts
WHERE department_id > 200;
-- 2
UPDATE depts SET manager_id = 100
WHERE manager_id IS NOT NULL;
-- 3, 4
MERGE INTO depts a
    USING 
        (SELECT * FROM departments) b
    ON 
        (a.department_id = b.department_id)
WHEN MATCHED THEN
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.department_id, b.department_name,
    b.manager_id, b.location_id);


-- ��5
-- 1
CREATE TABLE jobs_it AS
(SELECT job_id, job_title, min_salary, max_salary
FROM jobs j WHERE j.min_salary > 6000);
-- 2
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES 
    ('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO jobs_it
    (job_id, job_title, min_salary, max_salary)
VALUES 
    ('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO jobs_it
VALUES 
    ('SEC_DEV', '���Ȱ�����', 6000, 19000);
    
-- 3, 4
MERGE INTO jobs_it a
    USING 
        (SELECT * FROM jobs j
        WHERE j.min_salary > 5000) b
    ON
        (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.job_id, b.job_title, b.min_salary, b.max_salary);
    

SELECT * FROM jobs_it;






