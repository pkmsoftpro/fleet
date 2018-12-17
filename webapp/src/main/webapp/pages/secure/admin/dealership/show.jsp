<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<html id="ng-app" data-ng-app="dealerShip">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<s:head theme="fleet" />
		<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
		<!--  SCRIPTS -->
		<script src="../scripts/dealer/dealerShipApp.js"></script>
	</head>
	
	<u:body theme="fleet">
		<div data-ng-init="dealerShip.id=${id}"></div>
		<form data-ng-controller="DealerShipController" name="form" novalidate>
			<jsp:include page="./detailsReadOnly.jsp"/>
		</form>
	</u:body>
</html>