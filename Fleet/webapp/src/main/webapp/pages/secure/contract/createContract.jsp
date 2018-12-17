<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html data-ng-app=createContract>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<u:stylePicker fileName="contract/contract.css" />
<style type="text/css">
.gridStyle {
	border: 1px solid rgb(212, 212, 212);
	width: 1000px;
	height: 200px;
}
</style>
</head>
<u:body theme="fleet">
    <%-- <%@include file="i18N_fleetCustomer_javascript_vars.jsp"%> --%>
    <input type="hidden" id='isDealerOwned' value='${isDealerOwned}' />
    <input type="hidden" id='contractId' value='${contractId}' />
    <input type="hidden" id='selectedAuditId' value="${selectedAuditId}">
    <div ng-init="dateFormat='${dateFormat}'"></div>
    <input type="hidden" id='dateFormat' value='${dateFormat}'/>
    <div ng-init="isDealerOwned=${isDealerOwned}"></div>
    <form data-ng-controller="ContractController" name="form" novalidate>
        <div ng-show="submitForm!=true">
            <%@include file="contractGeneralDetails.jsp"%>
        </div>
         <div ng-show="submitForm==true">
            <%@include file="../common/success.jsp"%>
        </div>
    </form>
</u:body>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/contract/contractApp.js"></script>
</html>