 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="authz" uri="authz"%>

<div ng-show="isInternalUserOrOwningDealer">
    <div ng-show="(serviceRequest.displayStatus!='Closed')">
        <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
        </button>
   </div>
</div>


 <div ng-show="isCustomerUser">
    <div ng-show="(serviceRequest.displayStatus=='Draft')">
        <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
        </button>
   </div>
</div>

<div ng-show="servicingDealer">
     <div ng-show="(serviceRequest.displayStatus=='Draft')
                    ||(serviceRequest.displayStatus=='Assigned')
                    ||(serviceRequest.displayStatus=='Dispatched')
                    ||(serviceRequest.displayStatus=='On Hold')
                    ||(serviceRequest.displayStatus=='Work In Progress')">                    
        <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
        </button>
     </div>
</div>