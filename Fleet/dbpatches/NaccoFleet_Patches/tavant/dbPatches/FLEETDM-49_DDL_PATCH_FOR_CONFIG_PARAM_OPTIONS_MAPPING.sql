--Purpose    : Patch for creating CONFIG_PARAM tables
--Author     : Meghana Ganapaiah
--Created On : 23-SEP-2013
CREATE TABLE CONFIG_PARAM_OPTIONS_MAPPING
  (
    ID        NUMBER(20,0) NOT NULL ENABLE,
    PARAM_ID  NUMBER(20,0) NOT NULL ENABLE,
    OPTION_ID NUMBER(20,0) NOT NULL ENABLE,
    CONSTRAINT CONFIG_PARAM_OPTNS_MAPPING_PK PRIMARY KEY (ID) ENABLE,
    CONSTRAINT CONFIG_PARAM_OPTIONS_MAPPI_U01 UNIQUE (PARAM_ID, OPTION_ID) ENABLE
  )
/
CREATE SEQUENCE CFG_PARAM_OPTNS_MAPPING_SEQ MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 20 START WITH 110000000010840 CACHE 20 NOORDER NOCYCLE
/