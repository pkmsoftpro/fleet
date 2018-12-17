<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="periodicService">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<script src="../scripts/periodicService/periodicServiceApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
</head>
<u:body theme="fleet">
<%-- <%@include file="i18N_quote_javascript_vars.jsp"%>
    <input type="hidden" id='taskId' value='${taskId}' />
    <input type="hidden" id='searchQuoteId' value="${searchQuoteId}" />
    <input type="hidden" id='selectedAuditId' value="${selectedAuditId}">
    <input type="hidden" id='readOnly' value='${readOnly}' />
    <input type="hidden" id='isUserAdmin' value='${isUserAdmin}' />
    <div ng-init="dealerId='${dealerId}'"></div>   --%>
    <div ng-init="dateFormat='${dateFormat}'"></div>
    <input type="hidden" id='dateFormat' value='${dateFormat}'/>
    <input type="hidden" id='serviceCallId' value='${serviceCallId}' />
    <form data-ng-controller="PeriodicServiceListingController" name="form" novalidate>
        <input type="hidden" id='fleetInventoryId' value="{{serviceCall.associatedServiceCode.fleetInventoryItem.id}}"/>
         <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
             <%@include file="periodicServiceDetails.jsp"%>
         <div class="clear"></div>
    </form>
</u:body>
<script type="text/javascript">
    function createServiceRequest(fleetInventoryId){
        var serviceCallId=document.getElementById('serviceCallId').value;
        var fleetInventoryId=document.getElementById('fleetInventoryId').value;
        window.location.href='createServiceRequestOnServiceCall.action?' +
                'fleetInventoryId=' + fleetInventoryId +
                '&serviceCallId=' + serviceCallId;
    }
</script>
</html>