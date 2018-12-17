<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<authz:ifCurrentUserType userType="CUSTOMER">
	<div class="floatR" > 
	    <img src="../image/pgmSummary.png" class="marR10" data-ng-click="printCustomerPGS()" tooltip="<spring:message code='label.common.pgs'/>" tooltip-placement="left"/>
	</div>
</authz:ifCurrentUserType>
<authz:ifCurrentUserType userType="DEALER USER">
	<div data-ng-if="dpgsEnabled()"  class="floatR" > 
	    <img src="../image/pgmSummary.png" class="marR10" data-ng-click="printDealerPGS()" tooltip="<spring:message code='label.common.pgs'/>" tooltip-placement="left"/>
	</div>
</authz:ifCurrentUserType>
<authz:ifCurrentUserType userType="INTERNAL">
	<div data-ng-if="enabled()" class="floatR" > 
	    <img src="../image/pgmSummary.png" class="marR10" data-ng-click="printPGS()" tooltip="<spring:message code='label.common.pgs'/>" tooltip-placement="left"/>
	</div>
</authz:ifCurrentUserType>
