--PURPOSE    : PATCH TO ALTER QUOTE_AUDIT TABLE
--AUTHOR     : PRIYANKA GAUTAM
--CREATED ON : 04-10-2013
alter table quote_audit add (
dealer_notes_for_customer VARCHAR2(4000 CHAR),
dealer_notes_for_nmhg VARCHAR2(4000 CHAR),
nmhg_Notes_For_Dealer VARCHAR2(4000 CHAR),
nmhg_Notes_For_Customer VARCHAR2(4000 CHAR),
customer_Notes_For_NMHG VARCHAR2(4000 CHAR),
customer_Notes_For_Dealer VARCHAR2(4000 CHAR),
problem_Reported VARCHAR2(4000 CHAR),
condition_Found VARCHAR2(4000 CHAR)
)
/