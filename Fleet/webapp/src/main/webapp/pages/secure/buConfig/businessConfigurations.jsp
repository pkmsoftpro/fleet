<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html id="ng-app" data-ng-app="businessConfigInfo">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<u:stylePicker fileName="customer/customer.css" />
<style type="text/css">
.showMessageBox {
	text-decoration: blink;
	color: red;
	margin-top: 10px;
	padding: 2px;
}
</style>
</head>
<u:body theme="fleet">
    <form data-ng-controller="businessConfigInfo" name="form" novalidate>
        
    </form>
</u:body>
<script type="text/javascript" src="../scripts/businessConfig/buConfig.js"></script>
</html>