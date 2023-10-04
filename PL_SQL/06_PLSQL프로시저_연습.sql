
/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
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
    dbms_output.put_line('약수의 개수:' || d_count || '개');
END;

EXEC divisor_proc(3);

/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
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
                dbms_output.put_line('삭제하고자 하는 부서가 존재하지 않습니다.');
                RETURN;
            END IF;
            
            DELETE FROM depts
            WHERE department_id = dept_id;
        ELSE
            dbms_output.put_line('해당 flag에 대한 동작이 준비되지 않았습니다.');
    END CASE;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('예외가 발생했습니다.');
        dbms_output.put_line('ERROR MSG: ' || SQLERRM);
        ROLLBACK;
END;

EXEC depts_proc(500, '오락실부', 'I');

SELECT * FROM depts;

/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
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
       dbms_output.put_line('존재하지 않는 사원입니다.');
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
             dbms_output.put_line('예외가 발생했습니다.');
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
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요
머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달받아야 할 값: 사번, last_name, email, hire_date, job_id
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


EXEC new_emp_proc(393, '춘식아', 'chun', '2023-10-04', 'IT');

SELECT * FROM emps;




















