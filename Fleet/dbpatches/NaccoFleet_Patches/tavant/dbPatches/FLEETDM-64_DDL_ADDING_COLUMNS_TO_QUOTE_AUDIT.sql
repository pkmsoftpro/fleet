--Purpose    : Patch for Adding and Renaming the columns in Quote Audit table
--Author     : VAMSI KRISHNA JOLLA
--Created On : 20-SEP-2013

alter table quote_audit add (D_LAST_UPDATED_BY NUMBER(19,0))
/
alter table quote_audit add (D_UPDATED_ON DATE)
/
alter table quote_audit add (D_UPDATED_TIME TIMESTAMP(6))
/
alter table quote_audit add (D_CREATED_ON DATE)
/
alter table quote_audit add (D_CREATED_TIME TIMESTAMP(6))
/
alter table quote_audit add (D_ACTIVE NUMBER(1,0))
/
alter table quote_audit rename column INTERNAL_COMMENTS to D_INTERNAL_COMMENTS
/