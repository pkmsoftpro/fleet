Insert into config_param 
(ID,DESCRIPTION,DISPLAY_NAME,NAME,TYPE,D_CREATED_ON,D_INTERNAL_COMMENTS,D_UPDATED_ON,D_LAST_UPDATED_BY,D_CREATED_TIME,D_UPDATED_TIME,D_ACTIVE,PARAM_DISPLAY_TYPE,LOGICAL_GROUP,LOGICAL_GROUP_ORDER,SECTIONS,SECTIONS_ORDER,PARAM_ORDER) values 
(CONFIG_PARAM_SEQ.nextval,'Display Legal Disclaimer','Display Legal Disclaimer','legalDisclaimerAllowed','boolean',null,null,null,null,null,null,1,'radio','SERVICE_REQUEST',1,'SR_INPUT_PARAMETERS',1,1)
/
Insert into config_param 
(ID,DESCRIPTION,DISPLAY_NAME,NAME,TYPE,D_CREATED_ON,D_INTERNAL_COMMENTS,D_UPDATED_ON,D_LAST_UPDATED_BY,D_CREATED_TIME,D_UPDATED_TIME,D_ACTIVE,PARAM_DISPLAY_TYPE,LOGICAL_GROUP,LOGICAL_GROUP_ORDER,SECTIONS,SECTIONS_ORDER,PARAM_ORDER) values 
(CONFIG_PARAM_SEQ.nextval,'Configured Cost Categories','Configured Cost Categories','configuredCostCategories','tavant.twms.domain.claim.payment.CostCategory',null,null,null,null,null,null,1,null,null,1,null,1,1)
/
Insert into config_param 
(ID,DESCRIPTION,DISPLAY_NAME,NAME,TYPE,D_CREATED_ON,D_INTERNAL_COMMENTS,D_UPDATED_ON,D_LAST_UPDATED_BY,D_CREATED_TIME,D_UPDATED_TIME,D_ACTIVE,PARAM_DISPLAY_TYPE,LOGICAL_GROUP,LOGICAL_GROUP_ORDER,SECTIONS,SECTIONS_ORDER,PARAM_ORDER) values 
(CONFIG_PARAM_SEQ.nextval,'Selected items type will be allowed in quote entry as part replaced.','Replaced Items on Quote Configuration','replacedItemsOnQuoteConfiguration','java.lang.String',null,null,null,null,null,null,1,'multiselect','QUOTES',1,'QUOTE_INPUT_PARAMETERS',1,1)
/
Insert into CONFIG_PARAM_OPTION (ID,DISPLAY_VALUE,VALUE) values 
(CONFIG_PARAM_OPTION_SEQ.nextval,'Machine','Machine')
/
Insert into CONFIG_PARAM_OPTION (ID,DISPLAY_VALUE,VALUE) values
(CONFIG_PARAM_OPTION_SEQ.nextval,'YES','true')
/
Insert into CONFIG_PARAM_OPTION (ID,DISPLAY_VALUE,VALUE) values (
CONFIG_PARAM_OPTION_SEQ.nextval,'NO','false')
/
INSERT INTO config_param_options_mapping (id, param_id,option_id) VALUES(cfg_param_optns_mapping_seq.NEXTVAL,(SELECT id FROM config_param WHERE NAME='legalDisclaimerAllowed'),(SELECT id FROM config_param_option WHERE display_value ='YES'))
/
INSERT INTO config_param_options_mapping (id, param_id,option_id) VALUES(cfg_param_optns_mapping_seq.NEXTVAL,(SELECT id FROM config_param WHERE NAME='legalDisclaimerAllowed'),(SELECT id FROM config_param_option WHERE display_value ='NO'))
/
Insert into config_value values(CONFIG_VALUE_SEQ.nextval,1,null,(select id from config_param where name='legalDisclaimerAllowed'),sysdate,null,sysdate,(select id from org_user where login='system'),SYSTIMESTAMP,SYSTIMESTAMP,1,'AMER',(select id from config_param_option where display_value='YES'))
/
Insert into config_value values(CONFIG_VALUE_SEQ.nextval,1,null,(select id from config_param where name='legalDisclaimerAllowed'),sysdate,null,sysdate,(select id from org_user where login='system'),SYSTIMESTAMP,SYSTIMESTAMP,1,'EMEA',(select id from config_param_option where display_value='YES'))
/
Insert into config_value values(CONFIG_VALUE_SEQ.nextval,1,null,(select id from config_param where name='legalDisclaimerAllowed'),sysdate,null,sysdate,(select id from org_user where login='system'),SYSTIMESTAMP,SYSTIMESTAMP,1,'DUMMY',(select id from config_param_option where display_value='YES'))
/