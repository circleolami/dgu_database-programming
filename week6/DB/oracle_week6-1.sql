
CREATE TABLE ARTIST07
(
	ArtistID              INT  NOT NULL ,
	FirstName             CHAR(25)  NOT NULL ,
	LastName              CHAR(25)  NOT NULL ,
	Nationality           CHAR(30)  NULL  CONSTRAINT  ARTIST07_Nationality_545895331 CHECK (Nationality IN ('Canadian', 'English', 'French', 'German', 'Mexican', 'Russian',
'Spanish', 'United States')),
	DateOfBirth           DECIMAL(4)  NULL  CONSTRAINT  ARTIST07_DateOfBirth_306684739 CHECK (DateOfBirth BETWEEN 1900 AND 2999),
	DateDeceased          DECIMAL(4)  NULL  CONSTRAINT  ARTIST07_DateDeceas_1904242081 CHECK (DateDeceased BETWEEN 1900 AND 2999)
);



CREATE UNIQUE INDEX XPKARTIST07 ON ARTIST07
(ArtistID  ASC);



ALTER TABLE ARTIST07
	ADD CONSTRAINT  XPKARTIST07 PRIMARY KEY (ArtistID);



CREATE TABLE CUSTOMER07
(
	CustomerID            INT  NOT NULL ,
	LantName              CHAR(25)  NOT NULL ,
	FirstName             CHAR(25)  NOT NULL ,
	AreaCode              CHAR(3)  NULL ,
	PhoneNumber           CHAR(11)  NULL ,
	City                  CHAR(35)  NULL ,
	Street                CHAR(30)  NULL ,
	State                 CHAR(2)  NULL ,
	ZipPostalCode         CHAR(9)  NULL ,
	Country               CHAR(50)  NULL ,
	Email                 VARCHAR2(100)  NULL 
);



CREATE UNIQUE INDEX XPKCUSTOMER07 ON CUSTOMER07
(CustomerID  ASC);



ALTER TABLE CUSTOMER07
	ADD CONSTRAINT  XPKCUSTOMER07 PRIMARY KEY (CustomerID);



CREATE TABLE CUSTOMER_ARTIST_INT07
(
	CustomerID            INT  NOT NULL ,
	ArtistID              INT  NOT NULL 
);



CREATE UNIQUE INDEX XPKCUSTOMER_ARTIST_INT07 ON CUSTOMER_ARTIST_INT07
(CustomerID  ASC,ArtistID  ASC);



ALTER TABLE CUSTOMER_ARTIST_INT07
	ADD CONSTRAINT  XPKCUSTOMER_ARTIST_INT07 PRIMARY KEY (CustomerID,ArtistID);



CREATE TABLE TRANS07
(
	TransactionID         INT  NOT NULL ,
	DateAcquired          DATE  NOT NULL ,
	AccuistionPrice       DECIMAL(8,2)  NOT NULL ,
	DateSold              DATE  NULL ,
	SalesPrice            DECIMAL(8,2)  NULL  CONSTRAINT  TRANS07_SalesPrice_801426720 CHECK (SalesPrice > 0 AND SalesPrice <= 500000),
	AskingPrice           DECIMAL(8,2)  NULL ,
	CustomerID            INT  NULL ,
	WorkID                INT  NOT NULL 
);



CREATE UNIQUE INDEX XPKTRANS07 ON TRANS07
(TransactionID  ASC);



ALTER TABLE TRANS07
	ADD CONSTRAINT  XPKTRANS07 PRIMARY KEY (TransactionID);



CREATE TABLE WORK07
(
	WorkID                INT  NOT NULL ,
	ArtistID              INT  NULL ,
	Title                 CHAR(35)  NOT NULL ,
	Copy                  CHAR(12)  NOT NULL ,
	Medium                CHAR(35)  NULL ,
	Description           VARCHAR2(1000)   DEFAULT  'Unknown Provenance' NULL 
);



CREATE UNIQUE INDEX XPKWORK07 ON WORK07
(WorkID  ASC);



ALTER TABLE WORK07
	ADD CONSTRAINT  XPKWORK07 PRIMARY KEY (WorkID);



ALTER TABLE CUSTOMER_ARTIST_INT07
	ADD (CONSTRAINT  R_134 FOREIGN KEY (ArtistID) REFERENCES ARTIST07(ArtistID));



ALTER TABLE CUSTOMER_ARTIST_INT07
	ADD (CONSTRAINT  R_135 FOREIGN KEY (CustomerID) REFERENCES CUSTOMER07(CustomerID));



ALTER TABLE TRANS07
	ADD (CONSTRAINT  R_136 FOREIGN KEY (CustomerID) REFERENCES CUSTOMER07(CustomerID) ON DELETE SET NULL);



ALTER TABLE TRANS07
	ADD (CONSTRAINT  R_139 FOREIGN KEY (WorkID) REFERENCES WORK07(WorkID));



ALTER TABLE WORK07
	ADD (CONSTRAINT  R_137 FOREIGN KEY (ArtistID) REFERENCES ARTIST07(ArtistID) ON DELETE SET NULL);



CREATE  TRIGGER tD_ARTIST07 AFTER DELETE ON ARTIST07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- DELETE trigger on ARTIST07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* ARTIST07  WORK07 on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0001d5f0", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="WORK07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_137", FK_COLUMNS="ArtistID" */
    UPDATE WORK07
      SET
        /* %SetFK(WORK07,NULL) */
        WORK07.ArtistID = NULL
      WHERE
        /* %JoinFKPK(WORK07,:%Old," = "," AND") */
        WORK07.ArtistID = :old.ArtistID;

    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* ARTIST07  CUSTOMER_ARTIST_INT07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/134", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_134", FK_COLUMNS="ArtistID" */
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER_ARTIST_INT07
      WHERE
        /*  %JoinFKPK(CUSTOMER_ARTIST_INT07,:%Old," = "," AND") */
        CUSTOMER_ARTIST_INT07.ArtistID = :old.ArtistID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete ARTIST07 because CUSTOMER_ARTIST_INT07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

CREATE  TRIGGER tU_ARTIST07 AFTER UPDATE ON ARTIST07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- UPDATE trigger on ARTIST07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ARTIST07  WORK07 on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="000229ed", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="WORK07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_137", FK_COLUMNS="ArtistID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ArtistID <> :new.ArtistID
  THEN
    UPDATE WORK07
      SET
        /* %SetFK(WORK07,NULL) */
        WORK07.ArtistID = NULL
      WHERE
        /* %JoinFKPK(WORK07,:%Old," = ",",") */
        WORK07.ArtistID = :old.ArtistID;
  END IF;

  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* ARTIST07  CUSTOMER_ARTIST_INT07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/134", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_134", FK_COLUMNS="ArtistID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ArtistID <> :new.ArtistID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER_ARTIST_INT07
      WHERE
        /*  %JoinFKPK(CUSTOMER_ARTIST_INT07,:%Old," = "," AND") */
        CUSTOMER_ARTIST_INT07.ArtistID = :old.ArtistID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update ARTIST07 because CUSTOMER_ARTIST_INT07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/


CREATE  TRIGGER tD_CUSTOMER07 AFTER DELETE ON CUSTOMER07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- DELETE trigger on CUSTOMER07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* CUSTOMER07  CUSTOMER_ARTIST_INT07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001d043", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/135", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_135", FK_COLUMNS="CustomerID" */
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER_ARTIST_INT07
      WHERE
        /*  %JoinFKPK(CUSTOMER_ARTIST_INT07,:%Old," = "," AND") */
        CUSTOMER_ARTIST_INT07.CustomerID = :old.CustomerID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete CUSTOMER07 because CUSTOMER_ARTIST_INT07 exists.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* CUSTOMER07  TRANS07 on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/136", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_136", FK_COLUMNS="CustomerID" */
    UPDATE TRANS07
      SET
        /* %SetFK(TRANS07,NULL) */
        TRANS07.CustomerID = NULL
      WHERE
        /* %JoinFKPK(TRANS07,:%Old," = "," AND") */
        TRANS07.CustomerID = :old.CustomerID;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

CREATE  TRIGGER tU_CUSTOMER07 AFTER UPDATE ON CUSTOMER07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- UPDATE trigger on CUSTOMER07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* CUSTOMER07  CUSTOMER_ARTIST_INT07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001fed7", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/135", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_135", FK_COLUMNS="CustomerID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.CustomerID <> :new.CustomerID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER_ARTIST_INT07
      WHERE
        /*  %JoinFKPK(CUSTOMER_ARTIST_INT07,:%Old," = "," AND") */
        CUSTOMER_ARTIST_INT07.CustomerID = :old.CustomerID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update CUSTOMER07 because CUSTOMER_ARTIST_INT07 exists.'
      );
    END IF;
  END IF;

  /* CUSTOMER07  TRANS07 on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/136", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_136", FK_COLUMNS="CustomerID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.CustomerID <> :new.CustomerID
  THEN
    UPDATE TRANS07
      SET
        /* %SetFK(TRANS07,NULL) */
        TRANS07.CustomerID = NULL
      WHERE
        /* %JoinFKPK(TRANS07,:%Old," = ",",") */
        TRANS07.CustomerID = :old.CustomerID;
  END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/


CREATE  TRIGGER tI_CUSTOMER_ARTIST_INT07 BEFORE INSERT ON CUSTOMER_ARTIST_INT07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- INSERT trigger on CUSTOMER_ARTIST_INT07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* ARTIST07  CUSTOMER_ARTIST_INT07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="000233df", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/134", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_134", FK_COLUMNS="ArtistID" */
    SELECT count(*) INTO NUMROWS
      FROM ARTIST07
      WHERE
        /* %JoinFKPK(:%New,ARTIST07," = "," AND") */
        :new.ArtistID = ARTIST07.ArtistID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert CUSTOMER_ARTIST_INT07 because ARTIST07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* CUSTOMER07  CUSTOMER_ARTIST_INT07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/135", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_135", FK_COLUMNS="CustomerID" */
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER07
      WHERE
        /* %JoinFKPK(:%New,CUSTOMER07," = "," AND") */
        :new.CustomerID = CUSTOMER07.CustomerID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert CUSTOMER_ARTIST_INT07 because CUSTOMER07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

CREATE  TRIGGER tU_CUSTOMER_ARTIST_INT07 AFTER UPDATE ON CUSTOMER_ARTIST_INT07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- UPDATE trigger on CUSTOMER_ARTIST_INT07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* ARTIST07  CUSTOMER_ARTIST_INT07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0002239d", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/134", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_134", FK_COLUMNS="ArtistID" */
  SELECT count(*) INTO NUMROWS
    FROM ARTIST07
    WHERE
      /* %JoinFKPK(:%New,ARTIST07," = "," AND") */
      :new.ArtistID = ARTIST07.ArtistID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update CUSTOMER_ARTIST_INT07 because ARTIST07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* CUSTOMER07  CUSTOMER_ARTIST_INT07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ARTIST_INT07"
    P2C_VERB_PHRASE="R/135", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_135", FK_COLUMNS="CustomerID" */
  SELECT count(*) INTO NUMROWS
    FROM CUSTOMER07
    WHERE
      /* %JoinFKPK(:%New,CUSTOMER07," = "," AND") */
      :new.CustomerID = CUSTOMER07.CustomerID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update CUSTOMER_ARTIST_INT07 because CUSTOMER07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/


CREATE  TRIGGER tI_TRANS07 BEFORE INSERT ON TRANS07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- INSERT trigger on TRANS07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* CUSTOMER07  TRANS07 on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00020763", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/136", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_136", FK_COLUMNS="CustomerID" */
    UPDATE TRANS07
      SET
        /* %SetFK(TRANS07,NULL) */
        TRANS07.CustomerID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM CUSTOMER07
            WHERE
              /* %JoinFKPK(:%New,CUSTOMER07," = "," AND") */
              :new.CustomerID = CUSTOMER07.CustomerID
        ) 
        /* %JoinPKPK(TRANS07,:%New," = "," AND") */
         and TRANS07.TransactionID = :new.TransactionID;

    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* WORK07  TRANS07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="WORK07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/139", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_139", FK_COLUMNS="WorkID" */
    SELECT count(*) INTO NUMROWS
      FROM WORK07
      WHERE
        /* %JoinFKPK(:%New,WORK07," = "," AND") */
        :new.WorkID = WORK07.WorkID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert TRANS07 because WORK07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

CREATE  TRIGGER tU_TRANS07 AFTER UPDATE ON TRANS07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- UPDATE trigger on TRANS07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* CUSTOMER07  TRANS07 on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000207b4", PARENT_OWNER="", PARENT_TABLE="CUSTOMER07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/136", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_136", FK_COLUMNS="CustomerID" */
  SELECT count(*) INTO NUMROWS
    FROM CUSTOMER07
    WHERE
      /* %JoinFKPK(:%New,CUSTOMER07," = "," AND") */
      :new.CustomerID = CUSTOMER07.CustomerID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.CustomerID IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update TRANS07 because CUSTOMER07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* WORK07  TRANS07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="WORK07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/139", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_139", FK_COLUMNS="WorkID" */
  SELECT count(*) INTO NUMROWS
    FROM WORK07
    WHERE
      /* %JoinFKPK(:%New,WORK07," = "," AND") */
      :new.WorkID = WORK07.WorkID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update TRANS07 because WORK07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/


CREATE  TRIGGER tI_WORK07 BEFORE INSERT ON WORK07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- INSERT trigger on WORK07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* ARTIST07  WORK07 on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0000f60d", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="WORK07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_137", FK_COLUMNS="ArtistID" */
    UPDATE WORK07
      SET
        /* %SetFK(WORK07,NULL) */
        WORK07.ArtistID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM ARTIST07
            WHERE
              /* %JoinFKPK(:%New,ARTIST07," = "," AND") */
              :new.ArtistID = ARTIST07.ArtistID
        ) 
        /* %JoinPKPK(WORK07,:%New," = "," AND") */
         and WORK07.WorkID = :new.WorkID;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

CREATE  TRIGGER tD_WORK07 AFTER DELETE ON WORK07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- DELETE trigger on WORK07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
    /* WORK07  TRANS07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000d635", PARENT_OWNER="", PARENT_TABLE="WORK07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/139", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_139", FK_COLUMNS="WorkID" */
    SELECT count(*) INTO NUMROWS
      FROM TRANS07
      WHERE
        /*  %JoinFKPK(TRANS07,:%Old," = "," AND") */
        TRANS07.WorkID = :old.WorkID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete WORK07 because TRANS07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

CREATE  TRIGGER tU_WORK07 AFTER UPDATE ON WORK07 for each row
-- ERwin Builtin Mon Oct 16 19:53:01 2023
-- UPDATE trigger on WORK07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* WORK07  TRANS07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00020daa", PARENT_OWNER="", PARENT_TABLE="WORK07"
    CHILD_OWNER="", CHILD_TABLE="TRANS07"
    P2C_VERB_PHRASE="R/139", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_139", FK_COLUMNS="WorkID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.WorkID <> :new.WorkID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM TRANS07
      WHERE
        /*  %JoinFKPK(TRANS07,:%Old," = "," AND") */
        TRANS07.WorkID = :old.WorkID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update WORK07 because TRANS07 exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Mon Oct 16 19:53:01 2023 */
  /* ARTIST07  WORK07 on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ARTIST07"
    CHILD_OWNER="", CHILD_TABLE="WORK07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_137", FK_COLUMNS="ArtistID" */
  SELECT count(*) INTO NUMROWS
    FROM ARTIST07
    WHERE
      /* %JoinFKPK(:%New,ARTIST07," = "," AND") */
      :new.ArtistID = ARTIST07.ArtistID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.ArtistID IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update WORK07 because ARTIST07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 19:53:01 2023
END;
/

