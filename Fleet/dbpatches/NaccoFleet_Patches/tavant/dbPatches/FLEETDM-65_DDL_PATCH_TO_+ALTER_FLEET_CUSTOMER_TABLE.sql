--Purpose    : Patch for altering Fleet_customer table
--Author     : Suneetha Nagaboyina
--Created On : 25-SEP-2013
alter table fleet_customer modify fiscal_start_date varchar2(255)
/
alter table fleet_customer modify fiscal_end_date varchar2(255)
/
alter table fleet_customer rename COLUMN CUSTOMER_CONTACT to CONTRACT_CONTACT
/
alter table fleet_customer modify CONTRACT_CONTACT NUMBER(19)
/
alter table fleet_customer modify CONSTRAINT "FC_CUSTOMER_BILL_TO_FK" disable
/
alter table fleet_customer DROP COLUMN customer_bill_to
/
alter table fleet_customer add (physical_address number(19,0))
/
alter table fleet_customer add CONSTRAINT "FC_CUST_PHYSICAL_ADDRESS_FK" FOREIGN KEY (physical_address) REFERENCES ADDRESS ("ID") enable
/