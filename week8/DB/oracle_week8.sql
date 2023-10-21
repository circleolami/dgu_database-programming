spool C:\Users\circl\Documents\2023-2\database_programming\week8\oracle_week8.txt;
-- Q1.
ALTER TABLE ARTIST08 
ADD CONSTRAINT ARTIST_NATIONALITY CHECK 
(nationality IN ('Spanish', 'Russian', 'German', 'French', 'United States'));

INSERT INTO ARTIST08 (artistid, lastname, firstname, nationality, dateofbirth, datedeceased) values (10440, 'Miro3', 'Joan3', 'Japan', 1900, 1983);

-- Q2. 
ALTER TABLE ARTIST08 
MODIFY nationality CHAR(30) DEFAULT 'United States';

INSERT INTO ARTIST08 (artistid, lastname, firstname, dateofbirth, datedeceased) values(10441, 'Miro4', 'Joan4', 1910, 1985);

SELECT * FROM ARTIST08;

-- Q3. 
DESC ARTIST08;

ALTER TABLE ARTIST08
MODIFY dateofbirth NUMBER(4) NOT NULL;

DESC ARTIST08;

-- Q4. 
SELECT s.sname, s.age
FROM SAILOR08 s
WHERE NOT EXISTS (
    SELECT b.bid
    FROM BOAT08 b
    MINUS
    SELECT r.bid
    FROM RESERVE08 r
    WHERE r.sid = s.sid
);

-- Q5.
DESC EMPLOYEE08;

ALTER TABLE EMPLOYEE08 RENAME TO EMPLOYEE08_V2;
ALTER TABLE EMPLOYEE08_V2 DROP COLUMN budget;
ALTER TABLE EMPLOYEE08_V2 ADD age NUMBER(3);

DESC EMPLOYEE08_V2;

spool off;