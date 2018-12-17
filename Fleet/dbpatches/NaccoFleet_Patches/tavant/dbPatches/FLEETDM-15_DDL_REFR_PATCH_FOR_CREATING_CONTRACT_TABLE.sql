--Purpose    : Patch for creating foreign keys for CONTRACT table
--Author     : Suneetha Nagaboyina
--Created On : 23-SEP-2013

ALTER TABLE CONTRACT add CONSTRAINT FT_CRT__FOR_CUST_FK FOREIGN KEY (FOR_CUSTOMER) REFERENCES FLEET_CUSTOMER (ID) ENABLE
/
ALTER TABLE CONTRACT add CONSTRAINT FT_CRT_SHIP_ADDRESS_FK FOREIGN KEY (SHIP_TO) REFERENCES CUSTOMER_LOCATIONS (ID) ENABLE
/
ALTER TABLE CONTRACT add CONSTRAINT APPL_DLR_PYMT_EXCPTNS_FK FOREIGN KEY (APPL_DLR_PYMT_EXCPTNS) REFERENCES PAYMENT_EXCEPTIONS (ID) ENABLE
/
ALTER TABLE CONTRACT add CONSTRAINT APPL_DLR_PYMT_OVERRIDES_FK FOREIGN KEY (APPL_DLR_PYMT_OVERRIDES) REFERENCES PAYMENT_OVERRIDES (ID) ENABLE
/