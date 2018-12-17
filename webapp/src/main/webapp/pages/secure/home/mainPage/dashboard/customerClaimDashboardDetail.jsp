<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="customerClaimDashboardApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/vendor/angularjs/textAngular.js"></script>
<script src="../scripts/vendor/angularjs/angular-sanitize.min.js"></script>
<script src="../scripts/angular/apps/customerClaimDashboardApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css'>
</head>
<u:body theme="fleet">
 <div ng-init="customerClaimDashboardId='${customerClaimDashboardId}'"></div>
 <div ng-init=""></div>
    <form data-ng-controller="customerClaimDashboardController" class="container app" name="form" novalidate>
        <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
        <div ng-hide="sectionview">
         <div class="accordion-header contentPane">
          <!-- accordion header -->
                <spring:message code="label.customer.claim.dashboard"/>
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="label.customerLocation"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.customerLocationName"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.serviceRequest.serialNumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="equipmentHistoryPageDetail()" ><div class="wid222">{{customerClaimDashboard.serialNumber}}</div></a>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.serviceRequest.quotenumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="quoteDetail()" ><div class="wid222">{{customerClaimDashboard.quoteNumber}}</div></a>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.fleetClaim.claimNumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="quoteDetail()" ><div class="wid222">{{customerClaimDashboard.claimNumber}}</div></a>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.quote.serviceRequestNumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="serviceRequestDetail()" ><div class="wid222">{{customerClaimDashboard.serviceRequestNumber}}</div></a>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.service.requested.date"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerClaimDashboard.serviceRequestedDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.fleetClaim.poNumber"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.purchaseOrderNumber"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.total.cost"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalCost"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.invoiced.date"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.invoicedDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.workPerformed"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.workPerformed"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.customer.invoice.number"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.invoiceNumber"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.start.repair.date"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.startRepairDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.end.repair.date"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.endRepairDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.commom.callType"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerClaimDashboard.callType"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.servicing.dealer.name"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.servicingDealerName"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.fleetClaim.dealerWorkOrderNumber"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.dealerWorkOrderNumber"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.fleetClaim.meterReading"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.meterReading"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.componentCode"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.componentCode"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.fault.found.code"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.faultFoundCode"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.lovs.causedByCodes"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.causedByCode"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.total.labor"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalLabour"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.total.parts"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalParts"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.total.travel"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalTravel"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.total.drayage"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalDrayage"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.total.miscellaneous"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalMiscellaneous"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.total.tax"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerClaimDashboard.totalTax"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
        </div>
        
        <div style="padding-left: 400px;" ng-show="!successPage">
                <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                    onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel" />
                </button>
       </div>
       </div>
</form>
</u:body>
</html>
