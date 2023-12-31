#### **2023-09-21**
## **SQL**
DBMS: 데이터 베이스 관리 시스템
데이터 정의, 데이터 조작, 데이터 보안, 데이터 무결성, 트랜잭션 관리
DDL > DML
레코드 : 한 행의 데이터
테이블 : 객체

### **MyWork - sql_study**
## **01_SELECT절**
* AS(alias) (컬럼명, 테이블명의 이름을 변경해서 조회합니다.)

## **02_WHERE절**
* WHERE: 조건 붙여서 검색
* LIKE(%뒤나 앞에 조건들 검색)
* IS NULL (null값을 찾음)
* IS NOT NULL (null없는 값 찾음)
* AND,OR 연산 순서는 AND > OR
* 데이터의 정렬 ORDER BY ASC(오름차순) / DESC(내림차순)

## **03_연습문제**
* 배운것들 예제

## **04_문자열 함수**
* daul : 더미 테이블
* lower(소문자), initcap(앞글자만 대문자), upper(대문자)
* LENGTH(길이), INSTR(찾을 곳, '찾을 문자')(문자 찾기)
* SUBSTR(찾을 곳, 1, 4)(1부터 4자리 출력)
* CONCAT(연결할 문자, 연결할 문자)(문자 연결 최대 2개까지)
* LPAD,RPAD(찾을곳, 개수, 지정문자열)(좌, 우측 지정문자열로 채우기)
* LTRIM,RTRIM,TRIM(찾을곳, '찾을 문자')(공백제거)
* REPLACE(바꿀곳, '바꾸고싶은 문자','바꿀 문자')

## **05_숫자날짜함수**
* ROUND(3.1415, 3)(1.142)소수점 3번째 뒷자리 반올림
* TRUNC(3.1415, 3)(1.141)소수점 3번째 반올림
* ABS(-34)(34) 절대값
* CEIL(올림),FLOOR(내림) 정수값 올림, 내림
* MOD(10,4)(2) 나머지 계산
* sysdate: 오라클에서 제공하는 날짜, 시간(환경설정> 데이터베이스> NLS > 날짜형식 HH24:MI:SS변경시 시간출력) 함수 오늘 (일/월/년) 날짜연산가능
(일수, 주수, 년수, 날짜 반올림, 절사)

## **06_형변환 함수**
* 형 변환 함수 TO_CHAR, TO_NUMBER, TO_DATE
* NVL(컬럼, 변환할 타겟값) null을 변활할 값으로 변경
* NVL2(컬럼, null이 아닐 경우의 값, null일 경우의 값)
* DECODE(컬럼, null이 아닐 경유의 값, null일 경우의 값)

## **sql 실행 순서**
#### **FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY**

## **06-1_집합연산자**
* 집합 연산자 UNION(합집합 중복x), UNION ALL(합집합 중복o), INTERSECT(교집합), MINUS(차집합)

## **07_그룹함수(GROUP BY, HAING)
* AVG, MAX, MIN, SUM, COUNT
* GROUP BY: 그룹화
* HAVING: 그룹별 조건 걸때

## **08_조인해보기**
* 서로 다른 테이블간에 설정된 관계가 결합하여 1개 이상의 테이블에서 데이터를 조회하기 위해서 사용.

## **11_트랜젝션**
* SHOW AUTOCOMMIT 오토커밋 활성화 여부확인
* DDL -> CREATE, ALTER, DROP
* DROP으로 날린데이터는 롤백이 안된다
* TCL -> COMMIT, ROLLBACK, SAVEPOINT

## **14_시퀀스_index**
* 시퀀스 (순차적으로 증가하는 값을 만들어 주는 객체)

## **03_PLSQL조건문**
* IF문,ELSIF문, 중첩IF
*  CASE문

## **04_PLSQL반복문 탈출문**
* WHLIE문, 탈출문(EXIT)
* FOR문, CONTINUE문
* 예제문제

## **05_PLSQL프로시저
* 프로시저(procedure) -> void 메서드 유사
특정한 로직을 처리하고 결과갑을 반환하지 않는 코드 덩어리
예외 처리 (EXCEPTION)

## **06_PLSQL프로시저연습
* merge에 dual활용한 예제

## **07_트리거**
* 트리거 정의(INSERT, UPDATE, DELETE 작업이 수행될 때 특정 코드가 작동되도록 하는 구문입니다.)

## **08_트리거after_before**
* AFTER 트리거 - INSERT, UPDATE, DELETE 작업 **이후**에 동작하는 트리거
* BEFORE 트리거 - INSERT, UPDATE, DELETE 작업 **이전**에 동작하는 트리거
* :OLD = 참조 전 열의 값 (INSERT: 입력 전 자료, UPDATE: 수정 전 자료, DELETE: 삭제 될 값)
* :NEW = 참조 후 열의 값 (INSERT: 입력 할 자료, UPDATE: 수정 된 자료)
* 예외 발생 시키기(RAISE), RAISE_APPLICATION_ERROR() (오라클에서 제공하는 사용자 정의 예외를 발생시키는 함수);
