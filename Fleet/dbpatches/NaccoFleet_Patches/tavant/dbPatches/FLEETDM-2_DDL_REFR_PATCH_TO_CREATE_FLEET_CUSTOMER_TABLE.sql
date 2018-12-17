--Purpose    : Patch for creating forien keys for Fleet_customer table
--Author     : Suneetha Nagaboyina
--Created On : 23-SEP-2013
ALTER table FLEET_CUSTOMER  add CONSTRAINT FC_CUSTOMER_BILL_TO_FK  FOREIGN KEY (CUSTOMER_BILL_TO) REFERENCES CUSTOMER_LOCATIONS (ID) ENABLE
/
ALTER table FLEET_CUSTOMER add CONSTRAINT FLEET_CUSTOMER_ID_FK  FOREIGN KEY (ID) REFERENCES ORGANIZATION (ID) ENABLE
/