--Purpose    : Patch for creating CONTRACT_AUDIT table
--Author     : Suneetha Nagaboyina
--Created On : 23-SEP-2013

CREATE TABLE CONTRACT_AUDIT
  (
    ID           NUMBER(19,0) NOT NULL ENABLE,
    COMMENTS     VARCHAR2(4000 CHAR),
    FOR_CONTRACT NUMBER(19,0) NOT NULL ENABLE,
    LIST_INDEX   NUMBER(3,0),
    VERSION      NUMBER(10,0) NOT NULL ENABLE,
    UPDATED_ON DATE,
    UPDATED_TIME TIMESTAMP (6),
    UPDATED_BY NUMBER(19,0),
    CONSTRAINT FK_FOR_CONTRACT FOREIGN KEY (FOR_CONTRACT) REFERENCES CONTRACT (ID) ENABLE
  )
/

CREATE SEQUENCE CONTRACT_AUDIT_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 20 START WITH 100000000000800 CACHE 20 NOORDER NOCYCLE
/