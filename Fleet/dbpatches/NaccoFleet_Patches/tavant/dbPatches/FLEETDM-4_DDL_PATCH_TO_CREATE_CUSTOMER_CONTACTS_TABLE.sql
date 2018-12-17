--Purpose    : Patch for creating CUSTOMER_CONTACTS table
--Author     : Suneetha Nagaboyina
--Created On : 18-SEP-2013

CREATE TABLE CUSTOMER_CONTACTS
  (
    CUSTOMER NUMBER(19,0) NOT NULL ENABLE,
    CONTACT  NUMBER(19,0) NOT NULL ENABLE
  )
/