<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<html id="ng-app" data-ng-app="customerLocation">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<u:stylePicker fileName="customer/customer.css" />
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
</head>

<u:body theme="fleet">
    <input type="hidden" id='isDealerOwned' value='${isDealerOwned}' />
    <div ng-init="isDealerOwned=${isDealerOwned}"></div>
    <form data-ng-controller="CustomerLocationController" name="form" id="locationform" novalidate ng-submit="submitForm();">
        <div class="wid930">
           <div alert-msg></div>
        </div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.LocationDetails" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <div ng-init="customerLocId='<c:out value="${customerLocId}" />'"></div>
            <input type="hidden" name="customerLocId" data-ng-model="customerLocId" />
            <%@include file="locationDetails.jsp"%>
        </div>
        <div class="clear"></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.MachinesCovered" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">

            <div class="gridStyle" data-ng-grid="gridForMachines"></div>
        </div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.contractsCovered" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">

            <%@include file="contractCovered.jsp"%></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.customerContacts" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
          <a class="marL895" href="#" data-ng-click="displayAllCustomerContacts(${customerLocId})"> <spring:message code="label.common.listCustomerContact" />
          </a>
            <div class="gridStyle" data-ng-grid="gridForLocationContacts"></div>
        </div>
        <div class="clear-hgt10"></div>

        <div align="center">
        <authz:ifPermitted resource="updateCustomerAndLocationInformation">
            <button type="button" class="blue-btn btn-primary" data-ng-click="save(true)"
                ng-disabled='form.$invalid || (customerLocation.poLengthSpecified==true&&customerLocation.purchaseOrderLength==null) 
                || (customerLocation.periodicServiceCall==true&&customerLocation.numberOfDays==null)'>
                <spring:message code="label.Common.save" />
            </button>
        </authz:ifPermitted>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                <spring:message code="label.Common.cancel" />
            </button>
          </div>
    </form>

    <script src="../scripts/location/customerLocationApp.js"></script>
    <script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
    <script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>

</u:body>
</html>