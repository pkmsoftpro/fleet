--Purpose    : Patch for creating CONTRACT_FOR_APPL_MACHINE table
--Author     : Suneetha Nagaboyina
--Created On : 23-SEP-2013

CREATE TABLE CONTRACT_FOR_APPL_MACHINE
  (
    FLEET_CONTRACT          NUMBER(19,0),
    FOR_APPLICABLE_MACHINES NUMBER(19,0)
  )
/