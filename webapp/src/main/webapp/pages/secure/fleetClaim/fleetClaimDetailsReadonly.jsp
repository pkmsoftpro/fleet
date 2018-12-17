<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<div class="accordion-header contentPane">
	<!-- accordion header -->
	<spring:message code="title.common.general" />
	<span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
	<div>
		<div class="labelStyle floatL">
			<spring:message code="label.common.dealer" />
		</div>
		<div class="floatL wid222">
			{{fleetClaim.forDealer.name}}
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
	<div class="labelStyle floatL">
		<spring:message code="label.quote.serialNumber" />
		<span class="red">*</span>
	</div>
	<div class="floatL">
		<div>
			<a ng-href="#" data-ng-click="equipmentHistoryPageDetail()"><div class="wid222">{{fleetClaim.forItem.serialNumber}}</div></a>
		</div>
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.quote.serviceRequestNumber" />
	</div>
	<div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="serviceRequestDetail()" class="wid222"><div class="wid223">{{fleetClaim.forServiceRequest.serviceRequestNumber}}</div></a>
			</div>
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.serviceRequestCreatedDate" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="fleetClaim.forServiceRequest.createdOn"  data-ng-readonly="true" />
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
		<spring:message code="label.common.customerName" />
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
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="activeAudit.customerPoNumber" data-ng-readonly="true"  />
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.callType" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="activeAudit.callType.description" data-ng-readonly="true" />
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.technicianName" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-model="activeAudit.technicianDetails.technician.completeName" data-ng-readonly="true"/>
	</div>
	<div class="clear"></div>
	<div class="divider-line" style="margin-bottom: 13px;"></div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.dealerWorkOrderNumber" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-readonly="true" data-ng-model="activeAudit.workOrderNumber" />
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
     <spring:message code="label.common.fleetClaimNumber" />
    </div>
   <div class="floatL">
      <input TYPE="text" data-ng-model="fleetClaim.fleetClaimNumber" data-ng-readonly="true" />
   </div>
   <div class="clear"></div>
	<div class="labelStyle floatL">
	<spring:message code="label.common.dealerInvoiceNumber" />
	</div>
	<div class="floatL">
	<input TYPE="text" data-ng-model="fleetClaim.dealerInvoiceNumber" data-ng-readonly="true"/>
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
	<spring:message code="label.common.dealerClaimNumber" />
	</div>
	<div class="floatL">
	<input TYPE="text" data-ng-model="fleetClaim.dealerClaimNumber" data-ng-readonly="true"/>
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.cmTicketNumber" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-readonly="true" data-ng-model="activeAudit.cmTicketNumber" />
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.meterReading" />
	</div>
	<div class="floatL">
		<input TYPE="text" data-ng-readonly="true" data-ng-model="activeAudit.meterReading" />
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.repairStartDate" />
	</div>
	<div class="floatL">
		<input TYPE="text" ng-disabled="true" data-ng-readonly="true" data-ng-model="fleetClaim.repairStartDate" datepicker-popup="{{dateFormat}}"/>
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
	<div class="labelStyle floatL">
		<spring:message code="label.common.repairEndDate" />
	</div>
	<div class="floatL">
		<input TYPE="text" ng-disabled="true" data-ng-readonly="true" data-ng-model="fleetClaim.repairEndDate"  datepicker-popup="{{dateFormat}}" />
	</div>
	<div class="clear"></div>
	<div class="labelStyle floatL">
	<spring:message code="label.common.maintenanceType" />
	</div>
	<div class="floatL">
	<input TYPE="text" data-ng-model="maintenanceType" data-ng-readonly="true"/>
	</div>
	<div class="fieldSpacerWidth floatL">&nbsp;</div>
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
	<div class="clear"></div>
	<div data-ng-show="fleetClaim.parentClaimNumber">
	<div class="labelStyle floatL">
	<spring:message code="label.common.parentClaimNumber" />
	</div>
	<div class="floatL">
	<input TYPE="text" data-ng-model="fleetClaim.parentClaimNumber" data-ng-readonly="isReadOnly()"/>
	</div>
	</div>
	<div class="labelStyle floatL" style="margin-left: 465px;">
		<spring:message code="label.common.informationOnly" />
	</div>
	<div class="floatL">
		<input TYPE="checkbox" ng-disabled="true" data-ng-readonly="true" data-ng-model="activeAudit.informationOnly" />
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

</div>