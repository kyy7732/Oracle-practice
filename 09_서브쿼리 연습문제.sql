/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/
/* 1.   2. COUNT(e.first_name) 51 
SELECT
    *
FROM  employees e
WHERE e.salary > (
SELECT
    AVG(salary)
FROM employees
);
*/
SELECT
    *
FROM  employees
WHERE salary > (SELECT AVG(salary) FROM employees 
                  WHERE job_id = 'IT_PROG');
/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� �������
��� ������ ����ϼ���.
*/

SELECT
    *
FROM employees e
WHERE e.department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100);

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
/*
SELECT
    *
FROM employees e
WHERE e.manager_id > (SELECT e.manager_id FROM employees e
                        WHERE e.first_name = 'Pat');
*/
SELECT
    *
FROM employees e
WHERE e.manager_id IN (SELECT e.manager_id FROM employees e
                        WHERE e.first_name = 'James');


/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT * FROM
    (
    SELECT
        ROWNUM AS rn, tbl.first_name
    FROM (SELECT * FROM employees
            ORDER BY first_name DESC) tbl
    )
WHERE rn > 40 AND rn <= 50;
/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/
SELECT * FROM
    (
    SELECT
        ROWNUM AS rn, tbl.*
    FROM (
            SELECT 
                employee_id, first_name, phone_number, hire_date    
            FROM employees
            ORDER BY hire_date ASC) tbl
    ) tbl
WHERE rn > 30 AND rn <= 40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT
    e.employee_id,
    CONCAT(e.first_name, e.last_name) AS full_name,
    d.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id;



/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    e.employee_id, CONCAT(e.first_name, e.last_name), e.department_id,
    (
    SELECT 
    department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) AS �μ���
FROM employees e
ORDER BY e.employee_id;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id, 
    loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (
    SELECT street_address  FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS loc_address,
    (
    SELECT postal_code  FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS pos_code,
    (
    SELECT city  FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS city
FROM departments d
ORDER BY d.department_id;

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name;


/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    loc.location_id, loc.street_address, loc.city,
    (
    SELECT
        country_id
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) AS c_id,
    (
    SELECT
        country_name
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) AS c_name
FROM locations loc
ORDER BY c_name;



