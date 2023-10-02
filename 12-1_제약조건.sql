-- ���̺� ������ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����. (�ʼ���)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.


-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 ( 
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

DROP TABLE dept2;

-- ���̺� ���� ���� ���� (��� �� ���� �� ���� ������ ���ϴ� ���)
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);
SELECT * FROM locations;
SELECT * FROM dept2;
-- �ܷ� Ű(foreign key)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT �Ұ���
INSERT INTO dept2
VALUES(10, 'gg', 4000, 100000, 'M');

INSERT INTO dept2
VALUES(20, 'hh', 1900, 100000, 'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; -- ����(�ܷ�Ű �������� ����)

UPDATE dept2
SET loca = 4000
WHERE loca = 1900; -- ����(�ܷ�Ű �������� ����)

-- ���� ������ ����
-- ���� ������ �߰�, ������ �����մϴ�. ������ �ȵ˴ϴ�.
-- �����Ϸ��� �����ϰ� ���ο� �������� �߰��ϼž� �մϴ�.

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- pk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
-- fk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk 
FOREIGN KEY(loca) REFERENCES locations(location_id);
-- check �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck 
CHECK(dept_bonus > 0);
-- unique �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk 
UNIQUE(dept_name);
-- NOT NULL�� �� �������·� �����մϴ�.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- ���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- ���� ���� ���� (���� ���� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT dept2_bonus_ck;


CREATE TABLE members (
    M_NAME VARCHAR2(10) NOT NULL,
    M_NUM NUMBER(1) CONSTRAINT mem_memnum_pk PRIMARY KEY,
    REG_DATE DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
    GENDER VARCHAR2(1) CHECK (GENDER IN ('M', 'F')),
    LOCA NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);


INSERT INTO members
VALUES ('DDD', 4, '2018-07-04', 'M', 2000);

COMMIT;

--TRUNCATE TABLE members;
SELECT * FROM members;
SELECT * FROM locations;

-- ��2
SELECT
    m.m_name,m.m_num,
    loc.street_address, loc.location_id
FROM members m
JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m.m_num;





