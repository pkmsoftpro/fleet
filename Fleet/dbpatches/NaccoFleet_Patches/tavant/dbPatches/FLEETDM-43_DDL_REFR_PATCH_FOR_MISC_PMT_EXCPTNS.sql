--PURPOSE    : PATCH TO CREATE REference For MISC_PMT_EXCPTNS TABLE
--AUTHOR     : PAYAL MOONDRA
--CREATED ON : 18-SEP-2013


ALTER TABLE MISC_PMT_EXCPTNS ADD CONSTRAINT PYMT_EXCPTN_FOR_MISC_FK FOREIGN KEY (FOR_PYMT_EXCPTN) REFERENCES PAYMENT_EXCEPTIONS (ID)
/
ALTER TABLE MISC_PMT_EXCPTNS ADD CONSTRAINT MISC_FK FOREIGN KEY (FOR_MISCELLANEOUS) REFERENCES MISCELLANEOUS_EXCEPTIONS (ID)
/