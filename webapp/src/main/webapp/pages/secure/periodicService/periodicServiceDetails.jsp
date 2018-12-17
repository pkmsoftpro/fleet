<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="../admin/servicecode/i18N_servicecode_javascript_vars.jsp"%>
<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.periodicService.serviceRequestDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.serviceRequestNumber" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.serviceRequest.serviceRequestNumber" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.customerLocation" />
        <span class="red">*</span>
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.activeFleetInventoryAudit.shipTo.locationsMapkey" />
    </div>    
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.serialNumber" />
    </div>
     <div class="floatL" style="width:220px ; height:20px">
        <a ng-href="#" data-ng-click="equipmenttDetail()">{{serviceCall.associatedServiceCode.fleetInventoryItem.serialNumber}}</a>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.customerName" />
        <span class="red">*</span>
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.activeFleetInventoryAudit.shipTo.customer.name" />
    </div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.modelNumber" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.model.name" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.customerBillTo" />
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerBillTo" />
    </div>
</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.periodicService.locationInformation" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.locationName" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.activeFleetInventoryAudit.shipTo.locationsMapkey" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.locationAddress" />
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.activeFleetInventoryAudit.shipTo.address.addressLine1" />
    </div>
    <div class="clear"></div>
    
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.country" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.activeFleetInventoryAudit.shipTo.address.country" />
    </div>
</div>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.periodicService.dealership" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.dealerName" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.preferredDealer.name" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.dealerNumber" />
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.preferredDealer.serviceProviderNumber" />
    </div>
    <div class="clear"></div>
    
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.dealerPhoneNumber" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.preferredDealer.address.phone" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.dealerAddress" />
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.fleetInventoryItem.preferredDealer.address.addressLine1" />
    </div>
</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.periodicService.serviceDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.serviceCode" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="serviceCall.associatedServiceCode.serviceCode.code" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.jobCode" />
    </div>
     <div class="floatL"></div>
      <div>
        <input type="text" data-ng-readonly="true" data-ng-model="jobCodes"/>
    </div>
    <div class="clear"></div>
   <div class="labelStyle floatL">
        <spring:message code="label.periodicService.serviceDueOn" />
    </div>
     <div class="floatL">
        <input type="text" data-ng-disabled="serviceCall.status=='COMPLETED' || isReadOnly" data-ng-model="serviceCall.dueDate" datepicker-popup="{{dateFormat}}" />
    </div>
     <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.lastServicePerformedOn" />
    </div>
    <div class="floatL">
        <input type="text" data-ng-model="serviceCall.associatedServiceCode.lastServiceDate" data-ng-readonly="true"/>
    </div>
     <div class="clear"></div>
     <div class="labelStyle floatL">
        <spring:message code="label.periodicService.serviceFrequencyHours" />
    </div>
     <div class="floatL">
        <div class="wid250" data-ng-model="frequency" data-ng-bind="frequency"></div>
    </div>
    <div class="clear"></div>
    <div class="labelStyle floatL">
        <spring:message code="label.periodicService.descriptionOfService" />
    </div>
     <div class="floatL">
        <textarea max-length data-ng-model="serviceCall.associatedServiceCode.serviceCode.description" rows="4" cols="450" class="wid500" data-ng-readonly="true"></textarea>
    </div>
    <div class="clear"></div>
    <div class="centered marB10">
        <div class="floatL marRL10" colspan="5" data-ng-if="serviceCall.status!='COMPLETED'">
            <button type="button" class="blue-btn btn-primary" onclick="createServiceRequest()">
                 <spring:message code="label.periodicService.createServiceRequest" />
            </button>
        </div>
        <div class="hgt20"></div>
    </div>
</div>
<div class="clear"></div>

<authz:ifUserInRole roles="fleetAdmin,fleetServiceSpecialist,dealerOwnedAdmin">   
    <%@include file="revisions.jsp"%>
<div data-ng-show="serviceCall.status!='COMPLETED'">    
<div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
            <div class="labelStyle floatL">
                <spring:message code="label.periodicService.markAsComplete" />
            </div>
            <div class="floatL">
                <INPUT TYPE="text" data-ng-model="serviceCall.completedDate" 
                       datepicker-popup={{dateFormat}} class="wid80" min="minDate" max="todayDate" ng-required="serviceRequest.activeFleetInventoryAudit.shipTo.etaOnServiceRequest && task.takenTransition=='Dispatch'" 
                       ng-disabled="task.takenTransition=='Sent Back to NMHG' || serviceCall.status =='COMPLETED'">
            </div>
            <div class="clear"></div>
            <div class="labelStyle floatL">
       	        <spring:message code="label.periodicService.comments" />
            </div>
            <div class="floatL">
                <textarea  max-length name="serviceCall.comments" data-ng-model="serviceCall.comments" rows="4" cols="450" class="wid500" ng-disabled="serviceCall.status =='COMPLETED'" data-ng-required="true"></textarea>
            </div>
</div> 
</div>
</authz:ifUserInRole>                  
<div class="centered marB10" data-ng-show="serviceCall.status!='COMPLETED'">
				<div class="hgt20"></div>	
                <authz:ifUserInRole roles="fleetAdmin,fleetServiceSpecialist,dealerOwnedAdmin">
                    <button type="button" class="blue-btn btn-primary" data-ng-click="update()" ng-disabled='form.$invalid'>
                        <spring:message code="label.common.update" />
                    </button>
                </authz:ifUserInRole>
                    <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                        <spring:message code="label.Common.cancel" />
                    </button>
                <div class="hgt20"></div>
</div>
