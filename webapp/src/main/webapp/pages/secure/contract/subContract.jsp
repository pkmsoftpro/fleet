<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="createContract">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<script src="../scripts/contract/contractApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
</head>
<u:body theme="fleet">
    <input type="hidden" id='subContractId' value='${subContractId}' />
    <input type="hidden" id='dateFormat' value='${dateFormat}' />
    <form data-ng-controller="SubContractController" name="form" novalidate>
        <input type="hidden" id='fleetInventoryId' value="{{serviceCall.associatedServiceCode.fleetInventoryItem.id}}"/>
         <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
             <%@include file="subContractDetails.jsp"%>
         <div class="clear"></div>
    </form>
</u:body>
<script type="text/javascript">
</script>
</html>