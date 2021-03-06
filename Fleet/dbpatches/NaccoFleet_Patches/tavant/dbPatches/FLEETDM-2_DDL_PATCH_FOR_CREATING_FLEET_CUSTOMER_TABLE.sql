--Purpose    : Patch for creating Fleet_customer table
--Author     : Suneetha Nagaboyina
--Created On : 23-SEP-2013

CREATE TABLE FLEET_CUSTOMER
  (
    ID                          NUMBER(19,0) NOT NULL ENABLE,
    ACCOUNT_TYPE                VARCHAR2(255 CHAR),
    STATUS                      VARCHAR2(10 BYTE),
    FIRST_NAME                  VARCHAR2(255 BYTE),
    LAST_NAME                   VARCHAR2(255 BYTE),
    CUSTOMER_CONTACT            VARCHAR2(255 CHAR),
    CUSTOMER_NUMBER             VARCHAR2(4000 BYTE),
    CUSTOMER_BILL_TO            NUMBER(19,0),
    DAYS_TO_EXPIRE              NUMBER(19,0),
    DAYS_TO_PREINVOICE_APPROVAL NUMBER(19,0),
    IS_AUDIT_ENABLED            NUMBER(1,0),
    CLAIM_VS_QUOTE_AMT          NUMBER(19,2),
    QUOTE_VS_CLAIM_AMT          NUMBER(19,2),
    AUDIT_FREQUENCY             NUMBER(19,0),
    IS_DAY_TIME_EMERGENCY       NUMBER(1,0),
    IS_TELEMETRY_ENABLED        NUMBER(1,0),
    IS_EMAIL_SCRAP_ENABLED      NUMBER(1,0),
    FISCAL_START_DATE DATE,
    FISCAL_END_DATE DATE,
    NIGHT_SAT_MULTIPLIER NUMBER(19,0),
    SUNDAY_MULTIPLIER    NUMBER(19,0),
    HOLIDAY_MULTIPLIER   NUMBER(19,0),
    QUOTE_VS_CLAIM_CURR  VARCHAR2(255 CHAR),
    CLAIM_VS_QUOTE_CURR  VARCHAR2(255 CHAR),
    SPECIAL_INSTRUCTIONS VARCHAR2(255 CHAR),
    CONSTRAINT FLEET_CUSTOMER_PK PRIMARY KEY (ID) ENABLE
  )
/