
CREATE TABLE W5_DEPARTMENTS
(
	Dno                   NUMBER  NOT NULL ,
	Dname                 CHAR(25)  NOT NULL ,
	DBudget               NUMBER  NOT NULL  CONSTRAINT  department_dbudget_784439241 CHECK (DBudget
BETWEEN
200000000 AND
600000000)
);



CREATE UNIQUE INDEX XPKW5_DEPARTMENTS ON W5_DEPARTMENTS
(Dno  ASC);



ALTER TABLE W5_DEPARTMENTS
	ADD CONSTRAINT  XPKW5_DEPARTMENTS PRIMARY KEY (Dno);



CREATE TABLE W5_DEPENDENTS
(
	Name                  CHAR(18)  NOT NULL ,
	Eno                   NUMBER  NOT NULL ,
	Age                   NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_DEPENDENTS ON W5_DEPENDENTS
(Name  ASC,Eno  ASC);



ALTER TABLE W5_DEPENDENTS
	ADD CONSTRAINT  XPKW5_DEPENDENTS PRIMARY KEY (Name,Eno);



CREATE TABLE W5_EMPLOYEES
(
	Eno                   NUMBER   DEFAULT  1 NOT NULL ,
	Ename                 CHAR(18)  NOT NULL ,
	Salary                NUMBER  NOT NULL  CONSTRAINT  employees_salary_301039442 CHECK (Salary
BETWEEN 2000000
AND 6000000),
	Age                   NUMBER  NOT NULL ,
	Hiredate              DATE  NOT NULL ,
	Manager               NUMBER  NOT NULL ,
	Dno                   NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_EMPLOYEES ON W5_EMPLOYEES
(Eno  ASC);



ALTER TABLE W5_EMPLOYEES
	ADD CONSTRAINT  XPKW5_EMPLOYEES PRIMARY KEY (Eno);



CREATE TABLE W5_OFFICES
(
	One                   NUMBER  NOT NULL ,
	Area                  CHAR(20)  NOT NULL ,
	Floor                 NUMBER  NOT NULL  CONSTRAINT  offices_floor_1970824790 CHECK (Floor
IN ( 1, 2, 3, 4, 5, 6,
7, 8, 9)),
	Dno                   NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_OFFICES ON W5_OFFICES
(One  ASC);



ALTER TABLE W5_OFFICES
	ADD CONSTRAINT  XPKW5_OFFICES PRIMARY KEY (One);



CREATE TABLE W5_PHONES
(
	PhoneNo               CHAR(12)  NOT NULL ,
	One                   NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_PHONES ON W5_PHONES
(PhoneNo  ASC,One  ASC);



ALTER TABLE W5_PHONES
	ADD CONSTRAINT  XPKW5_PHONES PRIMARY KEY (PhoneNo,One);



CREATE TABLE W5_PROJECTS
(
	Pno                   NUMBER  NOT NULL ,
	Dno                   NUMBER  NOT NULL ,
	Pname                 CHAR(18)  NOT NULL ,
	PBudget               NUMBER   DEFAULT  20000000 NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_PROJECTS ON W5_PROJECTS
(Pno  ASC);



ALTER TABLE W5_PROJECTS
	ADD CONSTRAINT  XPKW5_PROJECTS PRIMARY KEY (Pno);



ALTER TABLE W5_DEPENDENTS
	ADD (CONSTRAINT  R_125 FOREIGN KEY (Eno) REFERENCES W5_EMPLOYEES(Eno));



ALTER TABLE W5_EMPLOYEES
	ADD (CONSTRAINT  R_126 FOREIGN KEY (Dno) REFERENCES W5_DEPARTMENTS(Dno));



ALTER TABLE W5_EMPLOYEES
	ADD (CONSTRAINT  R_129 FOREIGN KEY (Eno) REFERENCES W5_EMPLOYEES(Eno) ON DELETE SET NULL);



ALTER TABLE W5_OFFICES
	ADD (CONSTRAINT  R_127 FOREIGN KEY (Dno) REFERENCES W5_DEPARTMENTS(Dno));



ALTER TABLE W5_PHONES
	ADD (CONSTRAINT  R_128 FOREIGN KEY (One) REFERENCES W5_OFFICES(One));



ALTER TABLE W5_PROJECTS
	ADD (CONSTRAINT  R_122 FOREIGN KEY (Dno) REFERENCES W5_DEPARTMENTS(Dno));



CREATE  TRIGGER tD_W5_DEPARTMENTS AFTER DELETE ON W5_DEPARTMENTS for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- DELETE trigger on W5_DEPARTMENTS 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_DEPARTMENTS  W5_PROJECTS on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0002f0d9", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_PROJECTS"
    P2C_VERB_PHRASE="R/122", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_122", FK_COLUMNS="Dno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_PROJECTS
      WHERE
        /*  %JoinFKPK(W5_PROJECTS,:%Old," = "," AND") */
        W5_PROJECTS.Dno = :old.Dno;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_DEPARTMENTS because W5_PROJECTS exists.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_DEPARTMENTS  W5_EMPLOYEES on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_126", FK_COLUMNS="Dno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_EMPLOYEES
      WHERE
        /*  %JoinFKPK(W5_EMPLOYEES,:%Old," = "," AND") */
        W5_EMPLOYEES.Dno = :old.Dno;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_DEPARTMENTS because W5_EMPLOYEES exists.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_DEPARTMENTS  W5_OFFICES on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_OFFICES"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_127", FK_COLUMNS="Dno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_OFFICES
      WHERE
        /*  %JoinFKPK(W5_OFFICES,:%Old," = "," AND") */
        W5_OFFICES.Dno = :old.Dno;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_DEPARTMENTS because W5_OFFICES exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tU_W5_DEPARTMENTS AFTER UPDATE ON W5_DEPARTMENTS for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- UPDATE trigger on W5_DEPARTMENTS 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_DEPARTMENTS  W5_PROJECTS on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00034fd4", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_PROJECTS"
    P2C_VERB_PHRASE="R/122", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_122", FK_COLUMNS="Dno" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Dno <> :new.Dno
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_PROJECTS
      WHERE
        /*  %JoinFKPK(W5_PROJECTS,:%Old," = "," AND") */
        W5_PROJECTS.Dno = :old.Dno;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_DEPARTMENTS because W5_PROJECTS exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_DEPARTMENTS  W5_EMPLOYEES on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_126", FK_COLUMNS="Dno" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Dno <> :new.Dno
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_EMPLOYEES
      WHERE
        /*  %JoinFKPK(W5_EMPLOYEES,:%Old," = "," AND") */
        W5_EMPLOYEES.Dno = :old.Dno;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_DEPARTMENTS because W5_EMPLOYEES exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_DEPARTMENTS  W5_OFFICES on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_OFFICES"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_127", FK_COLUMNS="Dno" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Dno <> :new.Dno
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_OFFICES
      WHERE
        /*  %JoinFKPK(W5_OFFICES,:%Old," = "," AND") */
        W5_OFFICES.Dno = :old.Dno;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_DEPARTMENTS because W5_OFFICES exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/


CREATE  TRIGGER tI_W5_DEPENDENTS BEFORE INSERT ON W5_DEPENDENTS for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- INSERT trigger on W5_DEPENDENTS 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_EMPLOYEES  W5_DEPENDENTS on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="000101e7", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_DEPENDENTS"
    P2C_VERB_PHRASE="R/125", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_125", FK_COLUMNS="Eno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_EMPLOYEES
      WHERE
        /* %JoinFKPK(:%New,W5_EMPLOYEES," = "," AND") */
        :new.Eno = W5_EMPLOYEES.Eno;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_DEPENDENTS because W5_EMPLOYEES does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tU_W5_DEPENDENTS AFTER UPDATE ON W5_DEPENDENTS for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- UPDATE trigger on W5_DEPENDENTS 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_EMPLOYEES  W5_DEPENDENTS on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000fde1", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_DEPENDENTS"
    P2C_VERB_PHRASE="R/125", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_125", FK_COLUMNS="Eno" */
  SELECT count(*) INTO NUMROWS
    FROM W5_EMPLOYEES
    WHERE
      /* %JoinFKPK(:%New,W5_EMPLOYEES," = "," AND") */
      :new.Eno = W5_EMPLOYEES.Eno;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_DEPENDENTS because W5_EMPLOYEES does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/


CREATE  TRIGGER tI_W5_EMPLOYEES BEFORE INSERT ON W5_EMPLOYEES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- INSERT trigger on W5_EMPLOYEES 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_DEPARTMENTS  W5_EMPLOYEES on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="000209f7", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_126", FK_COLUMNS="Dno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_DEPARTMENTS
      WHERE
        /* %JoinFKPK(:%New,W5_DEPARTMENTS," = "," AND") */
        :new.Dno = W5_DEPARTMENTS.Dno;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_EMPLOYEES because W5_DEPARTMENTS does not exist.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_EMPLOYEES  W5_EMPLOYEES on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_129", FK_COLUMNS="Eno" */
    UPDATE W5_EMPLOYEES
      SET
        /* %SetFK(W5_EMPLOYEES,NULL) */
        W5_EMPLOYEES.Eno = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM W5_EMPLOYEES
            WHERE
              /* %JoinFKPK(:%New,W5_EMPLOYEES," = "," AND") */
              :new.Eno = W5_EMPLOYEES.Eno
        ) 
        /* %JoinPKPK(W5_EMPLOYEES,:%New," = "," AND") */
         and W5_EMPLOYEES.Eno = :new.Eno;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tD_W5_EMPLOYEES AFTER DELETE ON W5_EMPLOYEES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- DELETE trigger on W5_EMPLOYEES 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_EMPLOYEES  W5_DEPENDENTS on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001bd03", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_DEPENDENTS"
    P2C_VERB_PHRASE="R/125", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_125", FK_COLUMNS="Eno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_DEPENDENTS
      WHERE
        /*  %JoinFKPK(W5_DEPENDENTS,:%Old," = "," AND") */
        W5_DEPENDENTS.Eno = :old.Eno;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_EMPLOYEES because W5_DEPENDENTS exists.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_EMPLOYEES  W5_EMPLOYEES on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_129", FK_COLUMNS="Eno" */
    UPDATE W5_EMPLOYEES
      SET
        /* %SetFK(W5_EMPLOYEES,NULL) */
        W5_EMPLOYEES.Eno = NULL
      WHERE
        /* %JoinFKPK(W5_EMPLOYEES,:%Old," = "," AND") */
        W5_EMPLOYEES.Eno = :old.Eno;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tU_W5_EMPLOYEES AFTER UPDATE ON W5_EMPLOYEES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- UPDATE trigger on W5_EMPLOYEES 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_EMPLOYEES  W5_DEPENDENTS on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000415c7", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_DEPENDENTS"
    P2C_VERB_PHRASE="R/125", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_125", FK_COLUMNS="Eno" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Eno <> :new.Eno
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_DEPENDENTS
      WHERE
        /*  %JoinFKPK(W5_DEPENDENTS,:%Old," = "," AND") */
        W5_DEPENDENTS.Eno = :old.Eno;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_EMPLOYEES because W5_DEPENDENTS exists.'
      );
    END IF;
  END IF;

  /* W5_EMPLOYEES  W5_EMPLOYEES on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_129", FK_COLUMNS="Eno" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.Eno <> :new.Eno
  THEN
    UPDATE W5_EMPLOYEES
      SET
        /* %SetFK(W5_EMPLOYEES,NULL) */
        W5_EMPLOYEES.Eno = NULL
      WHERE
        /* %JoinFKPK(W5_EMPLOYEES,:%Old," = ",",") */
        W5_EMPLOYEES.Eno = :old.Eno;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_DEPARTMENTS  W5_EMPLOYEES on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_126", FK_COLUMNS="Dno" */
  SELECT count(*) INTO NUMROWS
    FROM W5_DEPARTMENTS
    WHERE
      /* %JoinFKPK(:%New,W5_DEPARTMENTS," = "," AND") */
      :new.Dno = W5_DEPARTMENTS.Dno;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_EMPLOYEES because W5_DEPARTMENTS does not exist.'
    );
  END IF;

  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_EMPLOYEES  W5_EMPLOYEES on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_EMPLOYEES"
    CHILD_OWNER="", CHILD_TABLE="W5_EMPLOYEES"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_129", FK_COLUMNS="Eno" */
  SELECT count(*) INTO NUMROWS
    FROM W5_EMPLOYEES
    WHERE
      /* %JoinFKPK(:%New,W5_EMPLOYEES," = "," AND") */
      :new.Eno = W5_EMPLOYEES.Eno;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.Eno IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_EMPLOYEES because W5_EMPLOYEES does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/


CREATE  TRIGGER tI_W5_OFFICES BEFORE INSERT ON W5_OFFICES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- INSERT trigger on W5_OFFICES 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_DEPARTMENTS  W5_OFFICES on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f7c7", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_OFFICES"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_127", FK_COLUMNS="Dno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_DEPARTMENTS
      WHERE
        /* %JoinFKPK(:%New,W5_DEPARTMENTS," = "," AND") */
        :new.Dno = W5_DEPARTMENTS.Dno;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_OFFICES because W5_DEPARTMENTS does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tD_W5_OFFICES AFTER DELETE ON W5_OFFICES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- DELETE trigger on W5_OFFICES 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_OFFICES  W5_PHONES on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000da57", PARENT_OWNER="", PARENT_TABLE="W5_OFFICES"
    CHILD_OWNER="", CHILD_TABLE="W5_PHONES"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_128", FK_COLUMNS="One" */
    SELECT count(*) INTO NUMROWS
      FROM W5_PHONES
      WHERE
        /*  %JoinFKPK(W5_PHONES,:%Old," = "," AND") */
        W5_PHONES.One = :old.One;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_OFFICES because W5_PHONES exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tU_W5_OFFICES AFTER UPDATE ON W5_OFFICES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- UPDATE trigger on W5_OFFICES 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_OFFICES  W5_PHONES on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00021a60", PARENT_OWNER="", PARENT_TABLE="W5_OFFICES"
    CHILD_OWNER="", CHILD_TABLE="W5_PHONES"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_128", FK_COLUMNS="One" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.One <> :new.One
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_PHONES
      WHERE
        /*  %JoinFKPK(W5_PHONES,:%Old," = "," AND") */
        W5_PHONES.One = :old.One;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_OFFICES because W5_PHONES exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_DEPARTMENTS  W5_OFFICES on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_OFFICES"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_127", FK_COLUMNS="Dno" */
  SELECT count(*) INTO NUMROWS
    FROM W5_DEPARTMENTS
    WHERE
      /* %JoinFKPK(:%New,W5_DEPARTMENTS," = "," AND") */
      :new.Dno = W5_DEPARTMENTS.Dno;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_OFFICES because W5_DEPARTMENTS does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/


CREATE  TRIGGER tI_W5_PHONES BEFORE INSERT ON W5_PHONES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- INSERT trigger on W5_PHONES 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_OFFICES  W5_PHONES on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ee8e", PARENT_OWNER="", PARENT_TABLE="W5_OFFICES"
    CHILD_OWNER="", CHILD_TABLE="W5_PHONES"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_128", FK_COLUMNS="One" */
    SELECT count(*) INTO NUMROWS
      FROM W5_OFFICES
      WHERE
        /* %JoinFKPK(:%New,W5_OFFICES," = "," AND") */
        :new.One = W5_OFFICES.One;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_PHONES because W5_OFFICES does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tU_W5_PHONES AFTER UPDATE ON W5_PHONES for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- UPDATE trigger on W5_PHONES 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_OFFICES  W5_PHONES on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000f24c", PARENT_OWNER="", PARENT_TABLE="W5_OFFICES"
    CHILD_OWNER="", CHILD_TABLE="W5_PHONES"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_128", FK_COLUMNS="One" */
  SELECT count(*) INTO NUMROWS
    FROM W5_OFFICES
    WHERE
      /* %JoinFKPK(:%New,W5_OFFICES," = "," AND") */
      :new.One = W5_OFFICES.One;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_PHONES because W5_OFFICES does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/


CREATE  TRIGGER tI_W5_PROJECTS BEFORE INSERT ON W5_PROJECTS for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- INSERT trigger on W5_PROJECTS 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
    /* W5_DEPARTMENTS  W5_PROJECTS on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ff6d", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_PROJECTS"
    P2C_VERB_PHRASE="R/122", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_122", FK_COLUMNS="Dno" */
    SELECT count(*) INTO NUMROWS
      FROM W5_DEPARTMENTS
      WHERE
        /* %JoinFKPK(:%New,W5_DEPARTMENTS," = "," AND") */
        :new.Dno = W5_DEPARTMENTS.Dno;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_PROJECTS because W5_DEPARTMENTS does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

CREATE  TRIGGER tU_W5_PROJECTS AFTER UPDATE ON W5_PROJECTS for each row
-- ERwin Builtin Thu Oct 12 17:39:22 2023
-- UPDATE trigger on W5_PROJECTS 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:39:22 2023 */
  /* W5_DEPARTMENTS  W5_PROJECTS on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001031f", PARENT_OWNER="", PARENT_TABLE="W5_DEPARTMENTS"
    CHILD_OWNER="", CHILD_TABLE="W5_PROJECTS"
    P2C_VERB_PHRASE="R/122", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_122", FK_COLUMNS="Dno" */
  SELECT count(*) INTO NUMROWS
    FROM W5_DEPARTMENTS
    WHERE
      /* %JoinFKPK(:%New,W5_DEPARTMENTS," = "," AND") */
      :new.Dno = W5_DEPARTMENTS.Dno;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_PROJECTS because W5_DEPARTMENTS does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:39:22 2023
END;
/

