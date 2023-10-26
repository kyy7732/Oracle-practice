
-- WHILE��

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; -- begin
BEGIN
    WHILE v_count <= 10 -- end
    LOOP    
        v_num := v_num + v_count;
        v_count := v_count + 1; -- step
    END LOOP; 
    dbms_output.put_line(v_num);
END;

-- Ż�⹮
DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; -- begin
BEGIN
    WHILE v_count <= 10 -- end
    LOOP    
        EXIT WHEN v_count = 5;
        
        v_num := v_num + v_count;
        v_count := v_count + 1; -- step
    END LOOP; 
    dbms_output.put_line(v_num);
END;

-- FOR��

DECLARE
    v_num NUMBER := 4;
BEGIN

    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;

-- CONTINUE��

DECLARE
    v_num NUMBER := 4;
BEGIN

    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;
--MOD(A.USER_ID, 2) = 0
-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

-- DECLARE ����� ���ϸ� ��������
BEGIN
    FOR v_dan IN 2..9  
    LOOP
        IF MOD(v_dan, 2) = 0 THEN
            dbms_output.put_line(v_dan || '��' );
            FOR v_hang IN 1..9
            LOOP
                dbms_output.put_line(v_dan || ' x ' || v_hang || ' = ' || v_dan*v_hang);
            END LOOP;
            dbms_output.put_line('-------------------------------------');
        END IF;
    END LOOP;
END;

-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

CREATE TABLE board (
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20),
    title VARCHAR2(20)
);
CREATE TABLE test (
    test_no NUMBER(10) PRIMARY KEY,
    col1 VARCHAR2(50),
    col2 VARCHAR2(50)
);
DROP TABLE test;
DROP SEQUENCE test_seq;
CREATE SEQUENCE test_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 150
    MINVALUE 1
    NOCACHE
    NOCYCLE;
BEGIN
    FOR t_test IN 1..150
    LOOP
        INSERT INTO test
        VALUES(test_seq.nextval, 'test' || t_test , 'title' || t_test);
    END LOOP;
    COMMIT;
END;
SELECT * FROM test;

CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 300
    MINVALUE 1
    NOCACHE
    NOCYCLE;

BEGIN
    FOR v_test IN 1..300
    LOOP
        INSERT INTO board
        VALUES(board_seq.nextval, 'test' || v_test , 'title' || v_test);
    END LOOP;
    COMMIT;
END;


SELECT * FROM board
ORDER BY bno DESC;
DROP SEQUENCE board_seq; 










