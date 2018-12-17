<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html id="ng-app" data-ng-app="customers">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<u:stylePicker fileName="customer/customer.css" />
<script src="../scripts/customer/customer.js"></script>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/core/module/uiTreeType.js"></script>
<script src="../scripts/core/module/multiCheckBox.js"></script>
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
</head>
<u:body theme="fleet">
    <%@include file="i18N_fleetCustomer_javascript_vars.jsp"%>
    <input type="hidden" id='isDealerOwned' value='${isDealerOwned}' />
    <input type="hidden" id='customerId' value='${customerId}' />
    <div ng-init="isDealerOwned=${isDealerOwned}"></div>
    <form data-ng-controller="customerController" name="form" id='customerForm' novalidate>
        <div ng-show="submitForm!=true">
            <%@include file="customerDetails.jsp"%>
        </div>
        <div ng-show="submitForm==true">
            <%@include file="../common/success.jsp"%>
        </div>
    </form>
</u:body>
</html>