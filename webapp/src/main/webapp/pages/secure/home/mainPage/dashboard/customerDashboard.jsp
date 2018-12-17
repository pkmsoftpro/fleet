<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%
response.setHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "must-revalidate");
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
%>
<jsp:include flush="true" page="i18N_customerDashboard_vars.jsp" />
<html>
<head>
<script type="text/javascript">
	var islocationChanged = '${islocationChanged}';
</script>
<script type="text/javascript"	src="../scripts/vendor/angularjs/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/highcharts.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/highcharts-more.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/modules/exporting.js"></script>
<script type="text/javascript" src="../scripts/dashboard/customerDashboard.js"></script>

<u:stylePicker fileName="dashboard/dashboard.css" />
</head>
<body>
 	<div id="loadingCustomerDashboard" class="floatL">
       &nbsp;<img src="../image/indicator.gif" alt="Loader" /><spring:message code="label.commom.loading"/>
   	</div>
   	<div class="clear"></div>
<div class="floatL">
      <div class="floatL">
         <c:if test="${fn:length(availableOrganizations) gt 1}">
          <div class="labelStyle floatL"><spring:message code="label.dashboard.select.all.locations"/>:</div>
          <div class="floatL"><input type="checkbox" name="hasAllChecked" id="hasAllCheckedId" checked="checked"></div>
         </c:if>
      </div>
      <div class="fieldSpacerWidth floatL">&nbsp;</div>
      <div class="floatL">
        <button type="button" class="blue-btn btn-primary" id="refreshId"><spring:message code="button.common.refresh"/></button>
      </div>
 </div>
<div class="clear"></div>
<div id="customerSummaryTableId" class="customerdashboardtable">
		<table class="reference">
				    <tr><td colspan="2" class="customerdashboardTableHeader"><spring:message code="label.dashboard.customer.summary"/></td></tr>
					<tr>
						<td class="tdLable"><spring:message code="columnTitle.inventory.customerName" /></td>
						<td id="customerNameId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.total.locations" /></td>
						<td id="customerLocationId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.total.assets" /></td>
						<td id="totalAssetsId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.average.utilization" /></td>
						<td id="averageUtilizationId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.average.cost.per.hour" /></td>
						<td id="averageCostperhourId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message	code="label.dashboard.total.labor" /></td>
						<td id="totalLaborId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message	code="label.dashboard.total.parts" /></td>
						<td id="totalPartsId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message	code="label.dashboard.total.travel" /></td>
						<td id="totalTravelId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.total.miscellaneous" /></td>
						<td id="totalMiscellaneousId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message	code="label.dashboard.total.drayage" /></td>
						<td id="totalDrayageId" class="center"></td>
					<tr>
						<td class="tdLable"><spring:message	code="label.dashboard.fixed.billing" /></td>
						<td id="fixedBillingId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.hourly.billing" /></td>
						<td id="hourlyBillingId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.total.spend.dollars" /></td>
						<td id="totalSpendDollarsId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.total.wo.processed" /></td>
						<td id="totalWoProcessedId" class="center"></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dashboard.total.avg.claim" /></td>
						<td id="totalAverageClaimId" class="center"></td>
					</tr>
				</table>
</div>
<div>
     <div id="adbContainer" class="dashboardbarlinechart"></div>
	<div class="clear"></div>
	<div id="outstandingQuoteAgeContainer"  class="customerQuoteChart"></div>
	<div id="totalClaimSpentAndIncidentsContainer" class="dashboardbarlinechart"></div>
	<div class="clear"></div>
	<div class="fieldSpacerWidth floatL">&nbsp;&nbsp;</div>
</div>
</body>
</html>