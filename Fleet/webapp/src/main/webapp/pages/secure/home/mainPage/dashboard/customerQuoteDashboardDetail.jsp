<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="customerQuoteDashboardApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/vendor/angularjs/textAngular.js"></script>
<script src="../scripts/vendor/angularjs/angular-sanitize.min.js"></script>
<script src="../scripts/angular/apps/customerQuoteDashboardApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css'>
</head>
<u:body theme="fleet">
 <div ng-init="customerQuoteDashboardId='${customerQuoteDashboardId}'"></div>
 <div ng-init=""></div>
    <form data-ng-controller="customerQuoteDashboardController" class="container app" name="form" novalidate>
        <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
        <div ng-hide="sectionview">
         <div class="accordion-header contentPane">
          <!-- accordion header -->
                <spring:message code="label.customer.quote.dashboard"/>
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="label.customerLocation"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerQuoteDashboard.customerLocationName"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.serviceRequest.serialNumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="equipmentHistoryPageDetail()" ><div class="wid222">{{customerQuoteDashboard.serialNumber}}</div></a>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.serviceRequest.quotenumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="quoteDetail()" ><div class="wid222">{{customerQuoteDashboard.quoteNumber}}</div></a>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.quote.requested.date"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerQuoteDashboard.quoteRequestedDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.quoteStatus"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerQuoteDashboard.quoteStatus"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.commom.callType"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerQuoteDashboard.callType"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.quote.serviceRequestNumber"/>:
			</div>
			<div class="floatL">
				<a ng-href="#" data-ng-click="serviceRequestDetail()" ><div class="wid222">{{customerQuoteDashboard.serviceRequestNumber}}</div></a>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.service.requested.date"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerQuoteDashboard.serviceRequestedDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.fleetClaim.poNumber"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerQuoteDashboard.purchaseOrderNumber"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.total.cost"/>:
			</div>
			<div class="floatL">
				<div class="floatL">
					<input type="text" data-ng-model="customerQuoteDashboard.totalCost"  data-ng-readonly="true"/>
				</div>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.dashboard.fleet.recommendation"/>:
			</div>
			<div class="floatL">
				<div class="floatL" >
					<input type="text" data-ng-model="customerQuoteDashboard.fleetRecommendation" data-ng-readonly="true"/>
				</div>
			</div>
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
