--PURPOSE    : PATCH TO ADD NEW TABLES AND INDEXES.
--AUTHOR     : Meghana Ganapaiah
--CREATED ON : 23RD September 2013
ALTER TABLE USER_ATTR_VALUE add CONSTRAINT USERATTRVALUE_ID_FK FOREIGN KEY (ID) REFERENCES ATTR_VALUE (ID) ENABLE
/