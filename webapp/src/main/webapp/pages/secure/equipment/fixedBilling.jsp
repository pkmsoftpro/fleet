<div ng-show = "readOnly">	

	<div ng-show = "isInternalUser || isCustomerUser">
	
		<div>
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.AdminFee" />
				</div>
				
				<div ng-show = "isInternalUser">
					<div class="floatL marR20">
						<input type="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="billing.adminFeeAmt" money/>
					</div>
				</div>
			
				<div ng-show = "isCustomerUser">
					<div class="floatL marR20">
						<input type="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="billing.adminFeeForCustomer" money/>
					</div>
				</div>
				
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.MaintenanceFee" />
				</div>
				
				<div class="floatL marR20">
					<input type="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="billing.fleetMaintAmt" money/>
				</div>
				
		</div>	
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
				
			<div ng-hide = "isCustomerUser">
				
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.Profit" />
				</div>
				
				<div class="floatL marR20">
					<input type="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="billing.profit" money/>
				</div>
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.AdminTaxable" />
				</div>
				
				<div class="floatL marR20">
					<input type="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="billing.adminFeeTaxAmt" money/>
				</div>
		</div>	
		
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
        <div>   				
		    <div ng-if="billing.leaseAmt.amount>0">
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.LeaseFee" />
				</div>
				
				<div class="floatL marR20">
					<input type="text" data-disable="true"  ng-style="{width:'182px'}" data-ng-model="billing.leaseAmt" money/>
				</div>
			</div>	
				
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.Hourlybilling" />
				</div>
				
				<div class="floatL marR20">
					<input type="text" data-disable="true"  ng-style="{width:'182px'}" data-ng-model="billing.hourlyMaintAmt" money/>
				</div>
		</div>	
	</div>
</div>	
        
        
        
        
<div ng-show='!readOnly'>
        
            <div>

                <div class="labelStyle floatL">
                            <spring:message code="label.equipmentdetails.AdminFee" />
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.recentBilling.adminFeeAmt.currency = fleetInventoryItem.recentBilling.adminFeeAmt.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.recentBilling.adminFeeAmt.currency"/>
                
                <div class="floatL marR20">
                    <input type="text"  ng-style="{width:'182px'}" data-ng-model="fleetInventoryItem.recentBilling.adminFeeAmt" money/>
                </div>
                
                <div class="labelStyle floatL">
                            <spring:message code="label.equipmentdetails.MaintenanceFee" />
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.recentBilling.fleetMaintAmt.currency = fleetInventoryItem.recentBilling.fleetMaintAmt.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.recentBilling.fleetMaintAmt.currency"/>
                <div class="floatL marR20">
                    <input type="text"  ng-style="{width:'182px'}" data-ng-model="fleetInventoryItem.recentBilling.fleetMaintAmt" money/>
                </div>
                
           </div>  
            <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
                
            <div>
                
                <div class="labelStyle floatL">
                            <spring:message code="label.equipmentdetails.Profit" />
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.recentBilling.profit.currency = fleetInventoryItem.recentBilling.profit.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.recentBilling.profit.currency"/>
                <div class="floatL marR20">
                    <input type="text"  ng-style="{width:'182px'}" data-ng-model="fleetInventoryItem.recentBilling.profit" money/>
                </div>
                <div class="labelStyle floatL">
                            <spring:message code="label.equipmentdetails.AdminTaxable" />
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.recentBilling.adminFeeTaxAmt.currency = fleetInventoryItem.recentBilling.adminFeeTaxAmt.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.recentBilling.adminFeeTaxAmt.currency"/>
                <div class="floatL marR20">
                    <input type="text"  ng-style="{width:'182px'}" data-ng-model="fleetInventoryItem.recentBilling.adminFeeTaxAmt" money/>
                </div>
          </div>  
            <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
          <div>                   
            <div ng-if="billing.leaseAmt.amount>0 || isDealerOwned">
                <div class="labelStyle floatL">
                            <spring:message code="label.equipmentdetails.LeaseFee" />
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.recentBilling.leaseAmt.currency = fleetInventoryItem.recentBilling.leaseAmt.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.recentBilling.leaseAmt.currency"/>
                <div class="floatL marR20">
                    <input type="text"   ng-style="{width:'182px'}" data-ng-model="fleetInventoryItem.recentBilling.leaseAmt" money/>
                </div>
            </div>  
                
                <div class="labelStyle floatL">
                            <spring:message code="label.equipmentdetails.Hourlybilling" />
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.recentBilling.hourlyMaintAmt.currency = fleetInventoryItem.recentBilling.hourlyMaintAmt.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.recentBilling.hourlyMaintAmt.currency"/>
                <div class="floatL marR20">
                    <input type="text"   ng-style="{width:'182px'}" data-ng-model="fleetInventoryItem.recentBilling.hourlyMaintAmt" money/>
                </div>
         </div>
</div>