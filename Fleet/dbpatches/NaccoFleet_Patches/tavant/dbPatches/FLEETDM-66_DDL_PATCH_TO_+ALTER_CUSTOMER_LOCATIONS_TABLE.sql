--Purpose    : Patch for altering ustomer_locations table
--Author     : Suneetha Nagaboyina
--Created On : 25-SEP-2013

alter table customer_locations add (physical_address number(19,0))
/
alter table customer_locations add CONSTRAINT "FC_CUST_LOC_PHY_ADDRESS_FK" FOREIGN KEY (physical_address) REFERENCES ADDRESS ("ID") enable
/