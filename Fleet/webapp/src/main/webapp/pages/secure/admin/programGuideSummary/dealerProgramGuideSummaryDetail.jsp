<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="dealerProgramGuideSummaryApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/vendor/angularjs/textAngular.js"></script>
<script src="../scripts/vendor/angularjs/angular-sanitize.min.js"></script>
<script src="../scripts/angular/apps/dealerProgramGuideSummaryApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css'>
</head>
<u:body theme="fleet">
 <div ng-init="dealerProgramGuideSummaryId='${dealerProgramGuideSummaryId}'"></div>
 <div ng-init=""></div>
    <form data-ng-controller="dealerProgramGuideSummaryController" class="container app" name="form" novalidate>
        <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
        <div ng-hide="sectionview">
         <div class="accordion-header contentPane">
          <!-- accordion header -->
                <spring:message code="accordionLabel.programGuideSummary.dealer"/>:
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="label.serviceCode.dealerName"/>:
			</div>
			<div class="floatL" data-ng-if="!dealerProgramGuideSummaryId" >
		          <input type="text" url="listServiceProviders" fbs-typeahead ng-change="getDealer(dealerProgramGuideSummary.dealer.name)" data-ng-model="dealerProgramGuideSummary.dealer.name"  />
			</div>
			<div class="floatL" data-ng-if="dealerProgramGuideSummaryId" >
		          <input type="text" data-ng-model="dealerProgramGuideSummary.dealer.name" data-ng-readonly="dealerProgramGuideSummaryId" />	
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.inventory.customerName"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
		          <input type="text" url="listFleetCustomers" fbs-typeahead ng-change="getCustomerByName(dealerProgramGuideSummary.customer.name)" data-ng-model="dealerProgramGuideSummary.customer.name" required />
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.key.contacts"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.keyContacts" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.labour.rates"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.labourRates" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.parts.pricing"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.partsPricing" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.fleetClaim.travel"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.travel" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.quote.requirement"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.quoteRequirement" ta-disabled='disabled'></div>
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
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.purchaseOrderRequirement" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.serviceRequest.quickSearch"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.serviceRequest" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.service.expectations"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.serviceExpectations" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.tires.and.wheels"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.tiresAndWheels" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.claim.submission.instructions"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.claimSubmissionInstructions" ta-disabled='disabled'></div>
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
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.loanerProvision" ta-disabled='disabled'></div>
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
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.billingAllowances" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="label.common.program.exclusions"/>:
			</div>
            <div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.programExclusions" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
            <div class="clear"></div>
            <div class="labelStyle floatL">
				<spring:message code="title.common.specialInstructions"/>:
			</div>
            <div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.specialInstructions" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
            <div class="clear"></div>
            <div class="labelStyle floatL">
				<spring:message code="label.common.pm.services"/>:
			</div>
			<div class="textBoxAlignment">
		        <div class="container">
		            <div class="box">
		                <div text-angular="text-angular" data-ng-model="dealerProgramGuideSummary.periodicMaintenanceServices" ta-disabled='disabled'></div>
		            </div>
		        </div>
    		</div>
        </div>
        
        <div style="padding-left: 400px;" ng-show="!successPage">
                <button type="button" class="blue-btn btn-primary" data-ng-click="saveDealerPGS()" ng-disabled='form.$invalid'>
                    <spring:message code="label.Common.save" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                    onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="deleteDealerPGS()" ng-disabled='form.$invalid'>
                    <spring:message code="label.common.delete" />
                </button>
       </div>
       </div>
</form>
</u:body>
</html>
