<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html id="ng-app" data-ng-app="createFleetClaim">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
</head>
<u:body theme="fleet">
	<form>
			
				<div  class="alert-success"
					style="color: green; font-size: 120%; font-weight: bold;"><div align="center">${successMessage}</div></div>
			
			<div class="fieldSpacerHeight" style="clear: both;"></div>
			<div align="center">
				<button type="button" class="blue-btn btn-primary"
					onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
					<spring:message code="label.Common.close" />
				</button>
			</div>
	</form>
</u:body>
</html>