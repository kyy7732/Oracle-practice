/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
*/
-- INNER JOIN 106, LEFT OUTER 107, RIGHT OUTER 122, FULL OUTER 123

SELECT
    *
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/
SELECT
    CONCAT(e.first_name, e.last_name), e.department_id
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.employee_id = 200;


/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��
*/
SELECT
    *
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id;

/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/

SELECT 
    *
FROM jobs j
LEFT JOIN job_history jh
ON j.job_id = jh.job_id;


/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/
SELECT
    CONCAT(e.first_name, e.last_name), d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.last_name = 'King'
AND e.first_name = 'Steven';


/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/
SELECT
    *
FROM employees e
CROSS JOIN departments d;

/*
���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
*/
SELECT
    e.employee_id, e.first_name, e.salary, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations loc
ON d.location_id = loc.location_id
WHERE e.job_id = 'SA_MAN';

/*
���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� 
���� ������ ����ϼ���.
*/
SELECT
    *
FROM employees e
join jobs j
ON e.job_id = j.job_id
WHERE j.job_title = 'Stock Manager'
OR j.job_title = 'Stock Clerk';


/*
���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
*/
SELECT
    d.department_name
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

/*
���� 10. 
-join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
*/

SELECT
    e1.first_name, e2.first_name
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;

/*
���� 11. 
-- EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
*/

SELECT
    e1.first_name AS ������,
    e2.first_name AS �Ŵ���,
    e2.salary As �Ŵ����޿�
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL;












