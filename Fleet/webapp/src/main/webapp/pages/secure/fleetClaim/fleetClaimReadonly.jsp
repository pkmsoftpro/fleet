<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/quote/quoteApp.js"></script>
<script src="../scripts/core/module/uiTreeType.js"></script>
<script src="../scripts/core/module/multiCheckBox.js"></script>
<div alert-msg></div>
<input type="hidden" id='readOnly' value='true' />
<div data-ng-if="fleetClaim.id!=null">
	<div class="clear"></div>
	<div calss="status" class='details-page-header'>
		<span class="details-header"><spring:message code="title.common.claimDetails" />
		</span><span class="details-status"><spring:message code="label.common.status" /> - {{fleetClaim.displayStatus}}</span>
		<jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
	</div>
	<div class="clear"></div>
</div>
<div data-ng-show="searchfleetClaim==true">
    <jsp:include page="processButton.jsp"></jsp:include>
	<authz:ifPermitted resource="reopenClaim">
		<span data-ng-show="showClaimReopenButton==true">
			<button type="button" class="blue-btn btn-primary"
				onclick="reopenFleetClaim()">
				<spring:message code="label.common.reopen" />
			</button>
		</span>
	</authz:ifPermitted>
	<authz:ifPermitted resource="appealClaim">
		<span data-ng-show="fleetClaim.displayStatus=='Denied And Closed'">
			<button type="button" class="blue-btn btn-primary"
				ng-click="appealFleetClaim()" ng-disabled='form.$invalid'>
				<spring:message code="label.common.appealed" />
			</button>
		</span>
	</authz:ifPermitted>	
			<div data-ng-if="activeAudit.ruleFailures.length>0 && isInternalUserOrOwningDealer">
				<div data-ng-if="fleetClaim.autoAccepted==true" class="accordion-header contentPane">
				    <spring:message code="label.fleetClaim.processedRule.processedRules" />
				    <span class="expand-collapse collapse-icon"></span>
				</div>
				<div class="overflow-hidden accordion-info" ng-if="fleetClaim.autoAccepted==true">
				    <%@include file="claimProcessedRules.jsp"%>
				</div>
				<div class="clear"></div>
			</div>
</div>

<%@include file="fleetClaimDetailsReadonly.jsp"%>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.equiptmentDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <%@include file="../common/equipmentDetails.jsp"%>
</div>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.fleetClaimAdditionalAttributes" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
<span>
<%@include file="fleetClaimAdditionalAttributesReadOnly.jsp"%>
</span>
</div>

<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.failureInformation" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <%@include file="../common/failureInformationReadonly.jsp"%>
</div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.laborDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div  class="overflow-hidden accordion-info">
        <%@include file="../common/laborDetailsReadonly.jsp"%>
</div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.partsOrComponents" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
     <%@include file="../common/partsOrComponentsReadonly.jsp"%>
</div>
<div class="clear"></div>

<!-- <div ng-show='applicableTravelMatrix.length>0'> -->
  <%@include file="../common/travelDetailsReadonly.jsp"%>
<!-- </div> -->

<div class="accordion-header contentPane">
    <spring:message code="title.common.miscellaneous" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
     <%@include file="../common/miscellaneousReadonly.jsp"%>
</div>
<div class="clear"></div>
     <%@include file="../common/drayageReadOnly.jsp"%>
<div class="clear"></div>

<div data-ng-show="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" class="accordion-header contentPane">
    <spring:message code="label.quote.paymentDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" class="overflow-hidden accordion-info">
	<%@include file="../common/paymentDetails.jsp"%>
</div>
<div data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" class="clear"></div>

<div data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'">
	<%@include file="creditMemo.jsp"%>
</div>



<%--  <div title-pane content-pane-title="<spring:message code="title.common.quoteAmountDetails"/>" collapse="false"></div>
        <%@include file="quoteAmountDetails.jsp"%>  --%>
<%-- <%@include file="comments.jsp"%> --%>
<%@include file="commentsReadonly.jsp"%>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.manageDocuments" />
    <span class="expand-collapse collapse-icon"></span>
</div>

 <div class="overflow-hidden accordion-info">
    <%@include file="manageDocumentsReadonly.jsp"%>
</div>
<div class="clear"></div>

<div data-ng-show="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'">
    <%@include file="revisions.jsp"%>
</div>

<div class="clear"></div>

<%-- <authz:ifUserInRole roles="dealer,fleetProcessor,fleetServiceSpecialist" > --%>
<div ng-show="isInternalUserOrOwningDealer||servicingDealer||isFleetProcesor">
    <%@include file="fleetProcessorActionsReadOnly.jsp"%>
<%-- </authz:ifUserInRole> --%>
</div>

<div class="clear"></div>

 <div popup="showWarrantyWarningMessage" close="closeWarrantyWarningMessage()">
        <div class="modal-header">
            <%-- <h4>
			<spring:message code="label.serviceRequest.underWarranty.title" />
			</h4> --%>
        </div>
        <div class="modal-body">
            <center>
                <spring:message code="label.fleetClaim.underWarranty.notification" />
            </center>
            <div class="clear"></div>
            <center>
            <button type="button" class="blue-btn" ng-click="closeWarrantyWarningMessage()">
                <spring:message code="label.serviceRequest.underWarranty.ok" />
            </button>
            </center>
        </div>
    </div>