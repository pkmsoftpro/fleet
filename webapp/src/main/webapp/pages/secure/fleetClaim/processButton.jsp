 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="authz" uri="authz"%>

<span ng-show="isProcessButtonVisible && isInternalUserOrOwningDealer">
    <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
    </button>
</span>


