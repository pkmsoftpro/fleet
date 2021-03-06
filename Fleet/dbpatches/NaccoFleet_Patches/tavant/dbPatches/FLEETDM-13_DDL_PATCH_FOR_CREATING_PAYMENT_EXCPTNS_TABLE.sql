--Purpose    : Patch for creating PAYMENT_EXCEPTIONS table
--Author     : Suneetha Nagaboyina
--Created On : 23-SEP-2013

CREATE TABLE PAYMENT_EXCEPTIONS
  (
    ID NUMBER(19,0) NOT NULL ENABLE,
    D_CREATED_ON DATE,
    D_INTERNAL_COMMENTS VARCHAR2(255 CHAR),
    D_UPDATED_ON DATE,
    D_LAST_UPDATED_BY NUMBER(19,0),
    D_CREATED_TIME TIMESTAMP (6),
    D_UPDATED_TIME TIMESTAMP (6),
    D_ACTIVE NUMBER(1,0) DEFAULT 1,
    CONSTRAINT OEM_PART_EXCEPTIONS_PK PRIMARY KEY (ID) ENABLE
  )
/

CREATE SEQUENCE PYMT_EXCPTNS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 20 START WITH 110000000001640 CACHE 20 NOORDER NOCYCLE
/