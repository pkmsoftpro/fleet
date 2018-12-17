--Purpose    : Patch for creating SYNC_TRACKER table
--Author     : Suneetha Nagaboyina
--Created On : 04-OCT-2013
CREATE TABLE SYNC_STATUS
  (
    STATUS VARCHAR2(255 CHAR) NOT NULL ENABLE,
    D_CREATED_ON DATE,
    D_INTERNAL_COMMENTS VARCHAR2(255 CHAR),
    D_UPDATED_ON DATE,
    D_LAST_UPDATED_BY NUMBER(19,0),
    D_CREATED_TIME TIMESTAMP (6),
    D_UPDATED_TIME TIMESTAMP (6),
    D_ACTIVE NUMBER(1,0) DEFAULT 1,
    PRIMARY KEY (STATUS) ENABLE
  )
/