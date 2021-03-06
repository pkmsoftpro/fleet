--PURPOSE    : PATCH TO ADD NEW TABLES AND INDEXES.
--AUTHOR     : Meghana Ganapaiah
--CREATED ON : 23RD September 2013

CREATE TABLE INBOX_VIEW
  (
    ID NUMBER(19,0) NOT NULL ENABLE,
    FIELD_NAMES CLOB,
    NAME                 VARCHAR2(255 BYTE) NOT NULL ENABLE,
    SORT_BY_FIELD        VARCHAR2(255 BYTE),
    SORT_ORDER_ASCENDING NUMBER(1,0) NOT NULL ENABLE,
    TYPE                 VARCHAR2(255 BYTE),
    VERSION              NUMBER(10,0) NOT NULL ENABLE,
    CREATED_BY           NUMBER(19,0),
    FOLDER_NAME          VARCHAR2(255 BYTE),
    CONSTRAINT INBOX_VIEW_PK PRIMARY KEY (ID) ENABLE
  )
/