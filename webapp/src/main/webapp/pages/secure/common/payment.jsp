<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



	<div ng-show="isInternalUserOrOwningDealer">
		<%@include file="../common/validatePaymentDealer.jsp"%>

		<%@include file="../common/validatePaymentCustomer.jsp"%>
	</div>

		<div ng-show="servicingDealer">
			<%@include file="../common/validatePymtDlrView.jsp"%>
		</div>
		<div ng-show="isCustomerUser">
			<%@include file="../common/validatePymtCustView.jsp"%>
		</div>


