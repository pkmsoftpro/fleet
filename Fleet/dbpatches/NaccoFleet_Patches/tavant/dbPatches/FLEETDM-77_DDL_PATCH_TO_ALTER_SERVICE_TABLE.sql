--Purpose    : Patch to alter SERVICE table
--Author     : Priyanka Gautam
--Created On : 07-OCT-2013
ALTER TABLE SERVICE
ADD (
"DRAYAGE_AMT" NUMBER(19,2),
"DRAYAGE_CURR" VARCHAR2(255 CHAR)
)
/