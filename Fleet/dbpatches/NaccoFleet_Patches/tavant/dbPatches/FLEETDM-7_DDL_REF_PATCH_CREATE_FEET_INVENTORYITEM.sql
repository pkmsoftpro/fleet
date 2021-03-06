--PURPOSE    : PATCH TO ALTER TABLE Fleet inventory item
--AUTHOR     : SUSHMA MANTHALE
--CREATED ON : 04-JULY-13


ALTER table FLEET_INVENTORY_ITEM ADD CONSTRAINT  FLEETINVENTORY_CUSTOMER_FK FOREIGN KEY (CUSTOMER) REFERENCES FLEET_CUSTOMER (ID) ENABLE
/
ALTER table FLEET_INVENTORY_ITEM ADD CONSTRAINT  FLEET_INV_ITEM_INV_ITEM_FK FOREIGN KEY (INVENTORY_ITEM) REFERENCES INVENTORY_ITEM (ID) ENABLE
/
 ALTER table FLEET_INVENTORY_ITEM ADD CONSTRAINT  FIM_BUSINESS_UNIT_INFO_FK  FOREIGN KEY (BUSINESS_UNIT_INFO) REFERENCES BUSINESS_UNIT (NAME) ENABLE
/
 ALTER table FLEET_INVENTORY_ITEM ADD CONSTRAINT  FIM_PREFERRED_DEALER_FK   FOREIGN KEY (PREFERRED_DEALER) REFERENCES SERVICE_PROVIDER (ID) ENABLE
/
 ALTER table FLEET_INVENTORY_ITEM ADD CONSTRAINT  FIM_ALTERNATE_DEALER_FK  FOREIGN KEY (ALTERNATE_DEALER) REFERENCES SERVICE_PROVIDER (ID) ENABLE
/