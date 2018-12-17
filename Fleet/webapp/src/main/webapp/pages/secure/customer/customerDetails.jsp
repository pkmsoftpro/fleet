<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<div><jsp:include page="customerGeneralDetails.jsp"></jsp:include></div>

<div class="clear"></div>
<div ng-if="customerId!=''">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.customerContacts" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <a class="marL895" href="#" data-ng-click="displayAllCustomerContacts(${customerId})"> <spring:message code="label.common.listCustomerContact" />
        </a>
        <div class="gridStyle" data-ng-grid="gridForCustomerContacts"></div>
    </div>
</div>

<div class="clear"></div>


<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.standardDealerInstructions" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="title.common.specialInstructions" />
            :
        </div>
        <div class="floatL">
            <textarea data-ng-model="customer.specialInstructions" rows="4" cols="500" class="wid500" max-length></textarea>
        </div>

    </div>
</div>

<div ng-if="customerId!=''">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="label.customer.customerLocations" />
        <span class="expand-collapse collapse-icon"></span>
    </div>

    <div class="overflow-hidden accordion-info">

        <a class="marL950" href="#" data-ng-click="displayAllLocationDetails(${customerId})"> <spring:message code="label.customerLocation.showLocations" />
        </a>
        <div class="nglocationGrid" data-ng-grid="gridForCustomerLocations"></div>
    </div>
</div>

<div class="sectionSpacerHeight clear"></div>
<div class="sectionSpacerHeight clear"></div>

<div style="padding-left: 400px;">
    <div ng-if="customerId!=''">
    <authz:ifPermitted resource="updateCustomerAndLocationInformation">
        <button type="button" class="blue-btn btn-primary" data-ng-click="save(true)" ng-disabled='form.$invalid'>
            <spring:message code="label.common.update" />
        </button>
    </authz:ifPermitted>    
        <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
            <spring:message code="label.Common.cancel" />
        </button>
    </div>
    <div ng-if="customerId==''">
     <authz:ifPermitted resource="updateCustomerAndLocationInformation">
        <button type="button" class="blue-btn btn-primary" data-ng-click="submit()" ng-disabled='form.$invalid'>
            <spring:message code="label.common.save" />
        </button>
     </authz:ifPermitted>
        <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
            <spring:message code="label.Common.cancel" />
        </button>
    </div>
    <%--          <button type="button" class="blue-btn btn-primary" ng-show="customer.status=='Active'" data-ng-click="save(false)">
                <spring:message code="label.common.deactivate" />
            </button>
            <button type="button" class="blue-btn btn-primary" ng-show="customer.status=='Inactive'" data-ng-click="save(false)">
                <spring:message code="label.common.activate" />
            </button> --%>
</div>
