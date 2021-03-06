--Purpose    : Patch for creating Number pattern table
--Author     : Sushma Manthale
--Created On : 18-SEP-2013

CREATE TABLE NUMBER_PATTERN
  (
    ID                    NUMBER(19,0),
    NUMBERING_PATTERN     NUMBER(19,0),
    IS_ACTIVE             NUMBER(1,0),
    SEQUENCE_NAME         VARCHAR2(255 CHAR),
    PATTERN_TYPE          VARCHAR2(255 CHAR),
    TEMPLATE              VARCHAR2(255 CHAR),
    D_CREATED_ON          DATE,
    D_INTERNAL_COMMENTS   VARCHAR2(255 CHAR),
    D_UPDATED_ON          DATE,
    D_LAST_UPDATED_BY     NUMBER(19,0),
    D_CREATED_TIME        TIMESTAMP (6),
    D_UPDATED_TIME        TIMESTAMP (6),
    D_ACTIVE             NUMBER(1,0) DEFAULT 1,
    BUSINESS_UNIT_INFO    VARCHAR2(255 CHAR),
    CONSTRAINT NUMBER_PATTERN_ID_PK PRIMARY KEY (ID) ENABLE,
    CONSTRAINT NP_BUSINESS_UNIT_INFO_FK FOREIGN KEY (BUSINESS_UNIT_INFO) REFERENCES BUSINESS_UNIT (NAME) ENABLE
  )
/
CREATE SEQUENCE NUMBER_PATTERN_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 20 START WITH 100000000003200 CACHE 20 NOORDER NOCYCLE
/
CREATE SEQUENCE QUOTE_NUMBER_SEQ MINVALUE 10000000 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10000219 NOCACHE NOORDER NOCYCLE
/
CREATE SEQUENCE SERVICE_REQUEST_NUMPATTERN_SEQ MINVALUE 10000000 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10000219 NOCACHE NOORDER NOCYCLE
/
