<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<div class="clear"></div>
<div title-pane content-pane-title="<spring:message code="label.fleetClaim.summary"/>" collapse="false"></div>
<div>
    <div ng-if="validation==false">
        <div class="red">
            <spring:message code="label.common.errors" />
            :
        </div>
    </div>
</div>
<div>
    <div alert-msg></div>
</div>
<p></p>
<div ng-show="validation==true">
<hr class="wid955">
<div class="clear"></div>
<div class="details-sub-header">
		<span><spring:message code="label.quote.applicableContract" /> {{fleetClaim.contractCode}}</span>
		<div ng-show="isInternalUserOrOwningDealer">
		<span><spring:message code="label.common.faultFound" /> : {{fleetClaim.activeFleetClaimAudit.serviceInformation.faultFound.name}}</span>
		<br/><span><spring:message code="label.common.causedBy" /> :{{fleetClaim.activeFleetClaimAudit.serviceInformation.causedBy.name}}</span>
		<br/><span><spring:message code="columnTitle.claimsListing.callType" />: {{fleetClaim.activeFleetClaimAudit.callType.name}}</span>
		</div>
</div><div class="clear"></div>
<div data-ng-show="activeAudit.informationOnly==false">
    <%@include file="../common/payment.jsp"%></div>
<div class="clear"></div>

 <div class="centered marB10">
<c:choose>
    <c:when test="${folderName!= null}">
        <button type="button" class="blue-btn btn-primary" data-ng-click="processClaim()">
            <spring:message code="label.common.submit" />
        </button>
    </c:when>
    <c:otherwise>
        <button type="button" class="blue-btn btn-primary" data-ng-click="submit()">
            <spring:message code="label.common.submit" />
        </button>
    </c:otherwise>
</c:choose>
<button type="button" class="blue-btn btn-primary" ng-click="edit()">
    <spring:message code="label.common.edit" />
</button>
    <button type="button" class="blue-btn btn-primary" data-ng-click="printClaimSummary()">
        <spring:message code="label.common.print" />
    </button>
</div>
</div>
<div ng-show="validation==false">
    <div class="centered marB10">
        <button type="button" class="blue-btn btn-primary" ng-click="edit()">
            <spring:message code="label.common.edit" />
        </button>
    </div>
</div>