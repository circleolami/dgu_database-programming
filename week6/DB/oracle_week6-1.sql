
CREATE TABLE W5_ALBUM
(
	AlbumID               NUMBER  NOT NULL ,
	Title                 CHAR(18)  NOT NULL ,
	RegistrationDate      DATE  NOT NULL ,
	MusicianID            NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKALBUM ON W5_ALBUM
(AlbumID  ASC);



ALTER TABLE W5_ALBUM
	ADD CONSTRAINT  XPKALBUM PRIMARY KEY (AlbumID);



CREATE TABLE W5_CONTRACT
(
	StaffID               NUMBER  NOT NULL ,
	CustomerID            NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_CONTRACT ON W5_CONTRACT
(StaffID  ASC,CustomerID  ASC);



ALTER TABLE W5_CONTRACT
	ADD CONSTRAINT  XPKW5_CONTRACT PRIMARY KEY (StaffID,CustomerID);



CREATE TABLE W5_CUSTOMER
(
	CustomerID            NUMBER  NOT NULL ,
	Name                  CHAR(18)  NOT NULL ,
	PostalCode            NUMBER  NOT NULL ,
	PhoneNumber           CHAR(18)  NULL 
);



CREATE UNIQUE INDEX XPKW5_CUSTOMER ON W5_CUSTOMER
(CustomerID  ASC);



ALTER TABLE W5_CUSTOMER
	ADD CONSTRAINT  XPKW5_CUSTOMER PRIMARY KEY (CustomerID);



CREATE TABLE W5_FURNITURE
(
	FurnitureID           NUMBER  NOT NULL ,
	FurnitureName         CHAR(18)  NOT NULL ,
	Price                 CHAR(18)  NOT NULL ,
	StockQuantity         NUMBER  NULL 
);



CREATE UNIQUE INDEX XPKW5_FURNITURE ON W5_FURNITURE
(FurnitureID  ASC);



ALTER TABLE W5_FURNITURE
	ADD CONSTRAINT  XPKW5_FURNITURE PRIMARY KEY (FurnitureID);



CREATE TABLE W5_INSTRUMENT
(
	InstrumentID          NUMBER  NOT NULL ,
	InstrumentName        CHAR(18)  NOT NULL ,
	InstrumentType        CHAR(18)  NOT NULL ,
	Album                 CHAR(18)  NULL ,
	MusicianID            NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKINSTRUMENT ON W5_INSTRUMENT
(InstrumentID  ASC);



ALTER TABLE W5_INSTRUMENT
	ADD CONSTRAINT  XPKINSTRUMENT PRIMARY KEY (InstrumentID);



CREATE TABLE W5_MENU
(
	MenuID                NUMBER  NOT NULL ,
	MenuName              CHAR(18)  NOT NULL ,
	Price                 NUMBER  NOT NULL ,
	Sale                  CHAR(18)  NOT NULL 
);



CREATE UNIQUE INDEX XPKMENU ON W5_MENU
(MenuID  ASC);



ALTER TABLE W5_MENU
	ADD CONSTRAINT  XPKMENU PRIMARY KEY (MenuID);



CREATE TABLE W5_MUSICIAN
(
	MusicianID            NUMBER  NOT NULL ,
	Name                  CHAR(18)  NOT NULL ,
	Address               CHAR(18)  NOT NULL ,
	PhoneNumber           CHAR(18)  NULL ,
	Song                  CHAR(18)  NULL 
);



CREATE UNIQUE INDEX XPKMUSICIAN ON W5_MUSICIAN
(MusicianID  ASC);



ALTER TABLE W5_MUSICIAN
	ADD CONSTRAINT  XPKMUSICIAN PRIMARY KEY (MusicianID);



CREATE TABLE W5_ORDER
(
	OrderID               NUMBER  NOT NULL ,
	PaymentDate           DATE  NOT NULL ,
	DeliveryDate          DATE  NOT NULL ,
	FurnitureID           NUMBER  NOT NULL ,
	StaffID               NUMBER  NOT NULL ,
	Quantity              CHAR(18)  NULL ,
	CustomerID            NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKW5_ORDER ON W5_ORDER
(OrderID  ASC);



ALTER TABLE W5_ORDER
	ADD CONSTRAINT  XPKW5_ORDER PRIMARY KEY (OrderID);



CREATE TABLE W5_RESTAURANT
(
	RestaurantID          NUMBER  NOT NULL ,
	Address               CHAR(18)  NOT NULL ,
	Menu                  CHAR(18)  NULL ,
	PhoneNumber           NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKRESTAURANT ON W5_RESTAURANT
(RestaurantID  ASC);



ALTER TABLE W5_RESTAURANT
	ADD CONSTRAINT  XPKRESTAURANT PRIMARY KEY (RestaurantID);



CREATE TABLE W5_SALES
(
	SaleID                NUMBER  NOT NULL ,
	RestaurantID          NUMBER  NOT NULL ,
	DateTime              DATE  NOT NULL ,
	MenuItemsQuantity     CHAR(18)  NULL ,
	MenuID                NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKSALES ON W5_SALES
(SaleID  ASC,RestaurantID  ASC);



ALTER TABLE W5_SALES
	ADD CONSTRAINT  XPKSALES PRIMARY KEY (SaleID,RestaurantID);



CREATE TABLE W5_SONG
(
	SongID                NUMBER  NOT NULL ,
	Title                 CHAR(18)  NOT NULL ,
	Composer              CHAR(18)  NOT NULL ,
	ReleaseDate           DATE  NOT NULL ,
	Instrument            CHAR(18)  NOT NULL ,
	MusicianID            NUMBER  NOT NULL ,
	AlbumID               NUMBER  NOT NULL 
);



CREATE UNIQUE INDEX XPKSONG ON W5_SONG
(SongID  ASC,AlbumID  ASC);



ALTER TABLE W5_SONG
	ADD CONSTRAINT  XPKSONG PRIMARY KEY (SongID,AlbumID);



CREATE TABLE W5_STAFF
(
	StaffID               NUMBER  NOT NULL ,
	Name                  CHAR(18)  NOT NULL ,
	PostalCode            NUMBER  NOT NULL ,
	PhoneNumber           CHAR(18)  NULL 
);



CREATE UNIQUE INDEX XPKW5_STAFF ON W5_STAFF
(StaffID  ASC);



ALTER TABLE W5_STAFF
	ADD CONSTRAINT  XPKW5_STAFF PRIMARY KEY (StaffID);



ALTER TABLE W5_ALBUM
	ADD (CONSTRAINT  R_133 FOREIGN KEY (MusicianID) REFERENCES W5_MUSICIAN(MusicianID));



ALTER TABLE W5_CONTRACT
	ADD (CONSTRAINT  R_109 FOREIGN KEY (StaffID) REFERENCES W5_STAFF(StaffID));



ALTER TABLE W5_CONTRACT
	ADD (CONSTRAINT  R_110 FOREIGN KEY (CustomerID) REFERENCES W5_CUSTOMER(CustomerID));



ALTER TABLE W5_INSTRUMENT
	ADD (CONSTRAINT  R_130 FOREIGN KEY (MusicianID) REFERENCES W5_MUSICIAN(MusicianID));



ALTER TABLE W5_ORDER
	ADD (CONSTRAINT  R_111 FOREIGN KEY (StaffID,CustomerID) REFERENCES W5_CONTRACT(StaffID,CustomerID));



ALTER TABLE W5_ORDER
	ADD (CONSTRAINT  R_112 FOREIGN KEY (FurnitureID) REFERENCES W5_FURNITURE(FurnitureID));



ALTER TABLE W5_SALES
	ADD (CONSTRAINT  R_114 FOREIGN KEY (RestaurantID) REFERENCES W5_RESTAURANT(RestaurantID));



ALTER TABLE W5_SALES
	ADD (CONSTRAINT  R_118 FOREIGN KEY (MenuID) REFERENCES W5_MENU(MenuID));



ALTER TABLE W5_SONG
	ADD (CONSTRAINT  R_119 FOREIGN KEY (MusicianID) REFERENCES W5_MUSICIAN(MusicianID) ON DELETE SET NULL);



ALTER TABLE W5_SONG
	ADD (CONSTRAINT  R_120 FOREIGN KEY (AlbumID) REFERENCES W5_ALBUM(AlbumID));



CREATE  TRIGGER tI_W5_ALBUM BEFORE INSERT ON W5_ALBUM for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- INSERT trigger on W5_ALBUM 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MUSICIAN  W5_ALBUM on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000fc6e", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_ALBUM"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_133", FK_COLUMNS="MusicianID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_MUSICIAN
      WHERE
        /* %JoinFKPK(:%New,W5_MUSICIAN," = "," AND") */
        :new.MusicianID = W5_MUSICIAN.MusicianID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_ALBUM because W5_MUSICIAN does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tD_W5_ALBUM AFTER DELETE ON W5_ALBUM for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_ALBUM 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_ALBUM  W5_SONG on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000dbb7", PARENT_OWNER="", PARENT_TABLE="W5_ALBUM"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/120", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_120", FK_COLUMNS="AlbumID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_SONG
      WHERE
        /*  %JoinFKPK(W5_SONG,:%Old," = "," AND") */
        W5_SONG.AlbumID = :old.AlbumID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_ALBUM because W5_SONG exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_ALBUM AFTER UPDATE ON W5_ALBUM for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_ALBUM 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_ALBUM  W5_SONG on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000205b8", PARENT_OWNER="", PARENT_TABLE="W5_ALBUM"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/120", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_120", FK_COLUMNS="AlbumID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.AlbumID <> :new.AlbumID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_SONG
      WHERE
        /*  %JoinFKPK(W5_SONG,:%Old," = "," AND") */
        W5_SONG.AlbumID = :old.AlbumID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_ALBUM because W5_SONG exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MUSICIAN  W5_ALBUM on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_ALBUM"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_133", FK_COLUMNS="MusicianID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_MUSICIAN
    WHERE
      /* %JoinFKPK(:%New,W5_MUSICIAN," = "," AND") */
      :new.MusicianID = W5_MUSICIAN.MusicianID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_ALBUM because W5_MUSICIAN does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tI_W5_CONTRACT BEFORE INSERT ON W5_CONTRACT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- INSERT trigger on W5_CONTRACT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_STAFF  W5_CONTRACT on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00020b2e", PARENT_OWNER="", PARENT_TABLE="W5_STAFF"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/109", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_109", FK_COLUMNS="StaffID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_STAFF
      WHERE
        /* %JoinFKPK(:%New,W5_STAFF," = "," AND") */
        :new.StaffID = W5_STAFF.StaffID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_CONTRACT because W5_STAFF does not exist.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_CUSTOMER  W5_CONTRACT on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/110", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_110", FK_COLUMNS="CustomerID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_CUSTOMER
      WHERE
        /* %JoinFKPK(:%New,W5_CUSTOMER," = "," AND") */
        :new.CustomerID = W5_CUSTOMER.CustomerID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_CONTRACT because W5_CUSTOMER does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tD_W5_CONTRACT AFTER DELETE ON W5_CONTRACT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_CONTRACT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_CONTRACT  W5_ORDER on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f08b", PARENT_OWNER="", PARENT_TABLE="W5_CONTRACT"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/111", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_111", FK_COLUMNS="StaffID""CustomerID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_ORDER
      WHERE
        /*  %JoinFKPK(W5_ORDER,:%Old," = "," AND") */
        W5_ORDER.StaffID = :old.StaffID AND
        W5_ORDER.CustomerID = :old.CustomerID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_CONTRACT because W5_ORDER exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_CONTRACT AFTER UPDATE ON W5_CONTRACT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_CONTRACT 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_CONTRACT  W5_ORDER on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00035783", PARENT_OWNER="", PARENT_TABLE="W5_CONTRACT"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/111", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_111", FK_COLUMNS="StaffID""CustomerID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.StaffID <> :new.StaffID OR 
    :old.CustomerID <> :new.CustomerID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_ORDER
      WHERE
        /*  %JoinFKPK(W5_ORDER,:%Old," = "," AND") */
        W5_ORDER.StaffID = :old.StaffID AND
        W5_ORDER.CustomerID = :old.CustomerID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_CONTRACT because W5_ORDER exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_STAFF  W5_CONTRACT on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_STAFF"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/109", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_109", FK_COLUMNS="StaffID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_STAFF
    WHERE
      /* %JoinFKPK(:%New,W5_STAFF," = "," AND") */
      :new.StaffID = W5_STAFF.StaffID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_CONTRACT because W5_STAFF does not exist.'
    );
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_CUSTOMER  W5_CONTRACT on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/110", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_110", FK_COLUMNS="CustomerID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_CUSTOMER
    WHERE
      /* %JoinFKPK(:%New,W5_CUSTOMER," = "," AND") */
      :new.CustomerID = W5_CUSTOMER.CustomerID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_CONTRACT because W5_CUSTOMER does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tD_W5_CUSTOMER AFTER DELETE ON W5_CUSTOMER for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_CUSTOMER 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_CUSTOMER  W5_CONTRACT on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000eae2", PARENT_OWNER="", PARENT_TABLE="W5_CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/110", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_110", FK_COLUMNS="CustomerID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_CONTRACT
      WHERE
        /*  %JoinFKPK(W5_CONTRACT,:%Old," = "," AND") */
        W5_CONTRACT.CustomerID = :old.CustomerID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_CUSTOMER because W5_CONTRACT exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_CUSTOMER AFTER UPDATE ON W5_CUSTOMER for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_CUSTOMER 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_CUSTOMER  W5_CONTRACT on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010970", PARENT_OWNER="", PARENT_TABLE="W5_CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/110", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_110", FK_COLUMNS="CustomerID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.CustomerID <> :new.CustomerID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_CONTRACT
      WHERE
        /*  %JoinFKPK(W5_CONTRACT,:%Old," = "," AND") */
        W5_CONTRACT.CustomerID = :old.CustomerID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_CUSTOMER because W5_CONTRACT exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tD_W5_FURNITURE AFTER DELETE ON W5_FURNITURE for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_FURNITURE 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_FURNITURE  W5_ORDER on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000ec92", PARENT_OWNER="", PARENT_TABLE="W5_FURNITURE"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/112", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_112", FK_COLUMNS="FurnitureID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_ORDER
      WHERE
        /*  %JoinFKPK(W5_ORDER,:%Old," = "," AND") */
        W5_ORDER.FurnitureID = :old.FurnitureID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_FURNITURE because W5_ORDER exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_FURNITURE AFTER UPDATE ON W5_FURNITURE for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_FURNITURE 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_FURNITURE  W5_ORDER on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001150e", PARENT_OWNER="", PARENT_TABLE="W5_FURNITURE"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/112", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_112", FK_COLUMNS="FurnitureID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.FurnitureID <> :new.FurnitureID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_ORDER
      WHERE
        /*  %JoinFKPK(W5_ORDER,:%Old," = "," AND") */
        W5_ORDER.FurnitureID = :old.FurnitureID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_FURNITURE because W5_ORDER exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tI_W5_INSTRUMENT BEFORE INSERT ON W5_INSTRUMENT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- INSERT trigger on W5_INSTRUMENT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MUSICIAN  W5_INSTRUMENT on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000fd39", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_INSTRUMENT"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_130", FK_COLUMNS="MusicianID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_MUSICIAN
      WHERE
        /* %JoinFKPK(:%New,W5_MUSICIAN," = "," AND") */
        :new.MusicianID = W5_MUSICIAN.MusicianID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_INSTRUMENT because W5_MUSICIAN does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_INSTRUMENT AFTER UPDATE ON W5_INSTRUMENT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_INSTRUMENT 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MUSICIAN  W5_INSTRUMENT on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000fcf0", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_INSTRUMENT"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_130", FK_COLUMNS="MusicianID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_MUSICIAN
    WHERE
      /* %JoinFKPK(:%New,W5_MUSICIAN," = "," AND") */
      :new.MusicianID = W5_MUSICIAN.MusicianID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_INSTRUMENT because W5_MUSICIAN does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tD_W5_MENU AFTER DELETE ON W5_MENU for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_MENU 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MENU  W5_SALES on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000d3e6", PARENT_OWNER="", PARENT_TABLE="W5_MENU"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/118", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_118", FK_COLUMNS="MenuID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_SALES
      WHERE
        /*  %JoinFKPK(W5_SALES,:%Old," = "," AND") */
        W5_SALES.MenuID = :old.MenuID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_MENU because W5_SALES exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_MENU AFTER UPDATE ON W5_MENU for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_MENU 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MENU  W5_SALES on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001022d", PARENT_OWNER="", PARENT_TABLE="W5_MENU"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/118", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_118", FK_COLUMNS="MenuID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MenuID <> :new.MenuID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_SALES
      WHERE
        /*  %JoinFKPK(W5_SALES,:%Old," = "," AND") */
        W5_SALES.MenuID = :old.MenuID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_MENU because W5_SALES exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tD_W5_MUSICIAN AFTER DELETE ON W5_MUSICIAN for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_MUSICIAN 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MUSICIAN  W5_SONG on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0002aadc", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/119", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_119", FK_COLUMNS="MusicianID" */
    UPDATE W5_SONG
      SET
        /* %SetFK(W5_SONG,NULL) */
        W5_SONG.MusicianID = NULL
      WHERE
        /* %JoinFKPK(W5_SONG,:%Old," = "," AND") */
        W5_SONG.MusicianID = :old.MusicianID;

    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MUSICIAN  W5_ALBUM on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_ALBUM"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_133", FK_COLUMNS="MusicianID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_ALBUM
      WHERE
        /*  %JoinFKPK(W5_ALBUM,:%Old," = "," AND") */
        W5_ALBUM.MusicianID = :old.MusicianID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_MUSICIAN because W5_ALBUM exists.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MUSICIAN  W5_INSTRUMENT on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_INSTRUMENT"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_130", FK_COLUMNS="MusicianID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_INSTRUMENT
      WHERE
        /*  %JoinFKPK(W5_INSTRUMENT,:%Old," = "," AND") */
        W5_INSTRUMENT.MusicianID = :old.MusicianID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_MUSICIAN because W5_INSTRUMENT exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_MUSICIAN AFTER UPDATE ON W5_MUSICIAN for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_MUSICIAN 
DECLARE NUMROWS INTEGER;
BEGIN
  /* W5_MUSICIAN  W5_SONG on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00032a4f", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/119", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_119", FK_COLUMNS="MusicianID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MusicianID <> :new.MusicianID
  THEN
    UPDATE W5_SONG
      SET
        /* %SetFK(W5_SONG,NULL) */
        W5_SONG.MusicianID = NULL
      WHERE
        /* %JoinFKPK(W5_SONG,:%Old," = ",",") */
        W5_SONG.MusicianID = :old.MusicianID;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MUSICIAN  W5_ALBUM on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_ALBUM"
    P2C_VERB_PHRASE="R/126", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_133", FK_COLUMNS="MusicianID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MusicianID <> :new.MusicianID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_ALBUM
      WHERE
        /*  %JoinFKPK(W5_ALBUM,:%Old," = "," AND") */
        W5_ALBUM.MusicianID = :old.MusicianID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_MUSICIAN because W5_ALBUM exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MUSICIAN  W5_INSTRUMENT on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_INSTRUMENT"
    P2C_VERB_PHRASE="R/127", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_130", FK_COLUMNS="MusicianID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.MusicianID <> :new.MusicianID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_INSTRUMENT
      WHERE
        /*  %JoinFKPK(W5_INSTRUMENT,:%Old," = "," AND") */
        W5_INSTRUMENT.MusicianID = :old.MusicianID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_MUSICIAN because W5_INSTRUMENT exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tI_W5_ORDER BEFORE INSERT ON W5_ORDER for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- INSERT trigger on W5_ORDER 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_CONTRACT  W5_ORDER on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="000224fc", PARENT_OWNER="", PARENT_TABLE="W5_CONTRACT"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/111", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_111", FK_COLUMNS="StaffID""CustomerID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_CONTRACT
      WHERE
        /* %JoinFKPK(:%New,W5_CONTRACT," = "," AND") */
        :new.StaffID = W5_CONTRACT.StaffID AND
        :new.CustomerID = W5_CONTRACT.CustomerID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_ORDER because W5_CONTRACT does not exist.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_FURNITURE  W5_ORDER on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_FURNITURE"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/112", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_112", FK_COLUMNS="FurnitureID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_FURNITURE
      WHERE
        /* %JoinFKPK(:%New,W5_FURNITURE," = "," AND") */
        :new.FurnitureID = W5_FURNITURE.FurnitureID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_ORDER because W5_FURNITURE does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_ORDER AFTER UPDATE ON W5_ORDER for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_ORDER 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_CONTRACT  W5_ORDER on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00021a7f", PARENT_OWNER="", PARENT_TABLE="W5_CONTRACT"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/111", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_111", FK_COLUMNS="StaffID""CustomerID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_CONTRACT
    WHERE
      /* %JoinFKPK(:%New,W5_CONTRACT," = "," AND") */
      :new.StaffID = W5_CONTRACT.StaffID AND
      :new.CustomerID = W5_CONTRACT.CustomerID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_ORDER because W5_CONTRACT does not exist.'
    );
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_FURNITURE  W5_ORDER on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_FURNITURE"
    CHILD_OWNER="", CHILD_TABLE="W5_ORDER"
    P2C_VERB_PHRASE="R/112", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_112", FK_COLUMNS="FurnitureID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_FURNITURE
    WHERE
      /* %JoinFKPK(:%New,W5_FURNITURE," = "," AND") */
      :new.FurnitureID = W5_FURNITURE.FurnitureID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_ORDER because W5_FURNITURE does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tD_W5_RESTAURANT AFTER DELETE ON W5_RESTAURANT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_RESTAURANT 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_RESTAURANT  W5_SALES on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000eec2", PARENT_OWNER="", PARENT_TABLE="W5_RESTAURANT"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/114", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_114", FK_COLUMNS="RestaurantID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_SALES
      WHERE
        /*  %JoinFKPK(W5_SALES,:%Old," = "," AND") */
        W5_SALES.RestaurantID = :old.RestaurantID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_RESTAURANT because W5_SALES exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_RESTAURANT AFTER UPDATE ON W5_RESTAURANT for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_RESTAURANT 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_RESTAURANT  W5_SALES on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="000114be", PARENT_OWNER="", PARENT_TABLE="W5_RESTAURANT"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/114", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_114", FK_COLUMNS="RestaurantID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.RestaurantID <> :new.RestaurantID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_SALES
      WHERE
        /*  %JoinFKPK(W5_SALES,:%Old," = "," AND") */
        W5_SALES.RestaurantID = :old.RestaurantID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_RESTAURANT because W5_SALES exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tI_W5_SALES BEFORE INSERT ON W5_SALES for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- INSERT trigger on W5_SALES 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_RESTAURANT  W5_SALES on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001ff2a", PARENT_OWNER="", PARENT_TABLE="W5_RESTAURANT"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/114", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_114", FK_COLUMNS="RestaurantID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_RESTAURANT
      WHERE
        /* %JoinFKPK(:%New,W5_RESTAURANT," = "," AND") */
        :new.RestaurantID = W5_RESTAURANT.RestaurantID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_SALES because W5_RESTAURANT does not exist.'
      );
    END IF;

    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MENU  W5_SALES on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MENU"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/118", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_118", FK_COLUMNS="MenuID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_MENU
      WHERE
        /* %JoinFKPK(:%New,W5_MENU," = "," AND") */
        :new.MenuID = W5_MENU.MenuID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_SALES because W5_MENU does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_SALES AFTER UPDATE ON W5_SALES for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_SALES 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_RESTAURANT  W5_SALES on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001fcbd", PARENT_OWNER="", PARENT_TABLE="W5_RESTAURANT"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/114", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_114", FK_COLUMNS="RestaurantID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_RESTAURANT
    WHERE
      /* %JoinFKPK(:%New,W5_RESTAURANT," = "," AND") */
      :new.RestaurantID = W5_RESTAURANT.RestaurantID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_SALES because W5_RESTAURANT does not exist.'
    );
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MENU  W5_SALES on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_MENU"
    CHILD_OWNER="", CHILD_TABLE="W5_SALES"
    P2C_VERB_PHRASE="R/118", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_118", FK_COLUMNS="MenuID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_MENU
    WHERE
      /* %JoinFKPK(:%New,W5_MENU," = "," AND") */
      :new.MenuID = W5_MENU.MenuID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_SALES because W5_MENU does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tI_W5_SONG BEFORE INSERT ON W5_SONG for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- INSERT trigger on W5_SONG 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_MUSICIAN  W5_SONG on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0002067b", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/119", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_119", FK_COLUMNS="MusicianID" */
    UPDATE W5_SONG
      SET
        /* %SetFK(W5_SONG,NULL) */
        W5_SONG.MusicianID = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM W5_MUSICIAN
            WHERE
              /* %JoinFKPK(:%New,W5_MUSICIAN," = "," AND") */
              :new.MusicianID = W5_MUSICIAN.MusicianID
        ) 
        /* %JoinPKPK(W5_SONG,:%New," = "," AND") */
         and W5_SONG.SongID = :new.SongID AND
        W5_SONG.AlbumID = :new.AlbumID;

    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_ALBUM  W5_SONG on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_ALBUM"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/120", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_120", FK_COLUMNS="AlbumID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_ALBUM
      WHERE
        /* %JoinFKPK(:%New,W5_ALBUM," = "," AND") */
        :new.AlbumID = W5_ALBUM.AlbumID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert W5_SONG because W5_ALBUM does not exist.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_SONG AFTER UPDATE ON W5_SONG for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_SONG 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_MUSICIAN  W5_SONG on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00020f51", PARENT_OWNER="", PARENT_TABLE="W5_MUSICIAN"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/119", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_119", FK_COLUMNS="MusicianID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_MUSICIAN
    WHERE
      /* %JoinFKPK(:%New,W5_MUSICIAN," = "," AND") */
      :new.MusicianID = W5_MUSICIAN.MusicianID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.MusicianID IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_SONG because W5_MUSICIAN does not exist.'
    );
  END IF;

  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_ALBUM  W5_SONG on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="W5_ALBUM"
    CHILD_OWNER="", CHILD_TABLE="W5_SONG"
    P2C_VERB_PHRASE="R/120", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_120", FK_COLUMNS="AlbumID" */
  SELECT count(*) INTO NUMROWS
    FROM W5_ALBUM
    WHERE
      /* %JoinFKPK(:%New,W5_ALBUM," = "," AND") */
      :new.AlbumID = W5_ALBUM.AlbumID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update W5_SONG because W5_ALBUM does not exist.'
    );
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/


CREATE  TRIGGER tD_W5_STAFF AFTER DELETE ON W5_STAFF for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- DELETE trigger on W5_STAFF 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
    /* W5_STAFF  W5_CONTRACT on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000e06e", PARENT_OWNER="", PARENT_TABLE="W5_STAFF"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/109", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_109", FK_COLUMNS="StaffID" */
    SELECT count(*) INTO NUMROWS
      FROM W5_CONTRACT
      WHERE
        /*  %JoinFKPK(W5_CONTRACT,:%Old," = "," AND") */
        W5_CONTRACT.StaffID = :old.StaffID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete W5_STAFF because W5_CONTRACT exists.'
      );
    END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

CREATE  TRIGGER tU_W5_STAFF AFTER UPDATE ON W5_STAFF for each row
-- ERwin Builtin Thu Oct 12 17:38:16 2023
-- UPDATE trigger on W5_STAFF 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Thu Oct 12 17:38:16 2023 */
  /* W5_STAFF  W5_CONTRACT on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010b57", PARENT_OWNER="", PARENT_TABLE="W5_STAFF"
    CHILD_OWNER="", CHILD_TABLE="W5_CONTRACT"
    P2C_VERB_PHRASE="R/109", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_109", FK_COLUMNS="StaffID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.StaffID <> :new.StaffID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM W5_CONTRACT
      WHERE
        /*  %JoinFKPK(W5_CONTRACT,:%Old," = "," AND") */
        W5_CONTRACT.StaffID = :old.StaffID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update W5_STAFF because W5_CONTRACT exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Thu Oct 12 17:38:16 2023
END;
/

