
CREATE TABLE HACKADEMY
(
	AccessPage            SMALLINT  NOT NULL ,
	EditPermission        SMALLINT  NULL ,
	MemberID              CHAR(10)  NOT NULL 
);



CREATE UNIQUE INDEX XPKHACKADEMY ON HACKADEMY
(MemberID  ASC);



ALTER TABLE HACKADEMY
	ADD CONSTRAINT  XPKHACKADEMY PRIMARY KEY (MemberID);



CREATE TABLE HACKER_TRAINEE
(
	StudyGroupID          CHAR(18)  NOT NULL ,
	EntryCount            INTEGER  NOT NULL ,
	MemberID              CHAR(10)  NOT NULL 
);



CREATE UNIQUE INDEX XPKHACKER_TRAINEE ON HACKER_TRAINEE
(StudyGroupID  ASC);



ALTER TABLE HACKER_TRAINEE
	ADD CONSTRAINT  XPKHACKER_TRAINEE PRIMARY KEY (StudyGroupID);



CREATE TABLE MEMBER
(
	MemberName            CHAR(18)  NOT NULL ,
	Status                CHAR(7)  NOT NULL ,
	EntryPointScore       INTEGER  NULL ,
	HasPaidDues           SMALLINT  NULL ,
	MemberID              CHAR(10)  NOT NULL 
);



CREATE UNIQUE INDEX XPKMEMBER ON MEMBER
(MemberID  ASC);



ALTER TABLE MEMBER
	ADD CONSTRAINT  XPKMEMBER PRIMARY KEY (MemberID);



ALTER TABLE HACKADEMY
	ADD (CONSTRAINT  R_140 FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID));



ALTER TABLE HACKER_TRAINEE
	ADD (CONSTRAINT  R_141 FOREIGN KEY (MemberID) REFERENCES MEMBER(MemberID) ON DELETE SET NULL);



CREATE  TRIGGER tI_HACKADEMY BEFORE INSERT ON HACKADEMY for each row
-- ERwin Builtin Wed Oct 25 16:21:28 2023
-- INSERT trigger on HACKADEMY 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
    /* MEMBER  HACKADEMY on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000eeac", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKADEMY"
    P2C_VERB_PHRASE="R/140", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="MemberID" */
    SELECT count(*) INTO NUMROWS
      FROM MEMBER
      WHERE
        /* %JoinFKPK(:%New,MEMBER," = "," AND") */
        :new.MemberID = MEMBER.MemberID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert HACKADEMY because MEMBER does not exist.'
      );
    END IF;


-- ERwin Builtin Wed Oct 25 16:21:28 2023
END;
/

CREATE  TRIGGER tU_HACKADEMY AFTER UPDATE ON HACKADEMY for each row
-- ERwin Builtin Wed Oct 25 16:21:28 2023
-- UPDATE trigger on HACKADEMY 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
  /* MEMBER  HACKADEMY on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000eff6", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKADEMY"
    P2C_VERB_PHRASE="R/140", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="MemberID" */
  SELECT count(*) INTO NUMROWS
    FROM MEMBER
    WHERE
      /* %JoinFKPK(:%New,MEMBER," = "," AND") */
      :new.MemberID = MEMBER.MemberID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update HACKADEMY because MEMBER does not exist.'
    );
  END IF;


-- ERwin Builtin Wed Oct 25 16:21:28 2023
END;
/


CREATE  TRIGGER tI_HACKER_TRAINEE BEFORE INSERT ON HACKER_TRAINEE for each row
-- ERwin Builtin Wed Oct 25 16:21:28 2023
-- INSERT trigger on HACKER_TRAINEE 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
    /* MEMBER  HACKER_TRAINEE on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00010e3c", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKER_TRAINEE"
    P2C_VERB_PHRASE="R/141", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="MemberID" */
    UPDATE HACKER_TRAINEE
      SET
        /* %SetFK(HACKER_TRAINEE,NULL) */
        HACKER_TRAINEE.MemberID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM MEMBER
            WHERE
              /* %JoinFKPK(:%New,MEMBER," = "," AND") */
              :new.MemberID = MEMBER.MemberID
        ) 
        /* %JoinPKPK(HACKER_TRAINEE,:%New," = "," AND") */
         and HACKER_TRAINEE.StudyGroupID = :new.StudyGroupID;


-- ERwin Builtin Wed Oct 25 16:21:28 2023
END;
/

CREATE  TRIGGER tU_HACKER_TRAINEE AFTER UPDATE ON HACKER_TRAINEE for each row
-- ERwin Builtin Wed Oct 25 16:21:28 2023
-- UPDATE trigger on HACKER_TRAINEE 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
  /* MEMBER  HACKER_TRAINEE on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00010553", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKER_TRAINEE"
    P2C_VERB_PHRASE="R/141", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="MemberID" */
  SELECT count(*) INTO NUMROWS
    FROM MEMBER
    WHERE
      /* %JoinFKPK(:%New,MEMBER," = "," AND") */
      :new.MemberID = MEMBER.MemberID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.MemberID IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update HACKER_TRAINEE because MEMBER does not exist.'
    );
  END IF;


-- ERwin Builtin Wed Oct 25 16:21:28 2023
END;
/


CREATE  TRIGGER tD_MEMBER AFTER DELETE ON MEMBER for each row
-- ERwin Builtin Wed Oct 25 16:21:28 2023
-- DELETE trigger on MEMBER 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
    /* MEMBER  HACKADEMY on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001c280", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKADEMY"
    P2C_VERB_PHRASE="R/140", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="MemberID" */
    SELECT count(*) INTO NUMROWS
      FROM HACKADEMY
      WHERE
        /*  %JoinFKPK(HACKADEMY,:%Old," = "," AND") */
        HACKADEMY.MemberID = :old.MemberID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete MEMBER because HACKADEMY exists.'
      );
    END IF;

    /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
    /* MEMBER  HACKER_TRAINEE on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKER_TRAINEE"
    P2C_VERB_PHRASE="R/141", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="MemberID" */
    UPDATE HACKER_TRAINEE
      SET
        /* %SetFK(HACKER_TRAINEE,NULL) */
        HACKER_TRAINEE.MemberID = NULL
      WHERE
        /* %JoinFKPK(HACKER_TRAINEE,:%Old," = "," AND") */
        HACKER_TRAINEE.MemberID = :old.MemberID;


-- ERwin Builtin Wed Oct 25 16:21:28 2023
END;
/

CREATE  TRIGGER tU_MEMBER AFTER UPDATE ON MEMBER for each row
-- ERwin Builtin Wed Oct 25 16:21:28 2023
-- UPDATE trigger on MEMBER 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Wed Oct 25 16:21:28 2023 */
  /* MEMBER  HACKADEMY on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00020703", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKADEMY"
    P2C_VERB_PHRASE="R/140", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_140", FK_COLUMNS="MemberID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MemberID <> :new.MemberID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM HACKADEMY
      WHERE
        /*  %JoinFKPK(HACKADEMY,:%Old," = "," AND") */
        HACKADEMY.MemberID = :old.MemberID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update MEMBER because HACKADEMY exists.'
      );
    END IF;
  END IF;

  /* MEMBER  HACKER_TRAINEE on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="MEMBER"
    CHILD_OWNER="", CHILD_TABLE="HACKER_TRAINEE"
    P2C_VERB_PHRASE="R/141", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_141", FK_COLUMNS="MemberID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MemberID <> :new.MemberID
  THEN
    UPDATE HACKER_TRAINEE
      SET
        /* %SetFK(HACKER_TRAINEE,NULL) */
        HACKER_TRAINEE.MemberID = NULL
      WHERE
        /* %JoinFKPK(HACKER_TRAINEE,:%Old," = ",",") */
        HACKER_TRAINEE.MemberID = :old.MemberID;
  END IF;


-- ERwin Builtin Wed Oct 25 16:21:28 2023
END;
/

