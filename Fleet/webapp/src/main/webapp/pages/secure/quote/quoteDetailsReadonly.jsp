<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.general" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.quote.quoteNumber" />
    </div>
     <div class="floatL">
        <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.quoteNumber" data-ng-init="quote.quoteNumber='Draft'" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.quote.serialNumber" />
        <span class="red">*</span>
    </div>
     <div class="floatL"></div>
    <div data-ng-if="quote.id!=null">
        <a ng-href="#" data-ng-click="equipmentHistoryPageDetail()">{{quote.serviceRequest.forItem.serialNumber}}</a>
    </div>
    <div data-ng-if="quote.id==null">
        <INPUT TYPE="text" id='serialNumber' url="listInventoryItems" data-ng-model="quote.serviceRequest.forItem.serialNumber"
            fbs-typeahead required />
        <div ng-show="quote.serviceRequest.forItem.serialNumber" class="floatR hgt30 wid20">
            <img id="serialNumberAlert" src="/webapp/image/ui-ext/validation/alerts.gif"
                class="serialnumber-alert" tooltip="<spring:message code='label.common.serialNumber.invalid'/>" />
        </div>
    </div>
    <div class="clear"></div>

    <div>
        <div class="labelStyle floatL">
            </span>
            <spring:message code="label.quote.customerPoNumber" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-hide="readAndEditPO" maxlength="{{quote.serviceRequest.customerLocation.purchaseOrderLength}}" 
            	 data-ng-model="quote.serviceRequest.activeServiceRequestAudit.customerPoNumber" data-ng-readonly="true"
            	 ng-blur="validatePONumber(quote.serviceRequest.activeServiceRequestAudit.customerPoNumber,quote.serviceRequest.customerLocation.id)">
        </div>
		<div class="floatL" >
            <INPUT TYPE="text"  data-ng-readonly="true" data-ng-show="readAndEditPO" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.customerPoNumber" id="customerPoNumber">
        </div>
         <div class="fieldSpacerWidth floatL">
                	 <div ng-if="PONumberDuplicate">
                    	 <div ng-show='PONumberDuplicate' class="floatL">
                        <img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                            tooltip="<spring:message code='label.serviceRequest.PONumber.invalid'/>" />
                    	</div>
                    </div>
                    <div ng-if="PONumberExits">
                    	 <div ng-show='PONumberExits' class="floatL">
                        <img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                            tooltip="<spring:message code='label.serviceRequest.PONumber.duplicate'/>" />
                    	</div>
                    </div>
                    
                </div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.serviceRequestNumber" />
            <span class="red">*</span>
        </div>
        <div data-ng-if="quote.id==null">
            <div class="floatL" id='listServiceRequests'>
                <select data-ng-model="quote.serviceRequest.id"
                    ng-options="serviceRequest.key as serviceRequest.label for serviceRequest in serviceRequests" class="wid223 hgt26"
                    required>
                </select>
            </div>
        </div>
        <div data-ng-if="quote.id!=null">
             <div class="floatL">
                 <div class="floatL">
                    <a ng-href="#" data-ng-click="quoteServiceRequestDetail()">{{quote.serviceRequest.serviceRequestNumber}}</a>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <div>

        <div class="labelStyle floatL">
            <spring:message code="label.quote.workOrderNumber" />
        </div>
        <div data-ng-if="quote.id==null">
             <div class="floatL">
                <INPUT TYPE="text" data-ng-readonly="false" data-ng-model="activeAudit.workOrderNumber" >
            </div>
        </div>
        <div data-ng-if="quote.id!=null">
             <div class="floatL">
                <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="activeAudit.workOrderNumber">
            </div>
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.dateReceived" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" value="{{quote.serviceRequest.updatedTime | date:dateFormat}}">
        </div>
    </div>
     <div class="clear"></div>
     

			<div ng-show="isInternalUserOrOwningDealer">
				<div class="labelStyle floatL">
					<spring:message code="label.quote.applicableContract" />
				</div>

				<div>
					<div class="floatL">
						<a href="#" data-ng-click="navigateToCreateContractPage()">{{quote.serviceRequest.contractCode}}</a>
					</div>
				</div>
				<div class="fieldSpacerWidth floatL">&nbsp;</div>
				<div class="labelStyle floatL"></div>
				<div class="floatL"></div>
			</div>
			<div ng-show="isInternalUserOrOwningDealer" class="clear"></div>

		
    <div ng-show="activeAudit.recommendationFlag">
    	 <div class="labelStyle floatL">
            <spring:message code="label.common.quote.fleetRecomendation" />
        </div>
        <div class="floatL" style="float: left;margin-right: 380px;">
                <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="activeAudit.fleetRecommendation.description">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
         <div class="labelStyle floatL">
            <spring:message code="label.common.quote.fleetRecomendation.comments" />
        </div>
         <div class="floatL" >
                <textarea max-length data-ng-readonly="true" rows="4" cols="500" data-ng-model="activeAudit.recommendationComments" class="wid500"  ></textarea>
            </div>
    </div>
</div>
<div class="clear"></div>


<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.customerInfo" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.customerName" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.serviceRequest.customerLocation.customerName">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="labelStyle floatL">
            <spring:message code="label.common.customerNumber" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.serviceRequest.billTo">
        </div>
    </div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.quote.customerLocation" />
    </div>
     <div class="floatL">
        <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.serviceRequest.customerLocation.locationsMapkey">
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.quote.customerPhoneNumber" />
    </div>
     <div class="floatL">
        <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.serviceRequest.customerPhoneNumber">
    </div>

    <div class="clear"></div>
    <div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.customerAddress" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.serviceRequest.customerLocation.address.addressLine1">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.customerContract" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.serviceRequest.customerContact">
        </div>
    </div>

    <div class="clear"></div>

    <div>

  


            <div ng-show="isCustomerUser" class="labelStyle floatL">
                <spring:message code="label.common.threshold" />:
            </div>
            <div  ng-show="isCustomerUser" class="floatL marR20">
                <INPUT TYPE="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="quote.serviceRequest.customerLocation.quoteThreshold" money>
            </div>


            <div class="labelStyle floatL" ng-show="servicingDealer">
                <spring:message code="label.common.threshold" />:
            </div>
            <div ng-show="servicingDealer" class="floatL marR20">
                <span ng-bind="quote.serviceRequest.customerLocation.preferredCurrency"></span><input type="text" ng-readonly="true" ng-style="{width:'182px'}"
                    ng-model="dealerThreshold"> </input>
            </div>


          <div ng-show="isInternalUserOrOwningDealer" class="labelStyle floatL">
                <spring:message code="label.common.customerThreshold" />:
            </div>
            <div ng-show="isInternalUserOrOwningDealer" class="floatL marR20">
                <INPUT TYPE="text" data-disable="true" ng-style="{width:'182px'}" data-ng-model="quote.serviceRequest.customerLocation.quoteThreshold" money>
            </div>
            <div ng-show="isInternalUserOrOwningDealer" class="labelStyle floatL">
                <spring:message code="label.serviceRequest.dealerQuoteThreshold" />
            </div>
            <div ng-show="isInternalUserOrOwningDealer" class="floatL marR20">
                <span ng-bind="quote.serviceRequest.customerLocation.preferredCurrency"></span><input type="text" ng-readonly="true" ng-style="{width:'182px'}"
                    ng-model="dealerThreshold"> </input>
            </div>

        <div class="fieldSpacerWidth floatL">&nbsp;</div>
    </div>
</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.dealership" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.dealerName" />
            <span class="red">*</span>
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.forDealer.name">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.dealerPhoneNumber" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="quote.forDealer.address.phone">
        </div>
    </div>
</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.callCondition" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">

    <div ng-show="isInternalUserOrOwningDealer">
		<div class="labelStyle floatL"><spring:message code="label.quote.callType"/><span class="red">*</span></div>
		<div class="hgt28 floatL">
		<select data-ng-model="quote.serviceRequest.activeServiceRequestAudit.callType.id" disabled="disabled"
			ng-options="callType.listOfValues.id as callType.listOfValues.name for callType in callTypes"  class="wid223 hgt26"></select></div>
   </div>
       <div ng-show="isInternalUserOrOwningDealer" class="clear"></div>
    <div ng-show="isInternalUserOrOwningDealer">
        <div class="labelStyle floatL">
            <spring:message code="label.quote.equipmentDown" />
        </div>
         <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio"  data-ng-model="quote.serviceRequest.activeServiceRequestAudit.equipmentDown" ng-value='true' disabled="disabled"
                ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio"  data-ng-model="quote.serviceRequest.activeServiceRequestAudit.equipmentDown" ng-value='false' disabled="disabled"
                ng-boolean-radio />
            <div class="floatR marL5" ng-show='quote.serviceRequest.activeServiceRequestAudit.equipmentDown'>
                 <img src="../image/Redwarning.png" />
            </div> 
        </div>
    </div>
    <div ng-show="isInternalUserOrOwningDealer" class="clear-hgt7"></div>
    <div ng-show="isInternalUserOrOwningDealer">
       <div class=" floatL">
            <div ng-show="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest!=true" class="labelStyleforNOEmergencyRequest">
                 <spring:message code="label.serviceRequest.emergencyRequest" />
            </div>
             <div ng-show="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest==true" class="labelStyleforEmergencyRequest">
                 <spring:message code="label.serviceRequest.emergencyRequest" />
            </div>
        </div>
         <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio"  data-ng-model="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest" ng-value='true' disabled="disabled"
                ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio"  data-ng-model="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest" ng-value='false' disabled="disabled"
                ng-boolean-radio />
        </div>
    </div>
    <div ng-show="isInternalUserOrOwningDealer" class="clear-hgt7"></div>
    <div ng-show="isInternalUserOrOwningDealer">
        <div class="labelStyle floatL">
            <spring:message code="label.quote.quoteJob" />
        </div>
         <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio"  data-ng-model="quote.serviceRequest.activeServiceRequestAudit.quoteRequired" ng-value='true' disabled="disabled"
                ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.quoteRequired" ng-value='false' disabled="disabled"
                ng-boolean-radio />
        </div>
    </div>


    <div ng-show="!isInternalUserOrOwningDealer">
        <div class="labelStyle floatL">
            <spring:message code="label.quote.callType" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="associatedCallType.description">
        </div>
    </div>
    <div ng-show="!isInternalUserOrOwningDealer" class="clear-hgt7"></div>
    <div ng-show="!isInternalUserOrOwningDealer">
        <div class="labelStyle floatL">
            <spring:message code="label.quote.equipmentDown" />
        </div>
         <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" disabled="disabled" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.equipmentDown" ng-value='true'
                ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" disabled="disabled" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.equipmentDown" ng-value='false'
                ng-boolean-radio />
                <div class="floatR marL5" ng-show='quote.serviceRequest.activeServiceRequestAudit.equipmentDown'>
                  <img src="../image/Redwarning.png" />
            	</div>  
        </div>
    </div>
    <div ng-show="!isInternalUserOrOwningDealer" class="clear-hgt7"></div>
    <div ng-show="!isInternalUserOrOwningDealer">
        <div class=" floatL">
            <div ng-show="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest!=true" class="labelStyleforNOEmergencyRequest">
                 <spring:message code="label.serviceRequest.emergencyRequest" />
            </div>
             <div ng-show="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest==true" class="labelStyleforEmergencyRequest">
                 <spring:message code="label.serviceRequest.emergencyRequest" />
            </div>
        </div>
         <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" disabled="disabled" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest" ng-value='true'
                ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" disabled="disabled" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.emergencyRequest" ng-value='false'
                ng-boolean-radio />
        </div>
    </div>
    <div ng-show="!isInternalUserOrOwningDealer" class="clear-hgt7"></div>
    <div ng-show="!isInternalUserOrOwningDealer">
        <div class="labelStyle floatL">
            <spring:message code="label.quote.quoteJob" />
        </div>
         <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" disabled="disabled" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.quoteRequired" ng-value='true'
                ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" disabled="disabled" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.quoteRequired" ng-value='false'
                ng-boolean-radio />
        </div>
    </div>

</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.problemDescription" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div>
        <div class="labelStyle floatL">
            <spring:message code="label.quote.ErrorCode" />
        </div>
         <div class="floatL">
            <INPUT TYPE="text" data-ng-model="quote.serviceRequest.activeServiceRequestAudit.errorCode.code" data-ng-readonly="true">
        </div>
    </div>
    <div class="clear"></div>
    <div>
        <div class="labelStyle floatL">
            </span>
            <spring:message code="label.quote.potentialProblemDescription" />
        </div>
         <div class="floatL">
            <textarea data-ng-model="quote.serviceRequest.activeServiceRequestAudit.problemDescription" rows="4" cols="500" class="wid500"
                my-maxlength data-ng-readonly="true"></textarea>
        </div>
    </div>
</div>