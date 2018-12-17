 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="authz" uri="authz"%>

    <div ng-show="(quote.displayStatus!='Sent for Revision')
                    &&(quote.displayStatus!='Reverted')                    
                    &&(quote.displayStatus!='Expired')
                    &&(quote.displayStatus!='Draft') &&(quote.displayStatus!='Closed') && isInternalUserOrOwningDealer">
        <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
        </button>
   </div>

    <div ng-show="isCustomerUser && ((quote.displayStatus=='Resubmitted')
                    ||(quote.displayStatus=='Submitted To Customer')) ">
        <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
        </button>
   </div>

     <div ng-show="servicingDealer && ((quote.displayStatus=='Draft')
                    ||(quote.displayStatus=='Submitted')
                    ||(quote.displayStatus=='Denied')
                    ||(quote.displayStatus=='Request Revision')
                    ||(quote.displayStatus=='Reverted'))">
        <button type="button" class="blue-btn btn-primary" onclick="processSearch()">
             <spring:message code="label.common.process" />
        </button>
     </div>