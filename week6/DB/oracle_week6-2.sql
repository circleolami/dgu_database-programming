
CREATE TABLE DRIVER07
(
	FirstName             CHAR(25)  NOT NULL ,
	LastName              CHAR(25)  NOT NULL ,
	Address               CHAR(25)  NOT NULL ,
	City                  CHAR(35)  NOT NULL ,
	State                 CHAR(2)  NOT NULL ,
	ZipCode               CHAR(9)  NOT NULL ,
	Sex                   CHAR(1)  NOT NULL ,
	DriverLicenseNumber   INT  NOT NULL ,
	BirthDate             DATE  NOT NULL ,
	HGT                   INTEGER  NOT NULL ,
	WGT                   CHAR(2)  NOT NULL ,
	EYES                  INTEGER  NOT NULL ,
	DriverSignature       ORDImage  NOT NULL 
);



CREATE UNIQUE INDEX XPKDRIVER07 ON DRIVER07
(DriverLicenseNumber  ASC);



ALTER TABLE DRIVER07
	ADD CONSTRAINT  XPKDRIVER07 PRIMARY KEY (DriverLicenseNumber);



CREATE TABLE OFFICE07
(
	OfficerPersonalNumber  DECIMAL(3)  NOT NULL ,
	OfficerSignature      ORDImage  NOT NULL 
);



CREATE UNIQUE INDEX XPKOFFICE07 ON OFFICE07
(OfficerPersonalNumber  ASC);



ALTER TABLE OFFICE07
	ADD CONSTRAINT  XPKOFFICE07 PRIMARY KEY (OfficerPersonalNumber);



CREATE TABLE VEHICLE07
(
	VIN                   CHAR(6)  NOT NULL ,
	VehicleLicense        CHAR(16)  NOT NULL ,
	State                 CHAR(2)  NOT NULL ,
	Color                 CHAR(18)  NULL ,
	Year                  DECIMAL(2)  NOT NULL ,
	Make                  CHAR(18)  NOT NULL ,
	Type                  CHAR(18)  NOT NULL ,
	RegistedOwner         CHAR(18)  NOT NULL ,
	Address               CHAR(18)  NULL 
);



CREATE UNIQUE INDEX XPKVEHICLE07 ON VEHICLE07
(VIN  ASC);



ALTER TABLE VEHICLE07
	ADD CONSTRAINT  XPKVEHICLE07 PRIMARY KEY (VIN);



CREATE TABLE VIOLATION07
(
	ViolationNumber       CHAR(18)  NOT NULL ,
	Month                 DECIMAL(2)  NOT NULL ,
	Day                   DECIMAL(2)  NOT NULL ,
	Year                  DECIMAL(2)  NOT NULL ,
	TimeHour              DECIMAL(4)  NOT NULL ,
	Dist                  DECIMAL(1)  NOT NULL ,
	Detach                DECIMAL(2)  NOT NULL ,
	Miles                 INTEGER  NOT NULL ,
	Direction             CHAR(1)  NOT NULL ,
	ReferenceLocation     CHAR(18)  NOT NULL ,
	StreetName            CHAR(5)  NOT NULL ,
	DriverLicenseNumber   INTEGER  NOT NULL ,
	OfficerPersonalNumber  DECIMAL(3)  NOT NULL ,
	VIN                   CHAR(6)  NOT NULL ,
	WarningLevel          CHAR(1)  NOT NULL 
);



CREATE UNIQUE INDEX XPKVIOLATION07 ON VIOLATION07
(ViolationNumber  ASC);



ALTER TABLE VIOLATION07
	ADD CONSTRAINT  XPKVIOLATION07 PRIMARY KEY (ViolationNumber);



CREATE TABLE VIOLATION_DETAIL07
(
	ViolationItem         CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKVIOLATION_DETAIL07 ON VIOLATION_DETAIL07
(ViolationItem  ASC);



ALTER TABLE VIOLATION_DETAIL07
	ADD CONSTRAINT  XPKVIOLATION_DETAIL07 PRIMARY KEY (ViolationItem);



CREATE TABLE VIOLATION_ENROLL07
(
	ViolationNumber       CHAR(18)  NOT NULL ,
	ViolationItem         CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKVIOLATION_ENROLL07 ON VIOLATION_ENROLL07
(ViolationNumber  ASC,ViolationItem  ASC);



ALTER TABLE VIOLATION_ENROLL07
	ADD CONSTRAINT  XPKVIOLATION_ENROLL07 PRIMARY KEY (ViolationNumber,ViolationItem);



ALTER TABLE VIOLATION07
	ADD (CONSTRAINT  R_148 FOREIGN KEY (DriverLicenseNumber) REFERENCES DRIVER07(DriverLicenseNumber));



ALTER TABLE VIOLATION07
	ADD (CONSTRAINT  R_149 FOREIGN KEY (VIN) REFERENCES VEHICLE07(VIN));



ALTER TABLE VIOLATION07
	ADD (CONSTRAINT  R_140 FOREIGN KEY (OfficerPersonalNumber) REFERENCES OFFICE07(OfficerPersonalNumber));



ALTER TABLE VIOLATION_ENROLL07
	ADD (CONSTRAINT  R_141 FOREIGN KEY (ViolationNumber) REFERENCES VIOLATION07(ViolationNumber));



ALTER TABLE VIOLATION_ENROLL07
	ADD (CONSTRAINT  R_144 FOREIGN KEY (ViolationItem) REFERENCES VIOLATION_DETAIL07(ViolationItem));



CREATE  TRIGGER tD_DRIVER07 AFTER DELETE ON DRIVER07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- DELETE trigger on DRIVER07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* DRIVER07 Given VIOLATION07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f624", PARENT_OWNER="", PARENT_TABLE="DRIVER07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_148", FK_COLUMNS="DriverLicenseNumber" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /*  %JoinFKPK(VIOLATION07,:%Old," = "," AND") */
        VIOLATION07.DriverLicenseNumber = :old.DriverLicenseNumber;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete DRIVER07 because VIOLATION07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tU_DRIVER07 AFTER UPDATE ON DRIVER07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- UPDATE trigger on DRIVER07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* DRIVER07 Given VIOLATION07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00012dc7", PARENT_OWNER="", PARENT_TABLE="DRIVER07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_148", FK_COLUMNS="DriverLicenseNumber" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.DriverLicenseNumber <> :new.DriverLicenseNumber
  THEN
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /*  %JoinFKPK(VIOLATION07,:%Old," = "," AND") */
        VIOLATION07.DriverLicenseNumber = :old.DriverLicenseNumber;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update DRIVER07 because VIOLATION07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/


CREATE  TRIGGER tD_OFFICE07 AFTER DELETE ON OFFICE07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- DELETE trigger on OFFICE07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* OFFICE07 Issue VIOLATION07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f935", PARENT_OWNER="", PARENT_TABLE="OFFICE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Issued", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="OfficerPersonalNumber" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /*  %JoinFKPK(VIOLATION07,:%Old," = "," AND") */
        VIOLATION07.OfficerPersonalNumber = :old.OfficerPersonalNumber;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete OFFICE07 because VIOLATION07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tU_OFFICE07 AFTER UPDATE ON OFFICE07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- UPDATE trigger on OFFICE07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* OFFICE07 Issue VIOLATION07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00012bfe", PARENT_OWNER="", PARENT_TABLE="OFFICE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Issued", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="OfficerPersonalNumber" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.OfficerPersonalNumber <> :new.OfficerPersonalNumber
  THEN
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /*  %JoinFKPK(VIOLATION07,:%Old," = "," AND") */
        VIOLATION07.OfficerPersonalNumber = :old.OfficerPersonalNumber;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update OFFICE07 because VIOLATION07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/


CREATE  TRIGGER tD_VEHICLE07 AFTER DELETE ON VEHICLE07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- DELETE trigger on VEHICLE07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* VEHICLE07 Given VIOLATION07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000df7e", PARENT_OWNER="", PARENT_TABLE="VEHICLE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_149", FK_COLUMNS="VIN" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /*  %JoinFKPK(VIOLATION07,:%Old," = "," AND") */
        VIOLATION07.VIN = :old.VIN;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete VEHICLE07 because VIOLATION07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tU_VEHICLE07 AFTER UPDATE ON VEHICLE07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- UPDATE trigger on VEHICLE07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* VEHICLE07 Given VIOLATION07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010197", PARENT_OWNER="", PARENT_TABLE="VEHICLE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_149", FK_COLUMNS="VIN" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.VIN <> :new.VIN
  THEN
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /*  %JoinFKPK(VIOLATION07,:%Old," = "," AND") */
        VIOLATION07.VIN = :old.VIN;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update VEHICLE07 because VIOLATION07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/


CREATE  TRIGGER tI_VIOLATION07 BEFORE INSERT ON VIOLATION07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- INSERT trigger on VIOLATION07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* DRIVER07 Given VIOLATION07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00035bc4", PARENT_OWNER="", PARENT_TABLE="DRIVER07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_148", FK_COLUMNS="DriverLicenseNumber" */
    SELECT count(*) INTO NUMROWS
      FROM DRIVER07
      WHERE
        /* %JoinFKPK(:%New,DRIVER07," = "," AND") */
        :new.DriverLicenseNumber = DRIVER07.DriverLicenseNumber;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert VIOLATION07 because DRIVER07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* VEHICLE07 Given VIOLATION07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="VEHICLE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_149", FK_COLUMNS="VIN" */
    SELECT count(*) INTO NUMROWS
      FROM VEHICLE07
      WHERE
        /* %JoinFKPK(:%New,VEHICLE07," = "," AND") */
        :new.VIN = VEHICLE07.VIN;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert VIOLATION07 because VEHICLE07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* OFFICE07 Issue VIOLATION07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="OFFICE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Issued", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="OfficerPersonalNumber" */
    SELECT count(*) INTO NUMROWS
      FROM OFFICE07
      WHERE
        /* %JoinFKPK(:%New,OFFICE07," = "," AND") */
        :new.OfficerPersonalNumber = OFFICE07.OfficerPersonalNumber;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert VIOLATION07 because OFFICE07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tD_VIOLATION07 AFTER DELETE ON VIOLATION07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- DELETE trigger on VIOLATION07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* VIOLATION07 Include VIOLATION_ENROLL07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00011110", PARENT_OWNER="", PARENT_TABLE="VIOLATION07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Included", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="ViolationNumber" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION_ENROLL07
      WHERE
        /*  %JoinFKPK(VIOLATION_ENROLL07,:%Old," = "," AND") */
        VIOLATION_ENROLL07.ViolationNumber = :old.ViolationNumber;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete VIOLATION07 because VIOLATION_ENROLL07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tU_VIOLATION07 AFTER UPDATE ON VIOLATION07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- UPDATE trigger on VIOLATION07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* VIOLATION07 Include VIOLATION_ENROLL07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00047faf", PARENT_OWNER="", PARENT_TABLE="VIOLATION07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Included", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="ViolationNumber" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ViolationNumber <> :new.ViolationNumber
  THEN
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION_ENROLL07
      WHERE
        /*  %JoinFKPK(VIOLATION_ENROLL07,:%Old," = "," AND") */
        VIOLATION_ENROLL07.ViolationNumber = :old.ViolationNumber;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update VIOLATION07 because VIOLATION_ENROLL07 exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* DRIVER07 Given VIOLATION07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="DRIVER07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_148", FK_COLUMNS="DriverLicenseNumber" */
  SELECT count(*) INTO NUMROWS
    FROM DRIVER07
    WHERE
      /* %JoinFKPK(:%New,DRIVER07," = "," AND") */
      :new.DriverLicenseNumber = DRIVER07.DriverLicenseNumber;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update VIOLATION07 because DRIVER07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* VEHICLE07 Given VIOLATION07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="VEHICLE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Target", 
    FK_CONSTRAINT="R_149", FK_COLUMNS="VIN" */
  SELECT count(*) INTO NUMROWS
    FROM VEHICLE07
    WHERE
      /* %JoinFKPK(:%New,VEHICLE07," = "," AND") */
      :new.VIN = VEHICLE07.VIN;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update VIOLATION07 because VEHICLE07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* OFFICE07 Issue VIOLATION07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="OFFICE07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Issued", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="OfficerPersonalNumber" */
  SELECT count(*) INTO NUMROWS
    FROM OFFICE07
    WHERE
      /* %JoinFKPK(:%New,OFFICE07," = "," AND") */
      :new.OfficerPersonalNumber = OFFICE07.OfficerPersonalNumber;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update VIOLATION07 because OFFICE07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/


CREATE  TRIGGER tD_VIOLATION_DETAIL07 AFTER DELETE ON VIOLATION_DETAIL07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- DELETE trigger on VIOLATION_DETAIL07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* VIOLATION_DETAIL07 Assign VIOLATION_ENROLL07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00010da0", PARENT_OWNER="", PARENT_TABLE="VIOLATION_DETAIL07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="R_144", FK_COLUMNS="ViolationItem" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION_ENROLL07
      WHERE
        /*  %JoinFKPK(VIOLATION_ENROLL07,:%Old," = "," AND") */
        VIOLATION_ENROLL07.ViolationItem = :old.ViolationItem;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete VIOLATION_DETAIL07 because VIOLATION_ENROLL07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tU_VIOLATION_DETAIL07 AFTER UPDATE ON VIOLATION_DETAIL07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- UPDATE trigger on VIOLATION_DETAIL07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* VIOLATION_DETAIL07 Assign VIOLATION_ENROLL07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00012c75", PARENT_OWNER="", PARENT_TABLE="VIOLATION_DETAIL07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="R_144", FK_COLUMNS="ViolationItem" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ViolationItem <> :new.ViolationItem
  THEN
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION_ENROLL07
      WHERE
        /*  %JoinFKPK(VIOLATION_ENROLL07,:%Old," = "," AND") */
        VIOLATION_ENROLL07.ViolationItem = :old.ViolationItem;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update VIOLATION_DETAIL07 because VIOLATION_ENROLL07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/


CREATE  TRIGGER tI_VIOLATION_ENROLL07 BEFORE INSERT ON VIOLATION_ENROLL07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- INSERT trigger on VIOLATION_ENROLL07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* VIOLATION07 Include VIOLATION_ENROLL07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00025108", PARENT_OWNER="", PARENT_TABLE="VIOLATION07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Included", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="ViolationNumber" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION07
      WHERE
        /* %JoinFKPK(:%New,VIOLATION07," = "," AND") */
        :new.ViolationNumber = VIOLATION07.ViolationNumber;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert VIOLATION_ENROLL07 because VIOLATION07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
    /* VIOLATION_DETAIL07 Assign VIOLATION_ENROLL07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="VIOLATION_DETAIL07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="R_144", FK_COLUMNS="ViolationItem" */
    SELECT count(*) INTO NUMROWS
      FROM VIOLATION_DETAIL07
      WHERE
        /* %JoinFKPK(:%New,VIOLATION_DETAIL07," = "," AND") */
        :new.ViolationItem = VIOLATION_DETAIL07.ViolationItem;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert VIOLATION_ENROLL07 because VIOLATION_DETAIL07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

CREATE  TRIGGER tU_VIOLATION_ENROLL07 AFTER UPDATE ON VIOLATION_ENROLL07 for each row
-- ERwin Builtin Mon Oct 16 19:51:48 2023
-- UPDATE trigger on VIOLATION_ENROLL07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* VIOLATION07 Include VIOLATION_ENROLL07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00025454", PARENT_OWNER="", PARENT_TABLE="VIOLATION07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Included", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="ViolationNumber" */
  SELECT count(*) INTO NUMROWS
    FROM VIOLATION07
    WHERE
      /* %JoinFKPK(:%New,VIOLATION07," = "," AND") */
      :new.ViolationNumber = VIOLATION07.ViolationNumber;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update VIOLATION_ENROLL07 because VIOLATION07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 19:51:48 2023 */
  /* VIOLATION_DETAIL07 Assign VIOLATION_ENROLL07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="VIOLATION_DETAIL07"
    CHILD_OWNER="", CHILD_TABLE="VIOLATION_ENROLL07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Assigned", 
    FK_CONSTRAINT="R_144", FK_COLUMNS="ViolationItem" */
  SELECT count(*) INTO NUMROWS
    FROM VIOLATION_DETAIL07
    WHERE
      /* %JoinFKPK(:%New,VIOLATION_DETAIL07," = "," AND") */
      :new.ViolationItem = VIOLATION_DETAIL07.ViolationItem;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update VIOLATION_ENROLL07 because VIOLATION_DETAIL07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 19:51:48 2023
END;
/

