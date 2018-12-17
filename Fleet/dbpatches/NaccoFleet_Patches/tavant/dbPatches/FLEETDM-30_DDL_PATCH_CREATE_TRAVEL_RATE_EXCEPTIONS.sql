--PURPOSE    : PATCH TO ADD TABLE TRAVEL_RATE_EXCEPTIONS
--AUTHOR     : SUSHMA MANTHALE
--CREATED ON : 16-JULY-13

CREATE TABLE TRAVEL_RATE_EXCEPTIONS
  (
    ID                     NUMBER(19,0) NOT NULL ENABLE,
    START_DATE             DATE,
    END_DATE               DATE,
    DEALER                 NUMBER(19,0),
    MODIFIER_PERCENTAGE    FLOAT(126),
    CONSTRAINT TRAVEL_RATE_EXCPTNS_PK PRIMARY KEY (ID) ENABLE,
    CONSTRAINT TRAVEL_RATES_DEALER_FK FOREIGN KEY (DEALER) REFERENCES SERVICE_PROVIDER (ID) ENABLE
  )
/
CREATE SEQUENCE TRAVEL_RATE_EXCPTNS_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 20 START WITH 110000000001240 CACHE 20 NOORDER NOCYCLE
/