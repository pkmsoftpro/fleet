<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<c:choose>
    <c:when test="${folderName!= null}">
        <div ng-show="servicingDealer">
            <%@include file="dealerActions.jsp"%>
        </div>
       <div ng-show="isInternalUserOrOwningDealer">
            <%@include file="fleetServiceSpecialistActions.jsp"%>
        </div>
        <div ng-show="isCustomerUser">
            <%@include file="customerActions.jsp"%>
        </div>
    </c:when>
    <c:otherwise>
        <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="validateQuote()" ng-disabled='form.$invalid ||PONumberDuplicate==true||PONumberExits'>
                    <spring:message code="label.Common.validate" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="save()" ng-disabled="form.serialNumber.$error.required || form.serialNumber.$error.invalid || form.serviceRequestNo.$error.required">
                    <spring:message code="label.Common.save" />
                </button>
                    <button data-ng-show="quote.id!=null" type="button" class="blue-btn btn-primary" data-ng-click="deleteDraftQuote()">
                        <spring:message code="label.common.delete" />
                    </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
        </div>
    </c:otherwise>
</c:choose>
