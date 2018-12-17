--PURPOSE    : PATCH TO ADD NEW TABLES AND INDEXES.
--AUTHOR     : Meghana Ganapaiah
--CREATED ON : 23RD September 2013

CREATE TABLE NOTIFICATION_MESSAGE_PARAMETER
  (
    ID                   NUMBER,
    NOTIFICATION_MESSAGE NUMBER,
    KEY                  VARCHAR2(255 BYTE),
    VALUE                VARCHAR2(255 BYTE),
	 PRIMARY KEY (ID) 
  )
/