      <div data-ng-readOnly="true">
				<div class="labelStyle floatL">
					<span><spring:message code="label.equipmentdetails.LTDSpend" /></span>		
				</div>
				
				<div class="floatL marR20">
					<input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.ltdSpend" money/>
				</div>

				<div class="labelStyle floatL">
					<span><spring:message code="label.equipmentdetails.YTDSpend" /></span>
					
				</div>
				<div class="floatL marR20">
					<input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.ytdSpend" money/>
				</div>
		</div>	
		
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
			
		<div data-ng-readOnly="true">
				<div class="labelStyle floatL">
					<span><spring:message code="label.equipmentdetails.AverageDailyCost" /></span>
				</div>
				<div class="floatL marR20">
					<input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.averageDailyCost" money/>
				</div>
								
				<div class="labelStyle floatL">
							<span><spring:message code="label.equipmentdetails.Rolling12MonthCostperHour" />
							</span>
				</div>
				
				<div class="floatL marR20">
					<input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.rollingYearlyCostPerHour" money/>
				</div>
				
		</div>	
		
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		
   		<div ng-show = "isInternalUser || isDealerOwned">		
				<div class="labelStyle floatL">
							<span><spring:message code="label.equipmentdetails.AcquisitionCost" /></span>
				</div>
				<input type="hidden" data-ng-bind="fleetInventoryItem.equipmentFinancialInfo.acquisitionCost.currency = fleetInventoryItem.equipmentFinancialInfo.acquisitionCost.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.equipmentFinancialInfo.acquisitionCost.currency"/>
				<div class="floatL marR20">
					<input message id='serialNumber' name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.acquisitionCost" money/>
				</div>
				<div class="labelStyle floatL">
							<span><spring:message code="label.equipmentdetails.EstimatedReplacementCost" /></span>
				</div>
				<input type="hidden" data-ng-bind="fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost.currency = fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost.currency"/>
				<div class="floatL marR20">			
					<input type="text" name="estimatedReplacementCost" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost"  money/>
				</div>
				
		</div>
        
        <div ng-show = "isCustomerUser" data-ng-readOnly="true">              
                <div class="labelStyle floatL">
                            <span><spring:message code="label.equipmentdetails.AcquisitionCost" /></span>
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.equipmentFinancialInfo.acquisitionCost.currency = fleetInventoryItem.equipmentFinancialInfo.acquisitionCost.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.equipmentFinancialInfo.acquisitionCost.currency"/>
                <div class="floatL marR20">
                    <input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.acquisitionCost" data-ng-readOnly="true" money/>
                </div>
                <div class="labelStyle floatL">
                            <span><spring:message code="label.equipmentdetails.EstimatedReplacementCost" /></span>
                </div>
                <input type="hidden" data-ng-bind="fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost.currency = fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost.currency"/>
                <div class="floatL marR20">         
                    <input type="text" name="estimatedReplacementCost" data-disable="true" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.estimatedReplacementCost" data-ng-readOnly="true" money/>
                </div>
                
        </div>	
		
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div>
				<div class="labelStyle floatL">
							<span><spring:message code="label.equipmentdetails.EstimatedMarketValue" /></span>
				</div>
				<input type="hidden" data-ng-bind="fleetInventoryItem.equipmentFinancialInfo.estimatedMarketValue.currency = fleetInventoryItem.equipmentFinancialInfo.estimatedMarketValue.currency==null?fleetInventoryItem.preferredCurrency:fleetInventoryItem.equipmentFinancialInfo.estimatedMarketValue.currency"/>
				<div ng-show = "isInternalUser || isDealerOwned" class="floatL marR20">
					<input message id='serialNumber' name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.estimatedMarketValue" money/>
				</div>
                <div ng-show = "isCustomerUser" class="floatL marR20">
                    <input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.estimatedMarketValue"   money/>
                </div>
                
                <div class="labelStyle floatL">
                            <span><spring:message code="label.equipmentdetails.LifetoDateCost" /></span>
                </div>
                
                <div class="floatL small-input-wrapper">
                    <input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo.lifeToDateCostPerHour" data-ng-readOnly="true" money/>
                    <span><spring:message code="label.equipmentdetails.perhour"/></span>
                </div>

				<!-- <div class="labelStyle floatL">
							<span><spring:message code="label.equipmentdetails.TotalProfit" /></span>
				</div>
				
				<div class="floatL marR20">
					<input message id='serialNumber' data-disable="true" name="serialNumber" data-ng-model="fleetInventoryItem.equipmentFinancialInfo." data-ng-readOnly="true" money/>
				</div> -->
				
		</div>