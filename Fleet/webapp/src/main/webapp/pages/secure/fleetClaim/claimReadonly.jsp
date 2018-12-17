<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html id="ng-app" data-ng-app="createFleetClaim">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<script src="../scripts/fleetClaim/fleetClaimApp.js"></script>
<script type="text/javascript"
    src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
</head>
<u:body theme="fleet">
	<%@include file="i18N_fleet_claim_javascript_vars.jsp"%>
	<input type="hidden" id='taskId' value='${taskId}' />
    <input type="hidden" id='fleetClaimId' value='${fleetClaimId}' />
    <input type="hidden" id='searchFleetClaimId' value='${searchFleetClaimId}'>
    <input type="hidden" id='id' value='${id}' />
    <input type="hidden" id='selectedAuditId' value="${selectedAuditId}">
    <input type="hidden" id='isUserAdmin' value='${isUserAdmin}' />
    <div ng-init="dealerId='${dealerId}'"></div>
	<div ng-init="dateFormat='${dateFormat}'"></div>
	 <div ng-init="folderName='${folderName}'"></div>   
	<form data-ng-controller="FleetClaimController" name="form" novalidate id="fleetClaimForm">
    	<div ng-show="fleetClaimForm==true">
    		<jsp:include page="fleetClaimReadonly.jsp"></jsp:include>
    		<div class="clear"></div>
    	</div>
    	<script type="text/javascript">  	
    function processSearch(){
        var fleetClaimId=document.getElementById('searchFleetClaimId').value;
        window.location.href='process_search_fleetClaim.action?fleetClaimId='+fleetClaimId;
    }
    function reopenFleetClaim(){
        var fleetClaimId=document.getElementById('searchFleetClaimId').value;
        window.location.href='reopenFleetClaim.action?fleetClaimId='+fleetClaimId;
    } 
</script>
	</form>
</u:body>
</html>