--PURPOSE    : PATCH TO ADD TABLE JBPM_POOLEDACTOR 
--AUTHOR     : SUSHMA MANTHALE
--CREATED ON : 16-JULY-13


CREATE TABLE JBPM_POOLEDACTOR 
(	
   ID_                 NUMBER(19,0) NOT NULL ENABLE, 
   ACTORID_            VARCHAR2(255 CHAR), 
   SWIMLANEINSTANCE_   NUMBER(19,0), 
   CONSTRAINT JBPM_POOLEDACTOR_PK PRIMARY KEY (ID_)
)
/