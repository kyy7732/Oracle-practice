
/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/
CREATE OR REPLACE PROCEDURE divisor_proc
    (d_num IN NUMBER)
IS
    d_count NUMBER := 0;
BEGIN
    FOR i IN 1..d_num
    LOOP
        IF MOD(d_num, i) = 0 THEN
            d_count := d_count + 1;
        END IF;
    END LOOP;
    dbms_output.put_line('����� ����:' || d_count || '��');
END;

EXEC divisor_proc(3);

/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/
CREATE OR REPLACE PROCEDURE depts_proc
    (dept_id IN depts.department_id%TYPE,
    dept_name IN depts.department_name%TYPE,
    flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN
    CASE
        WHEN flag = 'I' THEN
            INSERT INTO depts
            (department_id, department_name)
            VALUES(dept_id, dept_name);
        WHEN flag = 'U' THEN
            UPDATE depts SET department_name = dept_name
            WHERE dept_id = department_id;
        
        WHEN flag = 'D' THEN
            IF v_cnt = 0 THEN
                dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
                RETURN;
            END IF;
            
            DELETE FROM depts
            WHERE department_id = dept_id;
        ELSE
            dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');
    END CASE;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(500, '�����Ǻ�', 'I');

SELECT * FROM depts;

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/

CREATE OR REPLACE PROCEDURE exex
    (emp_id IN employees.employee_id%TYPE,
    emp_hire OUT NUMBER
    )
    
IS
    e_cnt NUMBER := 0;
    e_hire employees.hire_date%TYPE;
BEGIN
    
    SELECT
        COUNT(*)
    INTO
        e_cnt
    FROM employees
    WHERE emp_id = employee_id;
    
    IF e_cnt = 0 THEN 
       dbms_output.put_line('�������� �ʴ� ����Դϴ�.');
       RETURN;
    ELSE
        SELECT
            hire_date
        INTO
            e_hire
        FROM employees
        WHERE emp_id = employee_id;
    END IF;
    
    emp_hire := TRUNC(MONTHS_BETWEEN(sysdate,e_hire)/12);
    
     EXCEPTION
            WHEN OTHERS THEN
             dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
        RETURN;
END;

DECLARE
    em_hire VARCHAR2(100);
BEGIN
    exex(5000, em_hire);
    dbms_output.put_line(em_hire);
END;

SELECT * FROM employees;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���
������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/
CREATE TABLE emps AS (SELECT * FROM employees);
DROP TABLE emps;

CREATE OR REPLACE PROCEDURE new_emp_proc
    (emp_id IN employees.employee_id%TYPE,
    emp_lname IN employees.last_name%TYPE,
    emp_email IN employees.email%TYPE,
    emp_hire IN employees.hire_date%TYPE,
    emp_job IN employees.job_id%TYPE
    )
IS

BEGIN
    MERGE INTO emps a
        USING
        (SELECT emp_id AS employee_id FROM dual) b
    ON
        (a.employee_id = emp_id)
WHEN MATCHED THEN
    UPDATE SET
        a.last_name = emp_lname,
        a.email = emp_email,
        a.hire_date = emp_hire,
        a.job_id = emp_job
WHEN NOT MATCHED THEN
    INSERT (employee_id, last_name, email, hire_date, job_id)
    VALUES
    (emp_id, emp_lname, emp_email, emp_hire, emp_job);
END;


EXEC new_emp_proc(393, '��ľ�', 'chun', '2023-10-04', 'IT');

SELECT * FROM emps;




















