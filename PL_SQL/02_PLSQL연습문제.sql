
-- 1. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)

DECLARE
    v_emp_fname employees.first_name%TYPE;
    v_emp_email employees.email%TYPE;
BEGIN
    SELECT
        e.first_name, e.email
    INTO
    v_emp_fname, v_emp_email
    FROM employees e
    WHERE e.employee_id = 201;
    
    DBMS_OUTPUT.put_line(v_emp_fname || '-' || v_emp_email);
END;

-- 2. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�.

DECLARE
    v_emp_max employees.employee_id%TYPE;
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_emp_max
    FROM employees;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES(v_emp_max + 1, 'steven', 'stevenjobs', sysdate, 'CEO');
END;

SELECT * FROM emps;



DECLARE
 v_emp_eid employees.employee_id%TYPE;
BEGIN
    SELECT
        MAX(employee_id)
    INTO
        v_emp_eid
    FROM employees e;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
    (v_emp_eid + 1, 'steven', 'stevenjobs', sysdate, 'CEO');
    
END;

SELECT  * FROM emps;

/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/



















