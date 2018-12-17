 --PURPOSE    : PATCH TO ADD NEW TABLES AND INDEXES.
--AUTHOR     : Meghana Ganapaiah
--CREATED ON : 23RD September 2013
ALTER TABLE DEFAULT_FOLDER_VIEW add CONSTRAINT DEFAULT_FOLDER_VIEW_USER_FK FOREIGN KEY (CREATED_BY) REFERENCES ORG_USER (ID) ENABLE
/
ALTER TABLE DEFAULT_FOLDER_VIEW add CONSTRAINT DEFAULT_FOLDER_VIEW_INBXVW_FK FOREIGN KEY (DEFAULT_INBOX_VIEW) REFERENCES INBOX_VIEW (ID) ENABLE
/