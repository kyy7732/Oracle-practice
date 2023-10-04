
-- WHILE문

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

-- 탈출문
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

-- FOR문

DECLARE
    v_num NUMBER := 4;
BEGIN

    FOR i IN 1..9 -- .을 두 개 작성해서 범위를 표현.
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;

-- CONTINUE문

DECLARE
    v_num NUMBER := 4;
BEGIN

    FOR i IN 1..9 -- .을 두 개 작성해서 범위를 표현.
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;

END;
--MOD(A.USER_ID, 2) = 0
-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요. (2 ~ 9단)
-- 짝수단만 출력해 주세요. (2, 4, 6, 8)
-- 참고로 오라클 연산자 중에는 나머지를 알아내는 연산자가 없어요. (% 없음~)

-- DECLARE 사용을 안하면 생략가능
BEGIN
    FOR v_dan IN 2..9  
    LOOP
        IF MOD(v_dan, 2) = 0 THEN
            dbms_output.put_line(v_dan || '단' );
            FOR v_hang IN 1..9
            LOOP
                dbms_output.put_line(v_dan || ' x ' || v_hang || ' = ' || v_dan*v_hang);
            END LOOP;
            dbms_output.put_line('-------------------------------------');
        END IF;
    END LOOP;
END;

-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno, writer, title 컬럼이 존재합니다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

CREATE TABLE board (
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20),
    title VARCHAR2(20)
);

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










