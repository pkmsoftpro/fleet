<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
        <tr><td class="ItemsHdrCommonCharts"><s:text name="label.common.charts" /></td></tr>
		<authz:ifCurrentUserType userType="DEALER USER">
		   <c:if test="${isDealerOwnedUser ==true}">
		      <tr><td><jsp:include flush="true" page="internalDashboard.jsp" /></td></tr>  
		   </c:if>
		   <c:if test="${isDealerOwnedUser ==false}">
		     <tr><td><jsp:include flush="true" page="dealerDashboard.jsp"/></td></tr>
		   </c:if>
		</authz:ifCurrentUserType>
		<authz:ifCurrentUserType userType="INTERNAL">
			<tr><td><jsp:include flush="true" page="internalDashboard.jsp" /></td></tr>
		</authz:ifCurrentUserType>
		<authz:ifCurrentUserType userType="CUSTOMER">
		    <tr><td><jsp:include flush="true" page="customerDashboard.jsp" /></td></tr>
		</authz:ifCurrentUserType>
</table>

<%-- <authz:ifUserInRole roles="dealer,admin,dsm,dsmAdvisor,fleetServiceSpecialist,fleetProcessor,customer">
<div class="themesdiv">
	<table>
		<tr>
			<td class="underlinetext"><spring:message
					code="label.dashboard.select.themes" />:</td>
			<td><div class="fieldSpacerWidth floatL">&nbsp;</div>
			</td>
			<td><input type="radio" name="theme"
				value="../scripts/vendor/highcharts/js/themes/default.js">
			<spring:message code="label.dashboard.defaultTheme" />&nbsp;</td>
			<td><input type="radio" name="theme"
				value="../scripts/vendor/highcharts/js/themes/dark-blue.js">
			<spring:message code="label.dashboard.dark.blue" />&nbsp;</td>
			<td><input type="radio" name="theme"
				value="../scripts/vendor/highcharts/js/themes/dark-green.js">
			<spring:message code="label.dashboard.dark.green" />&nbsp;</td>
			<td><input type="radio" name="theme"
				value="../scripts/vendor/highcharts/js/themes/dark-unica.js">
			<spring:message code="label.dashboard.dark.unica" />&nbsp;</td>
			<td><input type="radio" name="theme"
				value="../scripts/vendor/highcharts/js/themes/sand-signika.js">
			<spring:message code="label.dashboard.sand.signika" />&nbsp;</td>
		</tr>
	</table>
</div>
</authz:ifUserInRole> --%>