<div class="clear"></div>
<div  class="containerDiv">

        <div class="equipmentRowDivHeader cell-bottom-border">
           <div  class="cellDivHeader"><spring:message code="label.equipment.serialNumber" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.modelNumber" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.unitType" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.fuelType" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.warrantyEndDate" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.unitAge" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.hoursOnTruck" /></div>
            <div class="cellDivHeader"><spring:message code="label.equipment.leaseEndDate" /></div>
            <div class="cellDivHeader" ><spring:message code="label.equipment.equipmentCondition" /> </div>
        </div>
   
                           
     <div class="rowDiv cell-bottom-border">
            <div class="cellDiv" >{{equipment.serialNumber}}</div>
            <div class="cellDiv" >{{equipment.model.name}}</div>
            <div class="cellDiv" >{{equipment.activeFleetInventoryAudit.equipmentType}}</div>
            <div class="cellDiv" >{{equipment.inventoryItem.ofType.ModelPowerDesc}}</div>
            <div class="cellDiv">{{equipment.inventoryItem.wntyEndDate}}</div>
            <div class="cellDiv" >{{equipment.unitAge}}</div>
            <div class="cellDiv" >{{equipment.activeFleetInventoryAudit.annualAvailableHours}}</div>
            <div class="cellDiv" >{{equipment.leaseEndDate}}</div>
            <div class="cellDiv" >{{equipment.equipmentCondition}}</div>
   </div> 
</div>
<div class="clear"></div>
