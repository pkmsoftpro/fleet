--Purpose    : Patch for creating CONFIG_PARAM tables
--Author     : Meghana Ganapaiah
--Created On : 23-SEP-2013
ALTER TABLE COSTCAT_APPL_CONTRACTS add CONSTRAINT FLEET_CONTRACT_FK FOREIGN KEY (FLEET_CONTRACT) REFERENCES CONTRACT (ID) ENABLE
/
ALTER TABLE COSTCAT_APPL_CONTRACTS add CONSTRAINT FK_FLEET_APP_COSTCAT FOREIGN KEY (FOR_APPLICABLE_COSTCAT) REFERENCES COST_CATEGORY (ID) ENABLE
/