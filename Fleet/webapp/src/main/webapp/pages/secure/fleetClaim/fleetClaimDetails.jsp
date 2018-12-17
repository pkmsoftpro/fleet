<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>

<div class="accordion-header contentPane">
	<!-- accordion header -->
	<spring:message code="title.common.general" />
	<span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
	<div ng-show="servicingDealer">
		<div class="labelStyle floatL">
			<spring:message code="label.common.dealer" />
		</div>
		<div class="floatL wid222">
			<div data-ng-model="fleetClaim.forDealer.name" data-ng-bind="fleetClaim.forDealer.name"></div>
		</div>
	</div>
	<div ng-show="isInternalUserOrOwningDealer||isInternalUser">
		<div data-ng-if="fleetClaim.id!=null">
			<div class="labelStyle floatL">
				<spring:message code="label.common.dealer" />
			</div>
			<div class="floatL">
				<div data-ng-model="fleetClaim.forDealer.name" data-ng-bind="fleetClaim.forDealer.name"></div>
			</div>
		</div>
		
		<div data-ng-if="fleetClaim.id==null">
			<div ng-hide="toggleDealerNumber">
				<div class="labelStyle floatL">
					<spring:message code="label.common.dealerNumber" />
					<span class="red">*</span>
					<br /> <a href="#" ng-click="toggleDealerNumber=!toggleDealerNumber;"><spring:message code="label.common.specifyDealerName" /> </a>
				</div>
				<div class="floatL">
					<INPUT TYPE="text" name="serviceProviderNumber" data-ng-model="fleetClaim.forDealer.serviceProviderNumber"  typeahead-min-length='3' typeahead-on-select="setDealer($item)"  typeahead="serviceProvider.serviceProviderNumber as serviceProvider.serviceProviderNumber for serviceProvider in findDealersWhoseNumberStartingWith($viewValue)" required />
				</div>
			</div>
			<div ng-show="toggleDealerNumber">
				<div class="labelStyle floatL">
					<spring:message code="label.common.dealerName" />
					<span class="red">*</span>
					<br /> <a href="#" ng-click="toggleDealerNumber=!toggleDealerNumber;"><spring:message code="label.common.specifyDealerNumber" /> </a>
				</div>
				<div class="floatL">
					<INPUT TYPE="text" name="serviceProviderName" data-ng-model="fleetClaim.forDealer.name"  typeahead-min-length='3' typeahead-on-select="setDealer($item)"  typeahead="serviceProvider.name as serviceProvider.name for serviceProvider in findDealersWhoseNameStartingWith($viewValue)" required />
				</div>
			</div>
		</div>
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.fleetClaim.claimType" />
	</div>
	<div class="floatL">
		<span>Fleet</span>
	</div>
	<div class="clear"></div>
	<div class="divider-line" style="margin-bottom: 13px;"></div>
	<div class="clear"></div>
	
	<div class="labelStyle floatL">
                    <table>
                        <tr>
                            <td>
                            	<spring:message code="label.quote.serialNumber" /> <span class="red">*</span>
                            </td>
                        </tr>
                        <tr>
                        	<td>
	                            <a id="homeEquipmentDetailsPage" class="text-link" href="#" ng-click="equipmentDetailsPage(fleetClaim.forItem.serialNumber)"
	                                ng-show="fleetClaim.forItem.id && !fleetClaim.id"> <spring:message code="label.serviceRequest.equipmentDetailPage" />
	                            </a>
                            </td>
                        </tr>                        
                    </table>
    </div>
    
	<div class="floatL">
		<div data-ng-if="fleetClaim.id!=null && editSerialNumber==false">
			<a ng-href="#" data-ng-click="navigateToequipmentHistoryPageDetailPage()"><div class="wid222">{{fleetClaim.forItem.serialNumber}}</div></a>
		</div>
		<div data-ng-if="fleetClaim.id==null || editSerialNumber==true">
			<INPUT TYPE="text" data-ng-model="fleetClaim.forItem.serialNumber" ng-minlength="3" name="serialNumber" typeahead-min-length='3' typeahead-on-select="setInventoryItem($item)"  typeahead="fleetInventoryItem.serialNumber as fleetInventoryItem.serialNumber for fleetInventoryItem in findInventoryItemsWhoseSerialNumberStartsWith($viewValue)" required />
		</div>
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.quote.serviceRequestNumber" /> <span class="red" data-ng-show="isFleetProcesor && task.takenTransition=='Accept' && !activeAudit.autoGenerateServiceRequest">*</span>
	</div>
	<div data-ng-show="(fleetClaim.id==null || fleetClaim.fleetClaimNumber=='Draft')  && !activeAudit.autoGenerateServiceRequest && editSRAutoBox==false">
		<div class="floatL" id='listServiceRequests'>
			<select data-ng-model="fleetClaim.forServiceRequest.id" ng-options="serviceRequest.key as serviceRequest.label for serviceRequest in serviceRequests" class="wid223 hgt26"  ng-change="populateServiceRequestDetailsForDraftClaims(fleetClaim.forServiceRequest.id)">
		 		<option value="">
                    <spring:message code="label.serviceRequest.select" />
                </option>
			</select>
		</div>
		
	</div>
	<div data-ng-show="(fleetClaim.id!=null || fleetClaim.fleetClaimNumber=='Draft')  && !activeAudit.autoGenerateServiceRequest && editSRAutoBox==true">
		<div class="floatL">
			<a ng-href="#" data-ng-click="serviceRequestDetail()" class="wid222"><div class="wid223">{{fleetClaim.forServiceRequest.serviceRequestNumber}} &nbsp <span><a ng-href="#" data-ng-click="unMapServiceRequest()"><spring:message code="label.common.edit" /></a></span></div></a>
		</div>
	</div>
	
	<div data-ng-if="fleetClaim.id!=null && fleetClaim.fleetClaimNumber!='Draft'  && !isFleetProcesor">
		<div class="floatL">
			<a ng-href="#" data-ng-click="serviceRequestDetail()" class="wid222"><div class="wid223">{{fleetClaim.forServiceRequest.serviceRequestNumber}}</div></a>
		</div>
	</div>

	<div data-ng-if="isFleetProcesor && fleetClaim.id!=null &&  fleetClaim.fleetClaimNumber!='Draft'">
		<div data-ng-if="showSRDropdown==false">
			<a data-ng-href="#" data-ng-click="serviceRequestDetail()" class="wid222">
				<span class="wid223">{{fleetClaim.forServiceRequest.serviceRequestNumber}}</span>
			</a>
		</div>
		
		<div data-ng-if="showSRDropdown==true && !activeAudit.autoGenerateServiceRequest">
			<select data-ng-model="fleetClaim.forServiceRequest.id" ng-options="serviceRequest.key as serviceRequest.label for serviceRequest in serviceRequests" ng-change="associatingSR(fleetClaim.forServiceRequest.id)" class="wid223 hgt26" data-ng-required="task.takenTransition=='Accept'">
		 		<option value="">
	                   <spring:message code="label.serviceRequest.select" />
	               </option>
			</select>
		</div>
	</div>
	
	<div class="clear"></div>
	<div data-ng-if="fleetClaim.forServiceRequest.id==null">
	<div class="labelStyle floatL" style="margin-left: 465px;">
	<spring:message code="label.fleetClaim.autoGenerateSR" />
	</div>
	<div class="floatL" >
	<input TYPE="checkbox" data-ng-model="activeAudit.autoGenerateServiceRequest" data-ng-disabled="isReadOnly()"/>
	</div>
	</div>
	<div data-ng-if="fleetClaim.forServiceRequest!=null && fleetClaim.forServiceRequest.id!=null  && activeAudit.autoGenerateServiceRequest">
	<div class="labelStyle floatL" style="margin-left: 465px;">
	<spring:message code="label.fleetClaim.autoGenerateSR" />
	</div>
	<div class="floatL" >
	<input TYPE="checkbox" checked="checked" data-ng-disabled="true"/>
	</div>
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.serviceRequestCreatedDate" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="fleetClaim.forServiceRequest.createdOn" data-ng-readonly="true" />
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.serviceRequestDispatchedDate" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="fleetClaim.forServiceRequest.serviceRequestDispatchedOn" data-ng-readonly="true" />
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.serviceRequestCompletedDate" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="fleetClaim.forServiceRequest.serviceRequestCompletedOn" data-ng-readonly="true" />
	</div>
	
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	
	<div class="labelStyle floatL">
		<spring:message code="label.common.quoteNo" />
	</div>
	<div class="floatL">
		<span data-ng-if="quoteNumber">
			<a href="#" data-ng-click="showQuoteDetail()"> <span class="wid222">{{quoteNumber}}</span></a>
		</span>
		<span data-ng-if="!quoteNumber">
			<input TYPE="text" data-ng-model="quoteNumber" data-ng-readonly="true" />
		</span>
	</div>
	
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.fleetCustomer" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="customerName" data-ng-readonly="true"  />
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.customerNumber" />
	</div>
    <div class="floatL">
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="fleetClaim.customerNumber">
        </div>
    </div>
    <div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.customerLocationName" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="locationsMapkey" data-ng-readonly="true" />
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.customerPONumber" />
			<span class="red" ng-show="fleetClaim.forServiceRequest.customerLocation.purchaseOrderRequired">*</span>
	</div>
	 <div class="floatL">
            <INPUT TYPE="text" id="customerPoNumber"  maxlength="{{fleetClaim.forItem.activeFleetInventoryAudit.shipTo.purchaseOrderLength}}" data-ng-readonly="isReadOnly()"
            	 data-ng-model="activeAudit.customerPoNumber" id="customerPoNumber" 
            	 ng-blur="validatePONumber(activeAudit.customerPoNumber,customerLocationId,poRegularExpression,duplicatePoNumberAllowed)" 
            	 ng-required="fleetClaim.forItem.activeFleetInventoryAudit.shipTo.purchaseOrderRequired">
        </div>
                <div class="fieldSpacerWidth floatL ">
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
	<!-- <div class="floatL">
		<input TYPE="text" data-ng-model="fleetClaim.forServiceRequest.activeServiceRequestAudit.callType.description" data-ng-readonly="true" />
	</div> -->

	<div data-ng-show="servicingDealer">
	<div class="labelStyle floatL">
		<spring:message code="label.common.callType" />
		<span class="red">*</span>
	</div>
		<div data-ng-show="fleetClaim.id!=null && fleetClaim.fleetClaimNumber!='Draft'">
			<div class="floatL">
				<input TYPE="text" data-ng-model="activeAudit.callType.description" data-ng-readonly="true" name="callType"/>
			</div>
		</div>
		<div data-ng-show="fleetClaim.id==null || fleetClaim.fleetClaimNumber=='Draft'">
		<div class="floatL">
			<select data-ng-model="activeAudit.callType.id" data-ng-required="true" name="callType" data-ng-disabled="isReadOnly() || isCalltypeDisabled"
				ng-options="callType.listOfValues.id as callType.listOfValues.name for callType in callTypes" class="dropdown-normal" data-ng-init="activeAudit.callType.id=''" required>
				<option value="">
					<spring:message code="label.serviceRequest.select" />
				</option>
			</select></div>
		</div>
	</div>

	<div data-ng-show="isInternalUserOrOwningDealer">
		<div class="labelStyle floatL">
			<spring:message code="label.common.callType" />
			<span class="red">*</span>
		</div>
		<div class="floatL">
	          <select data-ng-model="activeAudit.callType.id" name="callType" data-ng-disabled="isReadOnly() || isCalltypeDisabled"
	              ng-options="callType.listOfValues.id as callType.listOfValues.name for callType in callTypes" class="dropdown-normal" data-ng-init="activeAudit.callType.id=''" required>
	               <option value=""> <spring:message code="label.serviceRequest.select" /></option>
	           </select>
				<div class="clear"></div>            
	            <div class="alert-error" data-ng-show="form.callType.$error.notinternal" >
	            	<spring:message code="error.common.callType.internal" />
	            </div>
	     </div>
	</div>
	<div data-ng-show="isCustomerUser">
		 <div class="labelStyle floatL">
            <spring:message code="label.quote.callType" />
        </div>
        <div class="floatL">
			<input type="text" data-ng-readonly="true" data-ng-model="associatedCallType.description" />
        </div>
	</div>
	
	
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.technicianName" />
	</div>
    <div ng-if="fleetClaim.forServiceRequest.id!=null">
	<div class="floatL">
		<input TYPE="text" data-ng-disabled="isReadOnly()" data-ng-model="activeAudit.technicianDetails.technician.completeName" data-ng-readonly="true" />
	</div>
    </div>
    <div ng-if="fleetClaim.forServiceRequest.id==null">
        <div class="floatL">
            <select data-ng-model='activeAudit.technicianDetails.technician.id' data-ng-disabled="isReadOnly()"
                ng-options="technician.key as technician.label for technician in technicians" class="dropdown-normal hgt26 wid223">
                <option value="">
                    <spring:message code="label.serviceRequest.select" />
                </option>
            </select>
        </div>
    </div>
	<div class="clear"></div>
	<div class="divider-line" style="margin-bottom: 13px;"></div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.dealerWorkOrderNumber" /> <span class="red">*</span>
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="activeAudit.workOrderNumber" data-ng-required="true" data-ng-disabled="isReadOnly()" ng-maxlength="17"/>
</div>
<div class="fieldSpacerWidth floatL">&nbsp;</div>
<div class="labelStyle floatL">
<spring:message code="label.common.fleetClaimNumber" />
</div>
<div class="floatL">
<input TYPE="text" data-ng-model="fleetClaim.fleetClaimNumber" data-ng-init="fleetClaim.fleetClaimNumber='Draft'" data-ng-readonly="true" />
</div>


    <div class="clear"></div>
    	<div class="labelStyle floatL">
    <spring:message code="label.common.dealerInvoiceNumber" />
    </div>
    <div class="floatL">
    <input TYPE="text" data-ng-model="fleetClaim.dealerInvoiceNumber" data-ng-readonly="isReadOnly()" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
    <spring:message code="label.common.dealerClaimNumber" />
    </div>
    <div class="floatL">
    <input TYPE="text" data-ng-model="fleetClaim.dealerClaimNumber" data-ng-readonly="isReadOnly()" ng-maxlength = "12"/>
    </div>

<div class="clear"></div>
<div class="labelStyle floatL">
<spring:message code="label.common.cmTicketNumber" />
</div>
<div class="floatL">
<input TYPE="text" data-ng-model="activeAudit.cmTicketNumber" data-ng-readonly="isReadOnly()"/>
</div>
<div class="fieldSpacerWidth floatL">&nbsp;</div>
<div class="labelStyle floatL">
<spring:message code="label.common.meterReading" />
<span class="red">*</span>
</div>
<div class="floatL">
<input TYPE="text" data-ng-model="activeAudit.meterReading" numbers-only="numbers-only" data-ng-readonly="isReadOnly()" required />
</div>
<div class="clear"></div>
<div class="labelStyle floatL">
<spring:message code="label.common.repairStartDate" />
<span class="red">*</span>
</div>
<div class="floatL">
	<input TYPE="text" data-ng-model="fleetClaim.repairStartDate" datepicker-popup="{{dateFormat}}" max="today" required data-ng-readonly="isReadOnly()" name="repairStartDate"/>
</div>
<div class="fieldSpacerWidth floatL">&nbsp;</div>
<div class="labelStyle floatL">
<spring:message code="label.common.repairEndDate" />
<span class="red">*</span>
</div>
<div class="floatL">
	<input TYPE="text" data-ng-model="fleetClaim.repairEndDate" datepicker-popup="{{dateFormat}}" min="fleetClaim.repairStartDate" max="today" required data-ng-readonly="isReadOnly()" name="repairEndDate"/>
</div>
<div class="clear"></div>
<div class="labelStyle floatL">
<spring:message code="label.common.maintenanceType" />
</div>
<div class="floatL">
<input TYPE="text" data-ng-model="maintenanceType" data-ng-readonly="true"/>
</div>
<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<%-- <authz:ifUserInRole roles="fleetServiceSpecialist,fleetProcessor"> --%>
    <div ng-show="isInternalUserOrOwningDealer||isFleetProcesor">
 <div data-ng-show="activeAudit.assignToUser">
<div class="labelStyle floatL">
<spring:message code="label.common.assignTo" />
</div>
<div class="floatL">
<span>{{activeAudit.assignToUser.completeNameAndLogin}}</span>
</div>
</div>
</div>
<%-- </authz:ifUserInRole> --%>
<div class="clear"></div>
<div data-ng-show="fleetClaim.parentClaimNumber">
<div class="labelStyle floatL">
<spring:message code="label.common.parentClaimNumber" />
</div>
<div class="floatL">
<input TYPE="text" data-ng-model="fleetClaim.parentClaimNumber" data-ng-readonly="isReadOnly()"/>
</div>
</div>
<div>
<div class="labelStyle floatL" style="margin-left: 465px;">
<spring:message code="label.common.informationOnly" />
</div>
<div class="floatL" >
<div data-ng-if="fleetClaim.id==null || activeAudit.fleetClaimState=='DRAFT'" >
<input TYPE="checkbox" data-ng-model="activeAudit.informationOnly" data-ng-disabled="false"/>
</div>
<div data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" >
<input TYPE="checkbox" data-ng-model="activeAudit.informationOnly" data-ng-disabled="true"/>
</div>
</div>
</div>
<div class="clear"></div>

<div ng-show="isInternalUserOrOwningDealer||isFleetProcesor">
			<div data-ng-show="isContractManagement" data-ng-init="isContractManagement=false" >
				<div class="labelStyle floatL">
					<spring:message code="label.quote.applicableContract" />
				</div>

				<div>
					<div class="floatL">
						<a href="#" data-ng-click="navigateToCreateContractPage()">{{fleetClaim.contractCode}}</a>
					</div>
				</div>
				
			</div>
			<div class="clear"></div>
</div>

<div class="clear"></div>
</div>