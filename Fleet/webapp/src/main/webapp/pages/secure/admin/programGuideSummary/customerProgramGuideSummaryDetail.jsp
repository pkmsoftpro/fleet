<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="customerProgramGuideSummaryApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/vendor/angularjs/textAngular.js"></script>
<script src="../scripts/vendor/angularjs/angular-sanitize.min.js"></script>
<script src="../scripts/angular/apps/customerProgramGuideSummaryApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css'>
</head>
<u:body theme="fleet">
 <div ng-init="customerProgramGuideSummaryId='${customerProgramGuideSummaryId}'"></div>
 <div ng-init=""></div>
    <form data-ng-controller="customerProgramGuideSummaryController" class="container app" name="form" novalidate>
        <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
        <div ng-hide="sectionview">
         <div class="accordion-header contentPane">
          <!-- accordion header -->
                <spring:message code="accordionLabel.programGuideSummary.customer"/>:
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.inventory.customerName"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL" data-ng-if="!customerProgramGuideSummaryId">
		          <input type="text" url="listFleetCustomers" fbs-typeahead ng-change="getCustomerByName(customerProgramGuideSummary.customer.name)" data-ng-model="customerProgramGuideSummary.customer.name" data-ng-readonly="customerProgramGuideSummaryId" required />
			</div>
			<div class="floatL" data-ng-if="customerProgramGuideSummaryId">
		          <input type="text" data-ng-model="customerProgramGuideSummary.customer.name" data-ng-readonly="customerProgramGuideSummaryId" required />	
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.primary.program.type"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.primaryProgramType" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.representative.contacts"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.representativeContacts" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.billing.intervals"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.billingIntervals" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.dispute.process"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.disputeProcess" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.alternate.service.providers"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.alternateServiceProviders" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.service.request.process"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.serviceRequestProcess" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.purchase.order.requirement"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.purchaseOrderRequirement" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.response.time"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.responseTime" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.after.hours.process"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.afterHoursProcess" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.threshold"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.quoteThreshold" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.loaner.process"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.loanerProcess" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.reporting"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.reporting" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.travel.stipulations"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.travelStipulations" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.billing.allowances"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.billingAllowances" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.notes.and.exclusions"/>:
			</div>
            <div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.notesAndExclusions" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
            <div class="clear"></div>
            <div class="labelStyle floatL">
				<spring:message code="label.common.pm.intervals"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="customerProgramGuideSummary.periodicMaintenanceInterval" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
        </div>
        
        <div style="padding-left: 400px;" ng-show="!successPage">
                <button type="button" class="blue-btn btn-primary" data-ng-click="saveCustomerPGS()" ng-disabled='form.$invalid'>
                    <spring:message code="label.Common.save" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                    onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel" />
                </button>
                 <button type="button" class="blue-btn btn-primary" data-ng-click="deleteCustomerPGS()" ng-disabled='form.$invalid'>
                    <spring:message code="label.common.delete" />
                </button>
       </div>
       </div>
</form>
</u:body>
</html>
