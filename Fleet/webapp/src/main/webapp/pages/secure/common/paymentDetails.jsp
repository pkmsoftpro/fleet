<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div ng-show="isInternalUserOrOwningDealer">

	<div class="text-link" style="cursor: pointer"
		data-ng-hide="isReadOnly()" ng-click="refreshPayment()">
		<spring:message code="label.common.refreshPayment" />
	</div>
	<%@include file="../common/paymentDealer.jsp"%>

	<%@include file="../common/paymentCustomer.jsp"%>
</div>
<div ng-show="servicingDealer">
	<%@include file="../common/paymentDealerReadOnly.jsp"%>
</div>
<div ng-show="isCustomerUser">
	<%@include file="../common/paymentCustomerReadOnly.jsp"%>
</div>


