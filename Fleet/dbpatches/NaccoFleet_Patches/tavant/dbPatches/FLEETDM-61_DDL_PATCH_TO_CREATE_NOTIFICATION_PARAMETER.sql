--PURPOSE    : PATCH TO ADD NEW TABLES AND INDEXES.
--AUTHOR     : Meghana Ganapaiah
--CREATED ON : 23RD September 2013

CREATE TABLE NOTIFICATION_PARAMETER
(
    ID                 NUMBER,
    NOTIFICATION_EVENT NUMBER,
    KEY                VARCHAR2(255 BYTE),
    VALUE              VARCHAR2(255 BYTE),
    PRIMARY KEY (ID)  
)
/
CREATE INDEX IDX_NP_NOTIFICATIONEVENT ON NOTIFICATION_PARAMETER
(
    NOTIFICATION_EVENT
  )
/