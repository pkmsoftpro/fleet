<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
 <script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/quote/quoteApp.js"></script>
<script src="../scripts/core/module/uiTreeType.js"></script>
<script src="../scripts/core/module/multiCheckBox.js"></script>
<style>
            .my-drop-zone { border: dotted 3px lightgray; }
            .ng-file-over { border: dotted 3px red; } /* Default class applied to drop zones on over */
            .another-file-over-class { border: dotted 3px green; }
</style>
<script type="text/javascript">
	function attachmentLink() {
		var serialNumber = document.getElementById('serialNumber').value;
		var thisTabLabel = getMyTabLabel();
		parent.publishEvent("/tab/open", {
			label : "Attachments",
			url : "show.action",
			decendentOf : thisTabLabel,
			forceNewTab : true
		});
	}
</script>
<div alert-msg></div>
<input type="hidden" id='readOnly' value='${readOnly}' />
<div data-ng-if="quote.id!=null">
    <div class="clear"></div>
    <div calss="status" class='details-page-header'>
       <span class="details-header"><spring:message code="title.common.quoteDetails"/></span><span class="details-status"><spring:message code="label.common.status" />
        - {{quote.displayStatus}}</span>
        <jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
    </div>
    <div class="clear"></div>
</div>
<authz:ifPermitted resource="quoteInboxes">
<div data-ng-show="processQuote==true">
    <jsp:include page="processButton.jsp"></jsp:include>
</div>
</authz:ifPermitted>
    <%@include file="quoteDetailsReadonly.jsp"%>

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
<div ng-show='applicableTravelMatrix.length>0'>
     <%@include file="../common/travelDetailsReadonly.jsp"%>
</div>

<div class="clear"></div>

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
<div data-ng-show="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="accordion-header contentPane">
    <spring:message code="label.quote.paymentDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div data-ng-if="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="overflow-hidden accordion-info">
	<%@include file="../common/paymentDetails.jsp"%>
</div>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.manageDocuments" />
    <span class="expand-collapse collapse-icon"></span>
</div>
 <div class="overflow-hidden accordion-info">
    <%@include file="manageDocumentsReadonly.jsp"%>
</div>
<div data-ng-if="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="clear"></div>
<%@include file="commentsReadonly.jsp"%>
<div class="clear"></div>
<span data-ng-show="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="clear">
    <%@include file="revisions.jsp"%>
</span>
