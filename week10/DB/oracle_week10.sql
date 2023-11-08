spool C:\Users\circl\Documents\2023-2\database_programming\week10\oracle_week10.txt;

Set ServerOutput On;

/* Q1 */
DECLARE
  v_job EMP.JOB%TYPE;
  v_counter NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('직책명');
  DBMS_OUTPUT.PUT_LINE('==========');

  FOR c IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 10 ORDER BY JOB)
  LOOP
    v_job := c.JOB;
    v_counter := v_counter + 1;
    DBMS_OUTPUT.PUT_LINE(v_job);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE(chr(10)||chr(13) || '직책의 수 : ' || v_counter);
END;
/


/* Q2 */
SET SERVEROUTPUT ON;

DECLARE
  CURSOR c_manager IS
    SELECT EMPNO, ENAME FROM EMP WHERE JOB = 'MANAGER' ORDER BY EMPNO;
  v_emp_record c_manager%ROWTYPE;
  v_total_count NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('사원번호'||'    '||'사원명');
  DBMS_OUTPUT.PUT_LINE('======='||' '||'=======');
  
  OPEN c_manager;
  LOOP
    FETCH c_manager INTO v_emp_record;
    EXIT WHEN c_manager%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE(rpad(v_emp_record.EMPNO, 7) || rpad(v_emp_record.ENAME, 10));
    v_total_count := v_total_count + 1;
  END LOOP;
  CLOSE c_manager;

  DBMS_OUTPUT.PUT_LINE(chr(10)||chr(13) || '총 인원 수 : ' || v_total_count);
END;
/


/* Q3 */
CREATE OR REPLACE PROCEDURE EMP_INPUT (
  p_empno IN EMP.EMPNO%TYPE,
  p_ename IN EMP.ENAME%TYPE,
  p_job IN EMP.JOB%TYPE,
  p_mgr IN EMP.MGR%TYPE,
  p_hiredate IN EMP.HIREDATE%TYPE DEFAULT SYSDATE,
  p_sal IN EMP.SAL%TYPE
) AS
  v_deptno EMP.DEPTNO%TYPE;
  v_comm EMP.COMM%TYPE;
BEGIN
  SELECT DEPTNO INTO v_deptno FROM EMP WHERE EMPNO = p_mgr;
  
  IF p_job = 'SALESMAN' THEN
    v_comm := 10;
  ELSE
    v_comm := NULL;
  END IF;
  
  INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
  VALUES (p_empno, p_ename, p_job, p_mgr, p_hiredate, p_sal, v_comm, v_deptno);
  
  COMMIT;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('중복된 사원번호입니다.');
END EMP_INPUT;
/

EXECUTE EMP_INPUT(7900, 'ALVIN', 'SALESMAN', 7788, SYSDATE, 1500);

EXECUTE EMP_INPUT(7904, 'ALVIN', 'SALESMAN', 7788, SYSDATE, 1500);

EXECUTE EMP_INPUT(7367, 'JOHN', 'CLERK', 7902, SYSDATE, 1200);


/* Q4 */
CREATE OR REPLACE FUNCTION D_E_CNT(p_dname IN DEPT.DNAME%TYPE)
RETURN NUMBER IS
  v_emp_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_emp_count
  FROM EMP e
  JOIN DEPT d ON e.DEPTNO = d.DEPTNO
  WHERE d.DNAME = p_dname;

  RETURN v_emp_count;
END;
/

VAR empCnt NUMBER
EXEC :empCnt := D_E_CNT('SALES');
DECLARE
  empCnt NUMBER;
BEGIN
  empCnt := D_E_CNT('SALES');
  DBMS_OUTPUT.PUT_LINE('소속 사원 수: ' || empCnt);
END;
/



/* Q5 */
CREATE OR REPLACE TRIGGER SHOPS_INPUT
BEFORE INSERT ON SHOPS
FOR EACH ROW
DECLARE
  v_total_profit SHOPS.SHOP_PROFIT%TYPE;
  v_total_cost SHOPS.SHOP_COST%TYPE;
  v_net_profit NUMBER;
BEGIN
  SELECT SUM(SHOP_PROFIT), SUM(SHOP_COST) INTO v_total_profit, v_total_cost FROM SHOPS;
  
  v_net_profit := v_total_profit - v_total_cost;

  DBMS_OUTPUT.PUT_LINE('<INSERT문이 실행되기 전까지의 손익 현황>');
  DBMS_OUTPUT.PUT_LINE('총 수익: ' || v_total_profit);
  DBMS_OUTPUT.PUT_LINE('총 비용: ' || v_total_cost);
  DBMS_OUTPUT.PUT_LINE('총 순이익: ' || v_net_profit);
END;
/

SET SERVEROUTPUT ON;

INSERT INTO SHOPS VALUES (500, '동국상점5', 2500000, 800000);
COMMIT;

spool off;