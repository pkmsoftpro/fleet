
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div title-pane content-pane-title="<spring:message code="label.quote.summary"/>" collapse="false"></div>
<hr>
<div class="clear"></div>
<hr class="wid955">
<div class="clear"></div>
	<div class="details-sub-header">
		<span><spring:message code="label.quote.applicableContract" /> {{quote.serviceRequest.contractCode}}</span>
	</div><div class="clear"></div>
<div>
    <%@include file="../common/payment.jsp"%></div>
<div class="clear"></div>
<div class="clear"></div>
<div class="floatL"></div>
<div class="centered marB10">	
<button type="button" class="blue-btn btn-primary" data-ng-click="printQuoteSummary()">
    <spring:message code="label.common.print" />
</button>
<button type="button" class="blue-btn btn-primary" ng-click="closeSummary()">
    <spring:message code="label.Common.cancel" />
</div>
</button>