--Purpose    : Patch for creating CONFIG_PARAM tables
--Author     : Meghana Ganapaiah
--Created On : 23-SEP-2013
ALTER TABLE CONFIG_PARAM_OPTIONS_MAPPING add CONSTRAINT CFG_PARAM_MAP_CFG_PARAM_ID_FK FOREIGN KEY (PARAM_ID) REFERENCES CONFIG_PARAM (ID) ENABLE
/
ALTER TABLE CONFIG_PARAM_OPTIONS_MAPPING add CONSTRAINT CFG_PARAM_MAP_CFG_OPTN_ID_FK FOREIGN KEY (OPTION_ID) REFERENCES CONFIG_PARAM_OPTION (ID) ENABLE
/