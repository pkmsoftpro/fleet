--PURPOSE    : PATCH TO CREATE PMT_OVRDS_FOR_LABOR TABLE
--AUTHOR     : PAYAL MOONDRA
--CREATED ON : 18-SEP-2013

CREATE TABLE PMT_OVRDS_FOR_LABOR
  (
    FOR_PYMT_OVERRIDES NUMBER(19,0),
    FOR_LABOR_PYMT     NUMBER(19,0)
  )
/