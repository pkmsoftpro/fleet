<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/core/module/uiTreeType.js"></script>
<script src="../scripts/core/module/multiCheckBox.js"></script>
<div ng-show="isEntryValidationCheck==false">
    <div alert-msg></div>
</div>
<c:if test="${folderName == null or folderName=='Draft Claims' or folderName=='Dealer Owned Draft Claims' }">
	<input name="dirtyValue" id="dirtyValue" ng-disabled="form.$dirty"  type="hidden"  />
</c:if>
<div>
	<div class="clear"></div>
	<div data-ng-if="fleetClaim.id!=null" calss="status" class='details-page-header'>
		<span class="details-header"><spring:message code="title.common.claimDetails" />
		</span><span class="details-status"><spring:message code="label.common.status" /> - {{fleetClaim.displayStatus}}</span>
		<jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
	</div>
	<div data-ng-if="fleetClaim.id==null" calss="status" class='details-page-header'>
		<span class="details-header"><spring:message code="title.common.claimDetails" />
		</span><span class="details-status"><spring:message code="label.common.status" /> - {{fleetClaim.fleetClaimNumber}}</span>
		<jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
	</div>
	<div class="clear"></div>
</div>
<div class="clear"></div>
<%-- <c:if test="${folderName=='Advice Request' || folderName=='Pre-Invoice Disputed' || folderName=='New'|| folderName=='In Progress' || folderName=='Transferred' || folderName=='Replies' || folderName=='Claims Revised by Dealer'|| folderName=='Appeals' || folderName=='Pending Authorization'}"> --%>
<div data-ng-if="activeAudit.ruleFailures.length>0 && isInternalUserOrOwningDealer">
<div data-ng-if="fleetClaim.autoAccepted==false" class="accordion-header contentPane">
    <spring:message code="label.fleetClaim.processedRule.errors" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div data-ng-if="fleetClaim.autoAccepted==true" class="accordion-header contentPane">
    <spring:message code="label.fleetClaim.processedRule.processedRules" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info" ng-if="fleetClaim.autoAccepted!=null">
    <%@include file="claimProcessedRules.jsp"%>
</div>
<div class="clear"></div>
</div>
<%--  </c:if>  --%>
<%@include file="fleetClaimDetails.jsp"%>

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
<%@include file="fleetClaimAdditionalAttributes.jsp"%>
</div>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.failureInformation" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <%@include file="../common/failureInformation.jsp"%>
</div>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.laborDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div  class="overflow-hidden accordion-info">

<%@include file="../common/laborDetails.jsp"%>
</div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.partsOrComponents" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
     <%@include file="../common/partsOrComponents.jsp"%>
</div>
<div class="clear"></div>

<!-- <div ng-show='applicableTravelMatrix.length>0'> -->
  <%@include file="../common/travelDetails.jsp"%>
<!-- </div> -->
 <div ng-show='showMiscSection'>
<div class="accordion-header contentPane">
    <spring:message code="title.common.miscellaneous" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
     <%@include file="../common/miscellaneous.jsp"%>
</div>
</div>
<div class="clear"></div>
     <%@include file="../common/drayage.jsp"%>

<div data-ng-show="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" class="accordion-header contentPane">
    <spring:message code="label.quote.paymentDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" class="overflow-hidden accordion-info">
	<%@include file="../common/paymentDetails.jsp"%>
</div>
<!-- <div data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'" class="clear"></div> -->


<%--  <div title-pane content-pane-title="<spring:message code="title.common.quoteAmountDetails"/>" collapse="false"></div>
        <%@include file="quoteAmountDetails.jsp"%>   --%>
<div class="clear"></div>
<%@include file="comments.jsp"%>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.manageDocuments" />
    <span class="expand-collapse collapse-icon"></span>
</div>

 <div class="overflow-hidden accordion-info">
     <div data-ng-if="isReadOnly()==false"><%@include file="manageDocuments.jsp"%></div>
     <div data-ng-if="isReadOnly()==true"><%@include file="manageDocumentsReadonly.jsp"%></div>
</div>
<div class="clear"></div>

<div data-ng-show="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'">
    <%@include file="revisions.jsp"%>
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