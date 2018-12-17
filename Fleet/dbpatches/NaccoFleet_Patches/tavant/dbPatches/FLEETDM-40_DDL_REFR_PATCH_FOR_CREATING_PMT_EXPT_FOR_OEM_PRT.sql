 --Purpose    : Patch for creating PMT_EXPT_FOR_OEM_PRT
--Author     : Meghana Ganapaiah
--Created On : 23-SEP-2013
ALTER TABLE PMT_EXPT_FOR_OEM_PRT add CONSTRAINT PYMT_EXCPTN_FK FOREIGN KEY (FOR_PYMT_EXCPTN) REFERENCES PAYMENT_EXCEPTIONS (ID) ENABLE
/
ALTER TABLE PMT_EXPT_FOR_OEM_PRT add CONSTRAINT OEM_PARTS_FK FOREIGN KEY (FOR_OEMPARTS) REFERENCES OEM_PART_EXCEPTIONS (ID) ENABLE
/