--Purpose   : Patch for Removing columns from Quote_Audit table
--Author     : VAMSI KRISHNA JOLLA
--Created On : 23-SEP-2013
alter table quote_audit drop column UPDATED_BY
/
alter table quote_audit drop column UPDATED_TIME
/
alter table quote_audit drop column UPDATED_ON
/