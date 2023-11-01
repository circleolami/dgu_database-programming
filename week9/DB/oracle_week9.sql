spool C:\Users\circl\Documents\2023-2\database_programming\week9\oracle_week9.txt;

Set ServerOutput On;

/* Q1 */
DECLARE
max_sal emp.sal%TYPE;
min_sal emp.sal%TYPE;
BEGIN
SELECT MAX(sal), MIN(sal)
INTO max_sal, min_sal 
FROM EMP;
DBMS_OUTPUT.PUT_LINE('사원 중에 최고 급여는 ' || max_sal || '원, 최저 급여는 ' || min_sal || '원이다.');
END;
/

/* Q2 */
DECLARE
i NUMBER := 0;
j NUMBER := 0;
str VARCHAR(11);
BEGIN
str := '*';
FOR i IN 1..10 LOOP
DBMS_OUTPUT.PUT_LINE(str);
str := str || '*';
END LOOP;
END;
/

/* Q3 */
DECLARE
    v_eno emp.empno%TYPE := 7698;
    v_sal emp.sal%TYPE;
    v_grade salgrade.grade%TYPE;
    v_low salgrade.losal%TYPE;
    v_high salgrade.hisal%TYPE;
BEGIN
    SELECT sal
    INTO v_sal
    FROM emp
    WHERE empno = v_eno;

    FOR v_grade IN 1..5 LOOP
        SELECT losal, hisal
        INTO v_low, v_high
        FROM salgrade
        WHERE grade = v_grade;

        IF (v_low <= v_sal AND v_sal <= v_high) THEN
            DBMS_OUTPUT.put_LINE('7698 사원의 급여 등급은 ' || v_grade || '입니다');
            EXIT;
        END IF;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_LINE('No data found for the given criteria.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.put_LINE('Too many rows returned for the given criteria.');
END;
/

/* Q4 */
DECLARE 
v_newEmp emp%ROWTYPE;
v_oldEmp emp%ROWTYPE;
v_oldEno emp.empno%TYPE := '7369';
BEGIN
SELECT * INTO v_oldEmp 
FROM EMP 
WHERE empno = v_oldEno;
v_newEmp.empno := '7370';
v_newEmp.ename := 'JASON';
v_newEmp.job :=  'ANALYST';
v_newEmp.sal := 900;
v_newEmp.comm := NULL;
v_newEmp.mgr := v_oldEmp.mgr;
v_newEmp.hiredate := v_oldEmp.hiredate;
v_newEmp.deptno := v_oldEmp.deptno;
INSERT INTO EMP VALUES (v_newEmp.empno, v_newEmp.ename, v_newEmp.job, v_newEmp.mgr, v_newEmp.hiredate, v_newEmp.sal, v_newEmp.comm, v_newEmp.deptno);
commit;
END;
/ 

select * from emp;

/* Q5 */
DECLARE
    TYPE EmpRec IS RECORD (
        ename EMP.ENAME%TYPE,
        sal EMP.SAL%TYPE
    );

    TYPE EmpTable IS TABLE OF EmpRec INDEX BY PLS_INTEGER;

    avg_sal NUMBER;
    high_sal_employees EmpTable;
    idx PLS_INTEGER := 1;

BEGIN
    SELECT AVG(sal) INTO avg_sal FROM EMP;

    DBMS_OUTPUT.PUT_LINE(' - 평균 급여 : ' || avg_sal);

    FOR rec IN (SELECT ename, sal FROM EMP WHERE sal > avg_sal ORDER BY sal ASC) LOOP
        high_sal_employees(idx).ename := rec.ename;
        high_sal_employees(idx).sal := rec.sal;
        idx := idx + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('사원명     급여');
    DBMS_OUTPUT.PUT_LINE('------    ------');

    FOR i IN 1..high_sal_employees.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(high_sal_employees(i).ename, 10) || LPAD(TO_CHAR(high_sal_employees(i).sal), 6));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('- 총 인원수: ' || (idx - 1) || '명');
END;
/

spool off;