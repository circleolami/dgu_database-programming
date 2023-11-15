spool C:\Users\circl\Documents\2023-2\database_programming\week11\oracle_week11.txt;

Set ServerOutput On;

DROP TABLE DEPT CASCADE CONSTRAINTS PURGE;
DROP TABLE EMP CASCADE CONSTRAINTS PURGE;
DROP TABLE student CASCADE CONSTRAINTS;  
DROP TABLE course CASCADE CONSTRAINTS;  
DROP TABLE professor CASCADE CONSTRAINTS;  
DROP TABLE enroll CASCADE CONSTRAINTS;  
DROP TABLE teach CASCADE CONSTRAINTS;  

CREATE TABLE student
(
    s_id       VARCHAR2(10),
    s_name  VARCHAR2(50)   not null,
    s_addr    VARCHAR2(200),
    s_year     NUMBER(1)   not null,
    s_college    VARCHAR2(50)   not null,
    s_major   VARCHAR2(50)   not null,
    s_pwd       VARCHAR2(10)   not null,
    CONSTRAINT s_pk PRIMARY KEY (s_id)
);


INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011234', '김민준','서울시 강남구 도곡동 123', 4, 'AI융합학부', '컴퓨터공학','1234');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011235', '이지아','경기도 성남시 분당구 서현동 234', 4, 'AI융합학부', '컴퓨터공학','1235');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011236', '최유나','서울시 마포구 합정동 345', 4, 'AI융합학부', '컴퓨터공학','1236');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011237', '정하은','인천시 연수구 송도동 456', 4, 'AI융합학부', '컴퓨터공학','1237');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021245', '한지우','부산시 해운대구 중동 567', 3, 'AI융합학부', '컴퓨터공학','3123');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021246', '송하준','대구시 수성구 범어동 678', 3, 'AI융합학부', '컴퓨터공학','3124');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021247', '안준호','광주시 서구 치평동 789', 3, 'AI융합학부', '컴퓨터공학','3125');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20023451', '김지수','울산시 남구 신정동 890', 3, 'AI융합학부', '멀티미디어공학','3451');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20012454', '박윤서','제주시 제주동 901', 4, 'AI융합학부', '멀티미디어공학','3454');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20012456', '송태윤','서울시 용산구 한남동 123', 4, 'AI융합학부', '멀티미디어공학','3456');
COMMIT;

CREATE TABLE course
(
    c_id      VARCHAR2(10),
    c_id_no  NUMBER(1),
    c_name  VARCHAR2(50),
    c_unit     NUMBER(1),
    CONSTRAINT c_pk PRIMARY KEY (c_id, c_id_no)
);

INSERT INTO course VALUES ('C100', 3, '프로그래밍기초', 3) ;
INSERT INTO course VALUES ('C200', 3, '자료구조와실습', 3) ;
INSERT INTO course VALUES ('C300', 3, '데이터베이스시스템', 3) ;
INSERT INTO course VALUES ('C400', 3, '데이터베이스프로그래밍', 3) ;
INSERT INTO course VALUES ('C500', 3, '운영체제', 3) ;
INSERT INTO course VALUES ('C600', 3, '공개SW프로젝트', 3) ;
INSERT INTO course VALUES ('C700', 3, '데이터통신입문', 3) ;
INSERT INTO course VALUES ('C800', 3, '인공지능', 3) ;
INSERT INTO course VALUES ('C900', 3, '객체지향프로그래밍', 3) ;
INSERT INTO course VALUES ('M100', 3, '컴퓨터그래픽스', 3) ;
INSERT INTO course VALUES ('M200', 3, '계산적사고법', 3) ;
INSERT INTO course VALUES ('M300', 3, '컴퓨터알고리즘과실습', 3) ;
INSERT INTO course VALUES ('M400', 3, '시스템소프트웨어와실습', 3) ;
INSERT INTO course VALUES ('M500', 3, '컴퓨터구성', 3) ;
INSERT INTO course VALUES ('M600', 3, '컴퓨터구조', 3) ;
INSERT INTO course VALUES ('M700', 3, '양자컴퓨팅', 3) ;
COMMIT;


CREATE TABLE professor
(
    p_id          VARCHAR2(10),
    p_name      VARCHAR2(50)   not null,
    p_college    VARCHAR2(50)   not null,
    p_major      VARCHAR2(50)   not null,
    p_pwd         VARCHAR2(10)   not null,
    CONSTRAINT p_pk PRIMARY KEY (p_id)
);

INSERT INTO professor VALUES ('CS4580', '안영일', 'AI융합학부', '컴퓨터공학','4580');
INSERT INTO professor VALUES ('CS4581', '조정환', 'AI융합학부', '컴퓨터공학','4581');
INSERT INTO professor VALUES ('CS4582', '이영희', 'AI융합학부', '컴퓨터공학','4582');
INSERT INTO professor VALUES ('CS4583', '윤정남', 'AI융합학부', '컴퓨터공학','4583');
INSERT INTO professor VALUES ('CS4584', '송대영', 'AI융합학부', '컴퓨터공학','4584');
INSERT INTO professor VALUES ('CS4585', '김영미', 'AI융합학부', '컴퓨터공학','4585');
INSERT INTO professor VALUES ('MM4570', '최미숙', 'AI융합학부', '멀티미디어공학','4570');
INSERT INTO professor VALUES ('MM4571', '박종호', 'AI융합학부', '멀티미디어공학','4571');
INSERT INTO professor VALUES ('MM4572', '정혜숙', 'AI융합학부', '멀티미디어공학','4572');
COMMIT;


CREATE TABLE enroll
(
    s_id        VARCHAR2(10),
    c_id        VARCHAR2(10),
    c_id_no    NUMBER(1),
    e_year      NUMBER(4),
    e_semester    NUMBER(1),
    e_score    NUMBER(3),
    CONSTRAINT e_pk PRIMARY KEY (s_id, c_id, c_id_no),
    CONSTRAINT e_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
);

INSERT INTO enroll VALUES ( '20011234', 'C100', 3, 2024, 1, 60);
INSERT INTO enroll VALUES ( '20011234', 'C200', 3, 2024, 1, 57);
INSERT INTO enroll VALUES ( '20011234', 'C300', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C400', 3, 2024, 1, 85);
INSERT INTO enroll VALUES ( '20011234', 'C500', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C600', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011234', 'C700', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C100', 3, 2023, 2, 76);
INSERT INTO enroll VALUES ( '20011235', 'C200', 3, 2024, 1, 78);
INSERT INTO enroll VALUES ( '20011235', 'C300', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C400', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C500', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C600', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C700', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C900', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20011236', 'C100', 3, 2023, 2, 67);
INSERT INTO enroll VALUES ( '20011236', 'C200', 3, 2024, 1, 95);
INSERT INTO enroll VALUES ( '20011236', 'C300', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C400', 3, 2024, 1, 95);
INSERT INTO enroll VALUES ( '20011236', 'C500', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C600', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C700', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C900', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20011237', 'C100', 3, 2023, 2, 45);
INSERT INTO enroll VALUES ( '20011237', 'C200', 3, 2024, 1, 68);
INSERT INTO enroll VALUES ( '20011237', 'C300', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C400', 3, 2024, 1, 88);
INSERT INTO enroll VALUES ( '20011237', 'C500', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C600', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C700', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C900', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20021245', 'C100', 3, 2023, 2, 75);
INSERT INTO enroll VALUES ( '20021245', 'C200', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011245', 'C900', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20021246', 'C100', 3, 2023, 2, 91);
INSERT INTO enroll VALUES ( '20021246', 'C200', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20011246', 'C900', 3, 2024, 1, null);
INSERT INTO enroll VALUES ( '20021247', 'C100', 3, 2023, 2, 87);
INSERT INTO enroll VALUES ( '20021247', 'C200', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20012454', 'C100', 3, 2023, 2, 67);
INSERT INTO enroll VALUES ( '20012454', 'M100', 3, 2023, 2, 57);
INSERT INTO enroll VALUES ( '20012454', 'M200', 3, 2024, 1, 71);
INSERT INTO enroll VALUES ( '20012454', 'M300', 3, 2024, 1, 83);
INSERT INTO enroll VALUES ( '20012454', 'M400', 3, 2024, 1, 89);
INSERT INTO enroll VALUES ( '20012454', 'M500', 3, 2023, 2, null);
INSERT INTO enroll VALUES ( '20012456', 'C100', 3, 2023, 2, 96);
INSERT INTO enroll VALUES ( '20012456', 'C200', 3, 2024, 1, 87);
INSERT INTO enroll VALUES ( '20012456', 'M100', 3, 2023, 2, 63);
INSERT INTO enroll VALUES ( '20012456', 'M200', 3, 2024, 1, 68);
INSERT INTO enroll VALUES ( '20012456', 'M300', 3, 2024, 1, 98);
INSERT INTO enroll VALUES ( '20012456', 'M400', 3, 2024, 1, 85);
INSERT INTO enroll VALUES ( '20012456', 'M500', 3, 2023, 2, null);
COMMIT;

CREATE TABLE teach
(
    p_id      VARCHAR2(10),
    c_id      VARCHAR2(10),
    c_id_no  NUMBER(1),
    t_year    NUMBER(4),
    t_semester    NUMBER(1),
    t_time    NUMBER(1),
    t_where  VARCHAR2(50),
    t_max    NUMBER(2),
    CONSTRAINT t_pk PRIMARY KEY (p_id, c_id, c_id_no,t_year,t_semester ),
    CONSTRAINT t_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
 );

INSERT INTO teach VALUES ( 'CS4580', 'C100', 3 , 2024, 1, 4, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C200', 3 , 2024, 1, 5, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C200', 3 , 2023, 2, 5, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C300', 3 , 2024, 1, 2, '인-416', 5);
INSERT INTO teach VALUES ( 'CS4582', 'C400', 3 , 2024, 1, 6, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4582', 'C400', 3 , 2023, 2, 6, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4583', 'C500', 3 , 2024, 1, 3, '인-201', 5);
INSERT INTO teach VALUES ( 'CS4583', 'C700', 3 , 2023, 2, 4, '인-310', 5);
INSERT INTO teach VALUES ( 'CS4584', 'C600', 3 , 2023, 2, 1, '인-309', 5);
INSERT INTO teach VALUES ( 'CS4584', 'C800', 3 , 2024, 1, 7, '인-309', 5);
INSERT INTO teach VALUES ( 'MM4570', 'M100', 3 , 2024, 1, 5, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4570', 'M400', 3 , 2024, 1, 5, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4571', 'M200', 3 , 2024, 1, 3, '숭-417', 5);
INSERT INTO teach VALUES ( 'MM4571', 'M200', 3 , 2023, 2, 3, '숭-417', 5);
INSERT INTO teach VALUES ( 'MM4571', 'M500', 3 , 2023, 2, 6, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M300', 3 , 2024, 1, 3, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M300', 3 , 2023, 2, 3, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'C900', 3 , 2024, 1, 2, '숭-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M700', 3 , 2024, 1, 8, '숭-201', 5);

COMMIT;

CREATE TABLE DEPT (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
   DNAME VARCHAR2(14) ,
   LOC VARCHAR2(13) ) ;
INSERT INTO DEPT VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES(40,'OPERATIONS','BOSTON');
COMMIT;

CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
   ENAME VARCHAR2(10),
   JOB VARCHAR2(9),
   MGR NUMBER(4),
   HIREDATE DATE,
   SAL NUMBER(7,2),
   COMM NUMBER(7,2),
   DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,to_date('13-1-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,to_date('13-12-1987', 'dd-mm-rr')-51,1100,NULL,20);
INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
COMMIT;

/* Q1 */ 

DECLARE
    nYear NUMBER := 2023;
    nSemester NUMBER := 1;
    sCourseId VARCHAR2(10) := 'C100';
    nCourseIdNo NUMBER := 3;
    sStudentId VARCHAR2(10) := '20011234';
    nTeachMax NUMBER;
    nCnt NUMBER;

    /* 수강신청 인원 초과 여부 확인 */ 
    CURSOR c_teachMax IS
        SELECT t_max
        FROM teach
        WHERE t_year = nYear AND t_semester = nSemester AND c_id = sCourseId AND c_id_no = nCourseIdNo;

    /* 수강생 수 확인 */ 
    CURSOR c_enrollCnt IS
        SELECT COUNT(*)
        FROM enroll
        WHERE e_year = nYear AND e_semester = nSemester AND c_id = sCourseId AND c_id_no = nCourseIdNo;

    /* 시간표 중복 확인 */ 
    CURSOR c_duplicate_time IS
        SELECT COUNT(*)
        FROM (
            SELECT t_time FROM teach
            WHERE t_year = nYear AND t_semester = nSemester AND c_id = sCourseId AND c_id_no = nCourseIdNo
            INTERSECT
            SELECT t.t_time FROM teach t, enroll e
            WHERE e.s_id = sStudentId AND e.e_year = nYear AND e.e_semester = nSemester AND t.t_year = nYear AND t.t_semester = nSemester AND e.c_id = t.c_id AND e.c_id_no = t.c_id_no
        );

BEGIN
    /* 에러 처리 3 : 수강신청 인원 초과 여부 */ 
    OPEN c_teachMax;
    FETCH c_teachMax INTO nTeachMax;
    CLOSE c_teachMax;

    OPEN c_enrollCnt;
    FETCH c_enrollCnt INTO nCnt;
    CLOSE c_enrollCnt;

    IF (nCnt >= nTeachMax) THEN
        DBMS_OUTPUT.PUT_LINE('수강신청 인원 초과입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('수강신청 인원 초과가 아닙니다.');
    END IF;

    /* 에러 처리 4 : 신청한 과목을 시간 중복 여부 */ 
    OPEN c_duplicate_time;
    FETCH c_duplicate_time INTO nCnt;
    CLOSE c_duplicate_time;

    IF (nCnt > 0) THEN
        DBMS_OUTPUT.PUT_LINE('시간표 중복입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('시간표 중복이 아닙니다.');
    END IF;
END;
/

/* Q2 */ 

DROP PROCEDURE EMP_DELETE;

CREATE OR REPLACE PROCEDURE EMP_DELETE(eNo IN EMP.EMPNO%TYPE)
 IS
 no_sub_employee EXCEPTION;
 employ_name EMP.ENAME%TYPE;
 sub EMP%ROWTYPE;
     dept_name DEPT.DNAME%TYPE;
 CURSOR subCursor(m_no EMP.EMPNO%TYPE)
 IS
 SELECT * FROM EMP WHERE MGR = eNO;
 BEGIN
     DBMS_OUTPUT.PUT_LINE(chr(10) || chr(13));
 SELECT ename
 INTO employ_name
 FROM EMP
 WHERE empno = eNo;
 
     DBMS_OUTPUT.PUT_LINE('삭제할 사원 이름 : ' || employ_name || chr(10) || chr(13));
 
     OPEN subCursor(eNo);
     LOOP
 FETCH subCursor INTO sub;
 EXIT WHEN subCursor%NOTFOUND;
 END LOOP;
     IF (subCursor%ROWCOUNT = 0) THEN
 RAISE no_sub_employee;
 END IF;
     CLOSE subCursor;
     DBMS_OUTPUT.PUT_LINE('<부하직원 정보>');
 DBMS_OUTPUT.PUT_LINE('사원번호      이름          부서명        직책          관리자번호');
     DBMS_OUTPUT.PUT_LINE('---------     ---------     ---------     ---------     ----------');
 
 OPEN subCursor(eNo);
 LOOP
 FETCH subCursor INTO sub;
 EXIT WHEN subCursor%NOTFOUND;
         SELECT dname INTO dept_name
         FROM DEPT WHERE deptno = sub.deptno;
         DBMS_OUTPUT.PUT_LINE(
             rpad(TO_CHAR(sub.empno), 14) || rpad(sub.ename, 14)
             || rpad(dept_name,14) || rpad(sub.job, 14) || rpad(TO_CHAR(sub.mgr), 14));
 UPDATE EMP SET MGR = NULL WHERE empno = sub.empno;
 END LOOP;
     CLOSE subCursor;
     commit;
 EXCEPTION
 WHEN no_sub_employee THEN
     DBMS_OUTPUT.PUT_LINE('부하직원이 없는 사원입니다.');
 WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('존재하지 않는 사원입니다.');
 WHEN OTHERS THEN
     rollback;
 END;
 /

exec emp_delete(7566);
exec emp_delete(7934);
exec emp_delete(9999);
select * from emp;

spool off

commit;