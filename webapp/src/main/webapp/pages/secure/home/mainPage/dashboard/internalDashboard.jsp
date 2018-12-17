<!DOCTYPE HTML>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<script type="text/javascript" src="../scripts/vendor/angularjs/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/highcharts.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/highcharts-more.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/modules/exporting.js"></script>
<script type="text/javascript" src="../scripts/dashboard/internalDashboard.js"></script>
<script type="text/javascript" src="../scripts/dashboard/creditRescindPerformance.js"></script>
<%@include file="i18N_dashboard_vars.jsp"%>
<u:stylePicker fileName="dashboard/dashboard.css" />
<script type="text/javascript">
    function mtdClaimsPaidDrildown() {
    	var url="internalDashboardClaims?folderName=Claims Paid";
		parent.publishEvent("/tab/open", {
		label : dashboard_i18N.claimPaid,
		url : url,
		decendentOf : i18N.home_tab_label,
		forceNewTab : true
	  }); 
    }
</script>
</head>
<body>
<form action="">
   <div id="loadingInternalDashboard" class="floatL">
       &nbsp;<img src="../image/indicator.gif" alt="Loader" /><spring:message code="label.commom.loading"/>
   </div>
   <div class="clear"></div>	
     <div id="showInternalDashboard">
	 <div class="internaldbcontainer" id="internaldbcontainer">
	    <table class="internalDashboardtable">
				 	<tr>
						<th><spring:message code="label.internalDashboard.metrics" /></th>
						<th><spring:message code="label.internalDashboard.actuals" /></th>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.internalDashboard.mtdClaimsReceived" /></td>
						<td id="mtdClaimsReceived"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message	code="label.internalDashboard.mtdClaimsProcessed" /></td>
						<td id="mtdClaimsProcessed"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.internalDashboard.mtdClaimsPaid" /></td>
						<td><a id="mtdClaimsPaid" href="javascript:mtdClaimsPaidDrildown();"></a></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.internalDashboard.mtdBacklogAvg" /></td>
						<td id="mtdBacklogAvg"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.internalDashboard.mtdClaimsAged" /></td>
						<td id="mtdClaimsAged"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.internalDashboard.mtdAvgClaimsAge" /></td>
						<td id="mtdAvgClaimsAge"/>
					</tr>
				</table>
		</div>
		<div id="invoiceChart" class="dashboardbarlinechart"></div>
		<div class="clear"></div>
		<div id="outstandingQuoteAgeContainer" class="customerQuoteChart"></div>
		<div  class="dashboardbarlinechart" id="creditRescindContainer"></div>
		<div class="clear"></div>
		<div class="fieldSpacerWidth floatL">&nbsp;</div>
		<div class="clear"></div>
         </div>	
</form>	
</body>
</html>