<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
 <script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/quote/quoteApp.js"></script>
<script src="../scripts/core/module/uiTreeType.js"></script>
<script src="../scripts/core/module/multiCheckBox.js"></script>

<div ng-show="isEntryValidationCheck==false">
    <div alert-msg></div>
</div>
<c:if test="${folderName == null or folderName=='Quotes Drafted'}">
	<div>
		<input name="dirtyValue" id="dirtyValue" ng-disabled="form.$dirty" type="hidden" />
	</div>
</c:if>

<div>
    <div class="clear"></div>
    <div data-ng-if="quote.id!=null" calss="status" class='details-page-header'>
       <span class="details-header"><spring:message code="title.common.quoteDetails"/></span><span class="details-status"><spring:message code="label.common.status" />
        - {{quote.displayStatus}}</span>
       <jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
    </div>
    <div data-ng-if="quote.id==null" calss="status" class='details-page-header'>
       <span class="details-header"><spring:message code="title.common.quoteDetails"/></span><span class="details-status"><spring:message code="label.common.status" />
        - {{quote.quoteNumber}}</span>
       <jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
    </div>
    <div class="clear"></div>

</div>
    <%@include file="quoteDetails.jsp"%>

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
    <%@include file="../common/failureInformation.jsp"%>
</div>
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
<div ng-show='applicableTravelMatrix.length>0'>
     <%@include file="../common/travelDetails.jsp"%>
</div>
<div class="clear"></div>
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

<div class="clear"></div>
<div data-ng-show="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="accordion-header contentPane">
    <spring:message code="label.quote.paymentDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div data-ng-if="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="overflow-hidden accordion-info">
	<%@include file="../common/paymentDetails.jsp"%>
</div>
<div data-ng-if="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="clear"></div>
<%--  <div title-pane content-pane-title="<spring:message code="title.common.quoteAmountDetails"/>" collapse="false"></div>
        <%@include file="quoteAmountDetails.jsp"%>  --%>
<%@include file="comments.jsp"%>
<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.manageDocuments" />
    <span class="expand-collapse collapse-icon"></span>
</div>

 <div ng-if="isReadOnly()==false" class="overflow-hidden accordion-info">
    <%@include file="manageDocuments.jsp"%>
</div>
<div ng-if="isReadOnly()==true" class="overflow-hidden accordion-info">
    <%@include file="manageDocumentsReadonly.jsp"%>
</div>

<div class="clear"></div>
  <%--<div title-pane content-pane-title="<spring:message code="title.common.manageDocuments"/>" collapse="false"></div>
        <%@include file="manageDocuments.jsp"%>

        <div title-pane content-pane-title="<spring:message code="title.common.manageDocuments"/>" collapse="false"></div> --%>

<div data-ng-show="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'">
    <%@include file="revisions.jsp"%>
</div>
