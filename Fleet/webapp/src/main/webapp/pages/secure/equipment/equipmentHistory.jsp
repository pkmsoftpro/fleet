<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<html id="ng-app" data-ng-app="equipmentApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<u:stylePicker fileName="equipment/equipment.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<script src="../scripts/equipment/equipmentApp.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
</head>
<u:body theme="fleet">
<%@include file="i18N_equipment_javascript_vars.jsp"%>
<div data-ng-init="inventoryId='${inventoryId}'"></div>
<div data-ng-init="userType='${userType}'"></div>
<div data-ng-init="internalView=${internalView}"></div>
<div data-ng-init="dealerView=${dealerView}"></div>
<div data-ng-init="customerView=${customerView}"></div>
<div ng-init="dateFormat='${dateFormat}'"></div>
<form data-ng-controller="EquipmentController" name="form" novalidate class="equipHistory" id="equipmentInventoryForm">
<div ng-show="updated==false">
<div class="status ng-binding"><spring:message code="title.equipmentdetails.equipmentHistory"/>
		 
	<div  ng-show = "isInternalUser || isDealerOwned" class="floatR" > 
		<img src="../image/pgmSummary.png" class="marR10" data-ng-click="printPGS()" tooltip="<spring:message code='label.common.pgs'/>" tooltip-placement="left"/>
	</div> 
     
</div>
     <div alert-msg></div>
    <spring:eval expression="@fleetProperties.getProperty('appSSOEnabled')" var="appSSOEnabled" />
    <c:if test="${appSSOEnabled}">
		<authz:ifPermitted resource="warrantyInformation">
			<a ng-href='#here' ng-click='showWarrantyInfo()'>Click here to view warranty info</a>
		</authz:ifPermitted>
    </c:if>
       <authz:ifPermitted resource="deactivateEquipment">
		<button type="button" class="blue-btn btn-primary"  ng-show="fleetInventoryItem.displayStatus=='ACTIVE'" data-ng-click="makeEquipmentInactive()" align="left" ng-disabled="!(fleetInventoryItem.inactiveRequestSent)">
                <%-- <spring:message code="label.equipment.makeInactive" /> --%>
                <div ng-if="fleetInventoryItem.inactiveRequestSent"><spring:message code="label.equipment.makeInactive"/></div>
				<div ng-if="!fleetInventoryItem.inactiveRequestSent"><spring:message code="label.equipment.requestedToMakeInactive"/></div>	
      	</button>
       </authz:ifPermitted>

<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="accordion-header contentPane">	<!-- accordion header -->
		<spring:message code="title.equipmentdetails.EquipmentInformation"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
	<div class="details-sub-header"><span><spring:message code="title.equipmentdetails.BaseInformation"/></span></div>
           <div>	
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.serialNumber" />
				</div>

				<div class="floatL marR20">
					<input message id='serialNumber'data-ng-readonly="true" name="serialNumber" data-ng-model="fleetInventoryItem.serialNumber"/>
				</div>
                <div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.equipmentdetails.SubjectiveTruckCondition" />
                    </div>
                    <div class="floatL marR20">
                       <select style="width:126px!important;" ng-model="fleetInventoryItem.equipmentCondition" ng-options="ec for ec in listOfEquipmentCondition" 
                    data-ng-disabled="isCustomerUser==true">
                     <option value="">
                    <spring:message code="label.serviceRequest.select" />
                   </option>
                     </select>      
                    </div>
               </div>
				
			</div>	
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
			<div ng-show = "isInternalUser || isDealerOwned">
			
				<div>
					<div class="labelStyle floatL">
						<spring:message code="label.equipmentdetails.UnitSalesOrderNumber" />
					</div>
					<div class="floatL marR20">
						<input message  data-ng-model="fleetInventoryItem.unitSalesOrderNumber"
						data-ng-readonly="true" />
					</div>
				</div>
                <div>
                    <div class="labelStyle floatL">
                                <spring:message code="label.equipmentdetails.UnitPONumber" />
                    </div>
                    
                    <div class="floatL">
                        <input message name="unitPoNumber"  id="unitPoNumber"data-ng-model="fleetInventoryItem.unitPoNumber" data-ng-readonly="true"/>
                    </div>
                </div>
			</div>	
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
			 			
 			<div>
 			
              <div ng-show = "isInternalUser || isDealerOwned">
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.SAPEquipmentNumber" />
				</div>
				<div class="floatL  marR20">
					<input message data-ng-readonly="true" name="externalId" id="externalId" data-ng-model="fleetInventoryItem.externalId"
					data-ng-readonly="true" />
				</div>
			</div>

				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.StandardWarrantyExpiration" />
				</div>
				<div class="floatL marR20">
 				<input message id='stdWarrantyExpiration' data-ng-readonly="true"
						id="stdWarrantyExpiration"
						data-ng-model="fleetInventoryItem.stdWarrantyExpiration" />
				</div>
			</div>
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
            
            <div ng-show = "isInternalUser || isDealerOwned">
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.ModifiedUserID" />
				</div>
				<div class="floatL marR20">
					<input message  readonly data-ng-model="fleetInventoryItem.lastUpdatedByName" />
				</div>
                <div class="labelStyle floatL">
                    <spring:message code="label.equipmentdetails.ModifiedTime" />
                 </div>
                 <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.updatedOn" readonly/>
                 </div>
			</div>	
			
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
            <div>
                 <div class="labelStyle floatL">
                    <spring:message code="label.equipmentdetails.CustomerAssetNumber" />
                </div>
                <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.assetNumber" data-ng-readonly="true" />
                </div>
				 <div class="labelStyle floatL">
					<spring:message code="label.serviceRequest.maintenanceType" />
				 </div>
				 <div class="floatL marR20">
				    <input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.maintenanceType" />
				 </div>
           </div>
            
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		
        <div>
			 <div class="labelStyle floatL">
					<spring:message code="title.equipmentdetails.status" />:
			 </div>
			 <div class="floatL marR20">
				    <input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.displayStatus" />
			 </div> 
 		</div>
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
				
  	<div class="details-sub-header"><span><spring:message code="title.common.customerInfo"/></span></div>
	 <div>
			<div class="labelStyle floatL">
				<spring:message code="label.equipment.customerName" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerName" />
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.equipment.customerLocation" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.name" />
			</div>
	 </div>	
  	 <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
     <div> 
            <div class="labelStyle floatL">
				<spring:message code="label.equipmentdetails.shipTo" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.code" />
			</div> 
			<div class="labelStyle floatL">
				<spring:message code="label.equipment.customerAddress" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerAddress.addressLine1" />
				
			</div>
	</div>	
  	<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div> 
		    <div class="labelStyle floatL">
				<spring:message code="label.customer.city" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerAddress.city" />
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.customer.state" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerAddress.state" />
			</div>
	</div>
	
	<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div> 
		    <div class="labelStyle floatL">
				<spring:message code="label.customer.zip" />
			</div>
			<div class="floatL marR20">
				<input  data-ng-readonly="true" data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerAddress.zipCode" />
			</div>
			<div class="labelStyle floatL"></div>
			<div class="floatL marR20"></div>
	</div>
	
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="details-sub-header"><span><spring:message code="title.equipmentdetails.Dates"/></span></div>

	        <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div>
			<div class="labelStyle floatL" ng-if="isDealerOwned || fleetInventoryItem.leaseStartDate != null">
				<spring:message code="label.serviceRequest.leaseStartDate" />
			</div>
			<div class="floatL marR20" ng-if="fleetInventoryItem.leaseStartDate != null || isDealerOwned">
				<input message data-ng-model="fleetInventoryItem.leaseStartDate" datepicker-popup={{dateFormat}}  data-ng-disabled="!isDealerOwned" />
			</div>
			
			<div class="labelStyle floatL" ng-if="(fleetInventoryItem.leaseEndDate != null && (isInternalUser || isCustomerUser)) || isDealerOwned">
				<spring:message code="label.equipmentdetails.LeaseExpirationDate" />
			</div>
			<div class="floatL marR20" ng-if="(fleetInventoryItem.leaseEndDate != null && (isInternalUser || isCustomerUser)) || isDealerOwned">
				<input message data-ng-model="fleetInventoryItem.leaseEndDate" ng-change="getMonthOnLeaseRemaining(fleetInventoryItem.leaseEndDate)" datepicker-popup={{dateFormat}} data-ng-disabled="!isDealerOwned" />
			</div>
		</div>
	        <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div>
			<div class="labelStyle floatL">
				<spring:message code="label.equipmentdetails.InstallDate" />
			</div>
			<div class="floatL marR20">
				<input message data-ng-disabled="!isDealerOwned" datepicker-popup={{dateFormat}} data-ng-model="fleetInventoryItem.installDate" />
			</div>

			<div class="labelStyle floatL" ng-if="((fleetInventoryItem.leaseEndDate != null || isDealerOwned) && monthOnLeaseRemaining > 0)">
				<spring:message code="label.equipmentdetails.MonthonLeaseRemaining" />
			</div>
			<div class="floatL marR20" ng-if="((fleetInventoryItem.leaseEndDate != null || isDealerOwned) && monthOnLeaseRemaining > 0)">
				<input message data-ng-readonly="true" data-ng-model="monthOnLeaseRemaining" />
			</div>
		</div>
	        <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="details-sub-header"><span><spring:message code="title.equipmentdetails.Dealership"/></span></div>        
	   <div> 
                <div class="labelStyle floatL" style="color:#143B88!important">
                    <spring:message code="label.serviceRequest.preferredDealer" />
                </div>
                <div class="floatL small-input-wrapper">
                    <span style="display: block;width: 100%;height: 1px;"></span>
                </div>
                
                <div ng-hide = "isDealerOwned">
	                <div class="labelStyle floatL" style="color:#143B88!important">
	                    <spring:message code="label.serviceRequest.alternateDealer" />
	                </div>
                </div>
                
                <div class="floatL small-input-wrapper">
                    <span style="display: block;width: 100%;height: 1px;"></span>
                </div>
              </div>
	        <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
            <div class="fieldSpacerHeight clear hgt10"></div>
             <div> 
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerName" />
                </div>
                <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.preferredDealer.name" readonly />
                </div>
                <div ng-hide = "isDealerOwned">
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.alternateDealerName" />
                </div>
                
                
	                <div class="floatL marR20">
	                    <input message data-ng-model="fleetInventoryItem.alternateDealer.name" readonly />
	                </div>
                </div>
                
              </div>
            <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
             <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerId" />
                </div>
                <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.preferredDealer.serviceProviderNumber" readonly />
                </div>
                
               <div ng-hide = "isDealerOwned">
	                <div class="labelStyle floatL">
	                	<spring:message code="label.serviceRequest.alternateDealerId" />
	                </div>
	                <div class="floatL marR20">
	                    <input message data-ng-model="fleetInventoryItem.alternateDealer.serviceProviderNumber" readonly />
	                </div>
                </div>
                
               </div> 
            <div>
	        <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerPhoneNumber" />
                </div>
                <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.preferredDealer.address.phone" readonly />
                </div>
                
           		<div ng-hide = "isDealerOwned">
	                <div class="labelStyle floatL">
	                    <spring:message code="label.serviceRequest.alternateDealerPhoneNumber" />
	                </div>
	                <div class="floatL marR20">
	                    <input message ng-model="fleetInventoryItem.alternateDealer.address.phone" readonly />
	                </div>
                </div>
                
                <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerCity" />
                </div>
                <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.preferredDealer.address.city" readonly />
                </div>
                
           		<div ng-hide = "isDealerOwned">
	                <div class="labelStyle floatL">
	                    <spring:message code="label.serviceRequest.alternateDealerCity" />
	                </div>
	                <div class="floatL marR20">
	                    <input message ng-model="fleetInventoryItem.alternateDealer.address.city" readonly />
	                </div>
                </div>
                
                <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerState" />
                </div>
                <div class="floatL marR20">
                    <input message data-ng-model="fleetInventoryItem.preferredDealer.address.state" readonly />
                </div>
                
           		<div ng-hide = "isDealerOwned">
	                <div class="labelStyle floatL">
	                    <spring:message code="label.serviceRequest.alternateDealerState" />
	                </div>
	                <div class="floatL marR20">
	                    <input message ng-model="fleetInventoryItem.alternateDealer.address.state" readonly />
	                </div>
                </div>
                
            </div>
            <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="details-sub-header"><span><spring:message code="title.equipmentdetails.attributes"/></span></div> 
	    <div class="overflow-hidden clearAll">
            <div class="labelStyle floatL">
                <spring:message code="label.equipmentdetails.Manufacturer" />
            </div>
            <div class="floatL marR20">
                <input message name="unitPoNumber" data-ng-model="fleetInventoryItem.brandType" data-ng-readonly="true"   />
            </div>
			<div class="labelStyle floatL">
				<spring:message code="label.equipmentdetails.productFamily" />
			</div>
            <div class="floatL marR20">
                <input message readonly data-ng-model="productFamily"/>            
            </div>
		</div> 		
		<div class="overflow-hidden clearAll">
			<div class="labelStyle floatL">
				<spring:message code="label.equipmentdetails.Model" />
			</div>
			<div class="floatL marR20">
				<input message readonly data-ng-model="fleetInventoryItem.modelName"/>
			
			</div>
            <div class="labelStyle floatL" >
                 <spring:message code="label.equipment.unitAge" />
            </div>
            <div class="floatL marR20">
                 <input message data-ng-readonly="true" data-ng-model="unitAge" data-ng-readonly="true"   />
            </div> 
		</div>
		   
   <div class="overflow-hidden" style="width:906px">
    <div data-ng-repeat="equipmentAttributes in fleetInventoryItem.equipmentAttributes" class="overflow-hidden" style="width:50%;float:left;">
      
        		<div class="labelStyle floatL">
					{{equipmentAttributes.attributes.attributeName}} <span>:</span>
					<span ng-show="equipmentAttributes.attributes.mandatory" style="color:red;">*</span>
				</div>
				
    			<div class="wrap-repeater">
        		<span ng-if="equipmentAttributes.attributes.attributeType=='Text'">
           			<div class="floatL marR20">
                		<input class="labelStyle floatL" data-ng-readonly="!isInternalUserOrOwningDealer"  type="text" data-ng-model="equipmentAttributes.attrValue" ng-required="equipmentAttributes.attributes.mandatory && isInternalUserOrOwningDealer">
            		</div>
            	</span >
        		<span ng-if="equipmentAttributes.attributes.attributeType=='Text Area'">
           		<div>
                	<textarea  cols="5"  data-ng-readonly="!isInternalUserOrOwningDealer"   data-ng-model="equipmentAttributes.attrValue" ng-required="equipmentAttributes.attributes.mandatory && isInternalUserOrOwningDealer"></textarea>
                 </div>
                 
       			</span>
        		<span ng-if="equipmentAttributes.attributes.attributeType=='Number'">
                <span ng-if="equipmentAttributes.attributes.attributeName=='Model Year'">
                <div>
                    <input class="labelStyle floatL" type="text" data-ng-readonly="!isInternalUserOrOwningDealer"  data-ng-model="equipmentAttributes.attrValue" ng-change="getUnitAge(equipmentAttributes.attrValue)"   numbers-only="numbers-only"  ng-required="equipmentAttributes.attributes.mandatory && isInternalUserOrOwningDealer" />
                </div>
                </span>
                <span ng-if="equipmentAttributes.attributes.attributeName!='Model Year'">
           		 <div class="floatL marR20">
					<input class="labelStyle floatL" type="text" data-ng-readonly="!isInternalUserOrOwningDealer"   data-ng-model="equipmentAttributes.attrValue"  is-number ng-required="equipmentAttributes.attributes.mandatory && isInternalUserOrOwningDealer" />
            	 </div>
                 </span>
        		</span>
        		<span ng-if="equipmentAttributes.attributes.attributeType=='Date'">
           			<div class="floatL marR20">
						<input  type="text"  datepicker-popup={{dateFormat}} class="wid80" min="minDate" data-ng-readonly="!isInternalUserOrOwningDealer"  data-ng-model="equipmentAttributes.attrValue"   ng-required="equipmentAttributes.attributes.mandatory && isInternalUserOrOwningDealer" />
            		</div>
        		</span>
        		<span ng-if="equipmentAttributes.attributes.attributeType=='Single Select'">
                	<div class="floatL marR20">
                    	<select data-ng-model="equipmentAttributes.attrValue"  data-ng-disabled="!isInternalUserOrOwningDealer" class="dropdown-normal" ng-options="obj for obj in getSingleSelectOptions($index)" ng-required="equipmentAttributes.attributes.mandatory && isInternalUserOrOwningDealer"> 
                    		 <option value="">
                    <spring:message code="label.serviceRequest.select" />
                   </option>
                    	</select>
                	</div>
         		</span>         		       
       		</div>
     
    </div>
   </div> 
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
		<div class="details-sub-header"><span><spring:message code="title.equipmentdetails.Usage"/></span></div>
		
		<div ng-hide = "isServicingDealer">	
				<div class="labelStyle floatL">
							<spring:message code="label.equipmentdetails.1ShiftUtilization" />
				</div>
				<div class="floatL small-input-wrapper">
					<input message data-ng-readonly="true"  name="1ShiftUtilization" data-ng-model="fleetInventoryItem.inventoryUsage.singleShiftUtilization"  />
				<span><spring:message code="label.equipmentdetails.percentage" /></span>
				</div>
				
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.2ShiftUtilization" />
				</div>
				<div class="floatL small-input-wrapper">
					<input message name="unitPoNumber" data-ng-model="fleetInventoryItem.inventoryUsage.twoShiftUtilization" data-ng-readonly="true"   />
				<span><spring:message code="label.equipmentdetails.percentage" /></span>
				</div>
		</div>
		
		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
			
		<div ng-hide = "isServicingDealer">				
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.3ShiftUtilization" />
				</div>
				<div class="floatL small-input-wrapper">
					<input message data-ng-readonly="true"  data-ng-model="fleetInventoryItem.inventoryUsage.threeShiftUtilization" />
				<span>%</span>   
				</div>
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.EstimatedAnnualhours" />
					 
				</div>
				<div class="floatL marR20">
					<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.inventoryUsage.estimatedAnnualHours"
					data-ng-readonly="true" />
					<span><spring:message code="label.equipmentdetails.hours" /></span>
				</div>
   		</div>
   		
 		<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
 		
        <div>					
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.EstimatedUsageHours" />
				</div>
				<div class="floatL small-input-wrapper">
					<input message data-ng-readonly="true" data-ng-model="fleetInventoryItem.inventoryUsage.estimatedUsageHoursPerDay" />
				</div>
				<div class="labelStyle floatL">
					<span><spring:message code="label.equipmentdetails.MostRecentMeterReading" /></span>
					<span class="currencySymbol visibility-hidden"><spring:message code="label.equipmentdetails.currencySymbol"/></span>
				</div>
				<div class="floatL marR20">
					<input message data-ng-readonly="true" 
						data-ng-model="fleetInventoryItem.machineHours.mtrReading"  numbers-only="numbers-only"/>
				</div>
			</div>		
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
           <div>
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.CumulativeHours" />
				</div>
				<div class="floatL small-input-wrapper">
					<input message id='serialNumber' data-ng-readonly="true" 
						name="serialNumber"
						data-ng-model="fleetInventoryItem.inventoryUsage.cumulativeHours" />
						<span><spring:message code="label.equipmentdetails.hours" /></span>
				</div>
				<div class="labelStyle floatL">
					<spring:message code="label.equipmentdetails.MostRecentMeterReadingDate" />
				</div>
				
				<div  class="floatL marR20">
					<INPUT TYPE="text" data-ng-readonly="true" data-ng-model="recentMtrReadingDate" class="wid80" min="minDate"/>
				</div>
			</div>		
			<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
            <div ng-hide="isServicingDealer">
                <div class="details-sub-header">
                    <span><spring:message code="title.equipmentdetails.Financial" />
                    </span>
                </div>
                <%@include file="financial.jsp"%>
            </div>
            <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	      <div ng-hide="isServicingDealer">
		       <div class="details-sub-header"><span><spring:message code="title.equipmentdetails.AdministrativeCharges"/></span></div>  
	      </div>
	<div ng-hide="isServicingDealer">
	<%@include file="fixedBilling.jsp"%>  
	  </div>
	<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>

</div>
<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>

<div ng-show = "isInternalUser || isDealerOwned">
  <div class="accordion-header contentPane">
                    <!-- accordion header -->
  <spring:message code="title.common.contractsCovered" />
  <span class="expand-collapse collapse-icon"></span>
  </div>
  <div class="overflow-hidden accordion-info">
  <%@include file="equipmentContractCovered.jsp"%></div>
  </div>

<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>


	<div class="accordion-header contentPane">	<!-- accordion header -->
		<spring:message code="title.equipmentdetails.telemetryData"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
	
	<div class="telemetryDiv">
	<div> <a href="https://www.yalevision.com/Login.aspx?ReturnUrl=%2f" target="_blank"><spring:message code="label.equipmentDetails.yaleVisionLink"/></a></div>
	   <div class="containerDiv marL18 alarm-block">
          <%-- <div class="overflow-hidden accordion-info" style="float: left"> --%>
            <div data-ng-grid="gridForMachineHours"></div>  
        </div>
	   <div class="containerDiv marL18 alarm-block">
          <%-- <div class="overflow-hidden accordion-info" style="float: left"> --%>
            <div data-ng-grid="gridForFailureCodes"></div>  
        </div>
    </div>
    	<div ng-show="totalPages > 1">
        <pagination num-pages="totalPages" current-page="filterCriteria.pageNumber" max-size="5" class="" boundary-links="true"
            on-select-page="selectPage(page)"></pagination>
    	</div>
	</div>
<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>

<div ng-show = "isInternalUser || isDealerOwned" class="accordion-header contentPane">	
	<spring:message code="title.equipmentdetails.transactionHistory"/>
	<span class="expand-collapse collapse-icon"></span>
</div>
<div ng-show = "isInternalUser || isDealerOwned" class="overflow-hidden accordion-info">	
    <div class="ngEuipmentGridView hgt-auto" data-ng-grid="gridForTransactionHistory"></div>	
</div>
    
<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
    <div class="accordion-header contentPane">  
        <spring:message code="title.equipmentdetails.claimHistory"/>
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">    
        <div class="ngEuipmentGridView hgt-auto" data-ng-grid="gridForClaimHistory"></div>
    </div>    

<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
     <div ng-show = "isInternalUser || isDealerOwned">
		 <div class="accordion-header contentPane">	
			 <spring:message code="title.equipmentdetails.associatedPeriodicServices"/>
			 <span class="expand-collapse collapse-icon"></span>
		 </div>
		 <div class="overflow-hidden accordion-info">	
	     	<div class="ngEuipmentGridView" data-ng-grid="gridOptions"></div>   
		 </div>
	 </div>	
<%-- <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="accordion-header contentPane">	
		<spring:message code="title.equipmentdetails.contractHistory"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
<div class="overflow-hidden accordion-info">	
      <div class="containerDiv marL18" style="width: 1006px">
        <table border="1" cellspacing="0" cellpadding="0" style="width:100%">
            <tr class="tableHeader">
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contractHistory.startDate" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contractHistory.endDate" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contractHistory.ContractCode" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contractHistory.Description" /></th>
            </tr>
        </table>
      </div>
      <div ng-show="totalPages > 1">
        <pagination num-pages="totalPages" current-page="filterCriteria.pageNumber" max-size="5" class="" boundary-links="true"
            on-select-page="selectPage(page)"></pagination>
      </div>
  </div> --%>
<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="accordion-header contentPane">	
		<spring:message code="title.equipmentdetails.serviceSchedules"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
	    <div class="ngEuipmentGridView hgt-auto" data-ng-grid="gridForUpcomingSchedules"></div>     	
	</div>
<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
	<div class="accordion-header contentPane">	
		<spring:message code="title.equipmentdetails.serviceHistory"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">	
     <div class="ngEuipmentGridView hgt-auto" data-ng-grid="gridForServiceRequestHistory"></div>
	</div>

<%-- <div class="fieldSpacerHeight" style="clear: both; height:1px;"></div> -- commented for time being later need to implement the Audits
	<div class="accordion-header contentPane">	
		<spring:message code="title.equipmentdetails.equipmentAudits"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">	
     <div class="ngGridView" data-ng-grid="gridForEquipmentAudits"></div>
	</div>
 --%>
<div class="fieldSpacerHeight" style="clear: both; height:1px;"></div>
  <div class="overflow-hidden marT10">
	<div class="centered marB10">
	      <authz:ifPermitted resource="updateEquipment">
			<button type="button" class="blue-btn" data-ng-click="updateData()" ng-disabled='form.$invalid'>
				<spring:message code="label.equipmentDetails.updateButton" />
			</button>
		 </authz:ifPermitted>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
	</div>
 </div>
</div>
<div ng-show="updated==true">
            <jsp:include page="../common/success.jsp"></jsp:include>
</div>
</form>
</u:body>
</html>