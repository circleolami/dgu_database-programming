
CREATE TABLE ACTOR07
(
	ActorID               CHAR(18)  NOT NULL ,
	ActorName             CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKACTOR07 ON ACTOR07
(ActorID  ASC);



ALTER TABLE ACTOR07
	ADD CONSTRAINT  XPKACTOR07 PRIMARY KEY (ActorID);



CREATE TABLE CONTRAST07
(
	MovieID               CHAR(18)  NOT NULL ,
	ActorID               CHAR(18)  NOT NULL ,
	ActorRole             CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKCONTRAST07 ON CONTRAST07
(MovieID  ASC,ActorID  ASC);



ALTER TABLE CONTRAST07
	ADD CONSTRAINT  XPKCONTRAST07 PRIMARY KEY (MovieID,ActorID);



CREATE TABLE DISTANCE07
(
	TheaterID             CHAR(18)  NOT NULL ,
	ReferenceID           CHAR(18)  NOT NULL ,
	Distance              CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKDISTANCE07 ON DISTANCE07
(TheaterID  ASC,ReferenceID  ASC);



ALTER TABLE DISTANCE07
	ADD CONSTRAINT  XPKDISTANCE07 PRIMARY KEY (TheaterID,ReferenceID);



CREATE TABLE MOVIE07
(
	MovieID               CHAR(18)  NOT NULL ,
	MovieName             CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKMOVIE07 ON MOVIE07
(MovieID  ASC);



ALTER TABLE MOVIE07
	ADD CONSTRAINT  XPKMOVIE07 PRIMARY KEY (MovieID);



CREATE TABLE REFERENCE_POINT07
(
	ReferenceID           CHAR(18)  NOT NULL ,
	City                  CHAR(18)  NOT NULL ,
	Part                  CHAR(18)  NOT NULL ,
	State                 CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKREFERENCE_POINT07 ON REFERENCE_POINT07
(ReferenceID  ASC);



ALTER TABLE REFERENCE_POINT07
	ADD CONSTRAINT  XPKREFERENCE_POINT07 PRIMARY KEY (ReferenceID);



CREATE TABLE SHOW_TIME07
(
	MovieID               CHAR(18)  NOT NULL ,
	TheaterID             CHAR(18)  NOT NULL ,
	ShowDate              CHAR(18)  NOT NULL ,
	StartTime             CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKSHOW_TIME07 ON SHOW_TIME07
(MovieID  ASC,TheaterID  ASC,ShowDate  ASC);



ALTER TABLE SHOW_TIME07
	ADD CONSTRAINT  XPKSHOW_TIME07 PRIMARY KEY (MovieID,TheaterID,ShowDate);



CREATE TABLE THEATER07
(
	TheaterID             CHAR(18)  NOT NULL ,
	AddressNumber         CHAR(18)  NULL ,
	NameOfStreet          CHAR(18)  NOT NULL ,
	City                  CHAR(18)  NOT NULL ,
	State                 CHAR(18)  NOT NULL ,
	ZipCode               CHAR(18)  NOT NULL ,
	ContactNumber         CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKTHEATER07 ON THEATER07
(TheaterID  ASC);



ALTER TABLE THEATER07
	ADD CONSTRAINT  XPKTHEATER07 PRIMARY KEY (TheaterID);



ALTER TABLE CONTRAST07
	ADD (CONSTRAINT  R_158 FOREIGN KEY (MovieID) REFERENCES MOVIE07(MovieID));



ALTER TABLE CONTRAST07
	ADD (CONSTRAINT  R_153 FOREIGN KEY (ActorID) REFERENCES ACTOR07(ActorID));



ALTER TABLE DISTANCE07
	ADD (CONSTRAINT  R_151 FOREIGN KEY (TheaterID) REFERENCES THEATER07(TheaterID));



ALTER TABLE DISTANCE07
	ADD (CONSTRAINT  R_152 FOREIGN KEY (ReferenceID) REFERENCES REFERENCE_POINT07(ReferenceID));



ALTER TABLE SHOW_TIME07
	ADD (CONSTRAINT  R_159 FOREIGN KEY (MovieID) REFERENCES MOVIE07(MovieID));



ALTER TABLE SHOW_TIME07
	ADD (CONSTRAINT  R_150 FOREIGN KEY (TheaterID) REFERENCES THEATER07(TheaterID));



CREATE  TRIGGER tD_ACTOR07 AFTER DELETE ON ACTOR07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- DELETE trigger on ACTOR07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* ACTOR07 Movie Contrast CONTRAST07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ed63", PARENT_OWNER="", PARENT_TABLE="ACTOR07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="Reference Actor", 
    FK_CONSTRAINT="R_153", FK_COLUMNS="ActorID" */
    SELECT count(*) INTO NUMROWS
      FROM CONTRAST07
      WHERE
        /*  %JoinFKPK(CONTRAST07,:%Old," = "," AND") */
        CONTRAST07.ActorID = :old.ActorID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete ACTOR07 because CONTRAST07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_ACTOR07 AFTER UPDATE ON ACTOR07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on ACTOR07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* ACTOR07 Movie Contrast CONTRAST07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000112f0", PARENT_OWNER="", PARENT_TABLE="ACTOR07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="Reference Actor", 
    FK_CONSTRAINT="R_153", FK_COLUMNS="ActorID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ActorID <> :new.ActorID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM CONTRAST07
      WHERE
        /*  %JoinFKPK(CONTRAST07,:%Old," = "," AND") */
        CONTRAST07.ActorID = :old.ActorID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update ACTOR07 because CONTRAST07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/


CREATE  TRIGGER tI_CONTRAST07 BEFORE INSERT ON CONTRAST07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- INSERT trigger on CONTRAST07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* MOVIE07 Actor Contrast CONTRAST07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00020336", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_158", FK_COLUMNS="MovieID" */
    SELECT count(*) INTO NUMROWS
      FROM MOVIE07
      WHERE
        /* %JoinFKPK(:%New,MOVIE07," = "," AND") */
        :new.MovieID = MOVIE07.MovieID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert CONTRAST07 because MOVIE07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* ACTOR07 Movie Contrast CONTRAST07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ACTOR07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="Reference Actor", 
    FK_CONSTRAINT="R_153", FK_COLUMNS="ActorID" */
    SELECT count(*) INTO NUMROWS
      FROM ACTOR07
      WHERE
        /* %JoinFKPK(:%New,ACTOR07," = "," AND") */
        :new.ActorID = ACTOR07.ActorID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert CONTRAST07 because ACTOR07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_CONTRAST07 AFTER UPDATE ON CONTRAST07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on CONTRAST07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* MOVIE07 Actor Contrast CONTRAST07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00021748", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_158", FK_COLUMNS="MovieID" */
  SELECT count(*) INTO NUMROWS
    FROM MOVIE07
    WHERE
      /* %JoinFKPK(:%New,MOVIE07," = "," AND") */
      :new.MovieID = MOVIE07.MovieID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update CONTRAST07 because MOVIE07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* ACTOR07 Movie Contrast CONTRAST07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="ACTOR07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/133", C2P_VERB_PHRASE="Reference Actor", 
    FK_CONSTRAINT="R_153", FK_COLUMNS="ActorID" */
  SELECT count(*) INTO NUMROWS
    FROM ACTOR07
    WHERE
      /* %JoinFKPK(:%New,ACTOR07," = "," AND") */
      :new.ActorID = ACTOR07.ActorID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update CONTRAST07 because ACTOR07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/


CREATE  TRIGGER tI_DISTANCE07 BEFORE INSERT ON DISTANCE07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- INSERT trigger on DISTANCE07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* THEATER07 Distance Points DISTANCE07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00023890", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Reference City", 
    FK_CONSTRAINT="R_151", FK_COLUMNS="TheaterID" */
    SELECT count(*) INTO NUMROWS
      FROM THEATER07
      WHERE
        /* %JoinFKPK(:%New,THEATER07," = "," AND") */
        :new.TheaterID = THEATER07.TheaterID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert DISTANCE07 because THEATER07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* REFERENCE_POINT07 Distance Theater DISTANCE07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="REFERENCE_POINT07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Reference Point", 
    FK_CONSTRAINT="R_152", FK_COLUMNS="ReferenceID" */
    SELECT count(*) INTO NUMROWS
      FROM REFERENCE_POINT07
      WHERE
        /* %JoinFKPK(:%New,REFERENCE_POINT07," = "," AND") */
        :new.ReferenceID = REFERENCE_POINT07.ReferenceID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert DISTANCE07 because REFERENCE_POINT07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_DISTANCE07 AFTER UPDATE ON DISTANCE07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on DISTANCE07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* THEATER07 Distance Points DISTANCE07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00024215", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Reference City", 
    FK_CONSTRAINT="R_151", FK_COLUMNS="TheaterID" */
  SELECT count(*) INTO NUMROWS
    FROM THEATER07
    WHERE
      /* %JoinFKPK(:%New,THEATER07," = "," AND") */
      :new.TheaterID = THEATER07.TheaterID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update DISTANCE07 because THEATER07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* REFERENCE_POINT07 Distance Theater DISTANCE07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="REFERENCE_POINT07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Reference Point", 
    FK_CONSTRAINT="R_152", FK_COLUMNS="ReferenceID" */
  SELECT count(*) INTO NUMROWS
    FROM REFERENCE_POINT07
    WHERE
      /* %JoinFKPK(:%New,REFERENCE_POINT07," = "," AND") */
      :new.ReferenceID = REFERENCE_POINT07.ReferenceID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update DISTANCE07 because REFERENCE_POINT07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/


CREATE  TRIGGER tD_MOVIE07 AFTER DELETE ON MOVIE07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- DELETE trigger on MOVIE07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* MOVIE07 Actor Contrast CONTRAST07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001e88f", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_158", FK_COLUMNS="MovieID" */
    SELECT count(*) INTO NUMROWS
      FROM CONTRAST07
      WHERE
        /*  %JoinFKPK(CONTRAST07,:%Old," = "," AND") */
        CONTRAST07.MovieID = :old.MovieID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete MOVIE07 because CONTRAST07 exists.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* MOVIE07 Showed Specific Theater SHOW_TIME07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_159", FK_COLUMNS="MovieID" */
    SELECT count(*) INTO NUMROWS
      FROM SHOW_TIME07
      WHERE
        /*  %JoinFKPK(SHOW_TIME07,:%Old," = "," AND") */
        SHOW_TIME07.MovieID = :old.MovieID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete MOVIE07 because SHOW_TIME07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_MOVIE07 AFTER UPDATE ON MOVIE07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on MOVIE07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* MOVIE07 Actor Contrast CONTRAST07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00024601", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="CONTRAST07"
    P2C_VERB_PHRASE="R/128", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_158", FK_COLUMNS="MovieID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MovieID <> :new.MovieID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM CONTRAST07
      WHERE
        /*  %JoinFKPK(CONTRAST07,:%Old," = "," AND") */
        CONTRAST07.MovieID = :old.MovieID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update MOVIE07 because CONTRAST07 exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* MOVIE07 Showed Specific Theater SHOW_TIME07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_159", FK_COLUMNS="MovieID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MovieID <> :new.MovieID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM SHOW_TIME07
      WHERE
        /*  %JoinFKPK(SHOW_TIME07,:%Old," = "," AND") */
        SHOW_TIME07.MovieID = :old.MovieID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update MOVIE07 because SHOW_TIME07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/


CREATE  TRIGGER tD_REFERENCE_POINT07 AFTER DELETE ON REFERENCE_POINT07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- DELETE trigger on REFERENCE_POINT07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* REFERENCE_POINT07 Distance Theater DISTANCE07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f781", PARENT_OWNER="", PARENT_TABLE="REFERENCE_POINT07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Reference Point", 
    FK_CONSTRAINT="R_152", FK_COLUMNS="ReferenceID" */
    SELECT count(*) INTO NUMROWS
      FROM DISTANCE07
      WHERE
        /*  %JoinFKPK(DISTANCE07,:%Old," = "," AND") */
        DISTANCE07.ReferenceID = :old.ReferenceID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete REFERENCE_POINT07 because DISTANCE07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_REFERENCE_POINT07 AFTER UPDATE ON REFERENCE_POINT07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on REFERENCE_POINT07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* REFERENCE_POINT07 Distance Theater DISTANCE07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000126c1", PARENT_OWNER="", PARENT_TABLE="REFERENCE_POINT07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/132", C2P_VERB_PHRASE="Reference Point", 
    FK_CONSTRAINT="R_152", FK_COLUMNS="ReferenceID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ReferenceID <> :new.ReferenceID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM DISTANCE07
      WHERE
        /*  %JoinFKPK(DISTANCE07,:%Old," = "," AND") */
        DISTANCE07.ReferenceID = :old.ReferenceID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update REFERENCE_POINT07 because DISTANCE07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/


CREATE  TRIGGER tI_SHOW_TIME07 BEFORE INSERT ON SHOW_TIME07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- INSERT trigger on SHOW_TIME07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* MOVIE07 Showed Specific Theater SHOW_TIME07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00021dab", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_159", FK_COLUMNS="MovieID" */
    SELECT count(*) INTO NUMROWS
      FROM MOVIE07
      WHERE
        /* %JoinFKPK(:%New,MOVIE07," = "," AND") */
        :new.MovieID = MOVIE07.MovieID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert SHOW_TIME07 because MOVIE07 does not exist.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* THEATER07 Show Specific Theater SHOW_TIME07 on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Reference Theater", 
    FK_CONSTRAINT="R_150", FK_COLUMNS="TheaterID" */
    SELECT count(*) INTO NUMROWS
      FROM THEATER07
      WHERE
        /* %JoinFKPK(:%New,THEATER07," = "," AND") */
        :new.TheaterID = THEATER07.TheaterID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert SHOW_TIME07 because THEATER07 does not exist.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_SHOW_TIME07 AFTER UPDATE ON SHOW_TIME07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on SHOW_TIME07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* MOVIE07 Showed Specific Theater SHOW_TIME07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00021fb5", PARENT_OWNER="", PARENT_TABLE="MOVIE07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/129", C2P_VERB_PHRASE="Reference Movie", 
    FK_CONSTRAINT="R_159", FK_COLUMNS="MovieID" */
  SELECT count(*) INTO NUMROWS
    FROM MOVIE07
    WHERE
      /* %JoinFKPK(:%New,MOVIE07," = "," AND") */
      :new.MovieID = MOVIE07.MovieID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update SHOW_TIME07 because MOVIE07 does not exist.'
    );
  END IF;

  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* THEATER07 Show Specific Theater SHOW_TIME07 on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Reference Theater", 
    FK_CONSTRAINT="R_150", FK_COLUMNS="TheaterID" */
  SELECT count(*) INTO NUMROWS
    FROM THEATER07
    WHERE
      /* %JoinFKPK(:%New,THEATER07," = "," AND") */
      :new.TheaterID = THEATER07.TheaterID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update SHOW_TIME07 because THEATER07 does not exist.'
    );
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/


CREATE  TRIGGER tD_THEATER07 AFTER DELETE ON THEATER07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- DELETE trigger on THEATER07 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* THEATER07 Show Specific Theater SHOW_TIME07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001fd16", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Reference Theater", 
    FK_CONSTRAINT="R_150", FK_COLUMNS="TheaterID" */
    SELECT count(*) INTO NUMROWS
      FROM SHOW_TIME07
      WHERE
        /*  %JoinFKPK(SHOW_TIME07,:%Old," = "," AND") */
        SHOW_TIME07.TheaterID = :old.TheaterID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete THEATER07 because SHOW_TIME07 exists.'
      );
    END IF;

    /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
    /* THEATER07 Distance Points DISTANCE07 on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Reference City", 
    FK_CONSTRAINT="R_151", FK_COLUMNS="TheaterID" */
    SELECT count(*) INTO NUMROWS
      FROM DISTANCE07
      WHERE
        /*  %JoinFKPK(DISTANCE07,:%Old," = "," AND") */
        DISTANCE07.TheaterID = :old.TheaterID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete THEATER07 because DISTANCE07 exists.'
      );
    END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

CREATE  TRIGGER tU_THEATER07 AFTER UPDATE ON THEATER07 for each row
-- ERwin Builtin Mon Oct 16 20:30:41 2023
-- UPDATE trigger on THEATER07 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* THEATER07 Show Specific Theater SHOW_TIME07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00024cdc", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="SHOW_TIME07"
    P2C_VERB_PHRASE="R/130", C2P_VERB_PHRASE="Reference Theater", 
    FK_CONSTRAINT="R_150", FK_COLUMNS="TheaterID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.TheaterID <> :new.TheaterID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM SHOW_TIME07
      WHERE
        /*  %JoinFKPK(SHOW_TIME07,:%Old," = "," AND") */
        SHOW_TIME07.TheaterID = :old.TheaterID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update THEATER07 because SHOW_TIME07 exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Mon Oct 16 20:30:41 2023 */
  /* THEATER07 Distance Points DISTANCE07 on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="THEATER07"
    CHILD_OWNER="", CHILD_TABLE="DISTANCE07"
    P2C_VERB_PHRASE="R/131", C2P_VERB_PHRASE="Reference City", 
    FK_CONSTRAINT="R_151", FK_COLUMNS="TheaterID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.TheaterID <> :new.TheaterID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM DISTANCE07
      WHERE
        /*  %JoinFKPK(DISTANCE07,:%Old," = "," AND") */
        DISTANCE07.TheaterID = :old.TheaterID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update THEATER07 because DISTANCE07 exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Mon Oct 16 20:30:41 2023
END;
/

