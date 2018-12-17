<!DOCTYPE HTML>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='pragma' content='no-cache'>
<%@include file="i18N_dashboard_vars.jsp"%>
<script type="text/javascript" src="../scripts/vendor/angularjs/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/highcharts.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/highcharts-more.js"></script>
<script type="text/javascript" src="../scripts/vendor/highcharts/js/modules/exporting.js"></script>
<script type="text/javascript" src="../scripts/dashboard/dealerDashboardCharts.js"></script>
<u:stylePicker fileName="dashboard/dashboard.css" />
<script type="text/javascript">
    var dealerDashboardId ;
	function openDrildown(value) {
		var checked = $('#hasAllBranchesChecked').is(':checked');
		if(checked){
			dealerDashboardId=-1;
		}
		var tabName;
		if(value=='TOTAL_BRANCHES'){
			tabName='<s:text name="label.dealerDashboard.branchListing"/>';
			url="getDealerBranches?folderName=Dealer Branches";
		}else if(value=='FLEET_LOCATIONS'){
			tabName='<s:text name="label.dealerDashboard.fleetLocationListing"/>';
			url="getFleetLocations?folderName=Locations Listing"+"&hasAllChecked="+checked;
		}else if(value=='FLEET_ASSETS'){
			tabName='<s:text name="label.dealerDashboard.assetsListing"/>';
			url="fleetInventoryListing.action?folderName=RETAIL"+"&hasAllChecked="+checked;
		}else if(value=='MISSED_PM'){
			tabName='<s:text name="label.dealerDashboard.missedPMs"/>';
			url="dealerDashbardSR?folderName=Total Missed PMS"+"&missedPM=true&days=-1&dealerDashboardId="+dealerDashboardId+"&hasAllChecked="+checked;
		}else if(value=='CLAIM_PROCESSED'){
			tabName='<s:text name="label.dealerDashboard.totalClaimProcessed"/>';
			url="getDashboardFleetClaims?folderName=Total Claims Processed"+"&type=PROCESSED_CLAIMS&dealerDashboardId="+dealerDashboardId+"&hasAllChecked="+checked;
		}else if(value=='REQUIRING_INFO'){
			tabName='<s:text name="label.dealerDashboard.claimsRequiringInfo"/>';
			url="getDashboardFleetClaims?folderName=Claims Requiring Info"+"&type=REQUIRING_INFO_CLAIMS&dealerDashboardId="+dealerDashboardId+"&hasAllChecked="+checked;
		}else if(value=='OUTSTANDING_CLAIMS'){
			tabName='<s:text name="label.dealerDashboard.totalClaimOutstanding"/>';
			url="getDashboardFleetClaims?folderName=Total Claims Outstanding"+"&type=OUTSTANDING_CLAIMS&dealerDashboardId="+dealerDashboardId+"&hasAllChecked="+checked;
		}
  		    parent.publishEvent("/tab/open", {
			label : tabName,
			url : url,
			decendentOf :i18N.home_tab_label,
			forceNewTab : true
		}); 
	}
	
	function openChartDrilDown(tabName,url) {
		parent.publishEvent("/tab/open", {
		label : tabName,
		url : url,
		decendentOf :i18N.home_tab_label,
		forceNewTab : true
	  }); 
    }
	
</script>

</head>
<body>
<form action="">
    <div class="floatL">
      <div id="checkboxForAll" class="floatL"><div class="labelStyle floatL"><spring:message code="label.dealerDashboard.all"/>:</div><div class="floatL"><input id="hasAllBranchesChecked" type="checkbox" name="isDealerBranchChanged"></input></div></div>
      <div class="fieldSpacerWidth floatL">&nbsp;</div>
      <div class="floatL">
        <button id="refreshButton" type="button" class="blue-btn btn-primary" onclick="javascript:getDealerDashboardInfo(true);"><spring:message code="button.common.refresh"/></button>
      </div>
   </div>
    <div id="loading" class="floatL">
       &nbsp;<img src="../image/indicator.gif" alt="Loader" /><spring:message code="label.commom.loading"/>
     </div>
   <div class="clear"></div>	
     <div id="showDashboard">
	 <div class="dashboardcontainer">
	    <table class="reference">
				    <tr><td colspan="2" class="dashboardSummaryHeader"><spring:message code="label.dealerDashboard.dealerSummary"/></td></tr>
					<tr>
						<th colspan="2"><spring:message	code="label.dealerDashboard.baseSummary" /></th>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.dealerName" /></td>
						<td id="dealerName"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.branches" /></td>
						<td><a id="totalBranches" href="javascript:openDrildown('TOTAL_BRANCHES');"></a></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.locations" /></td>
						<td><a id="totalFleetLocations" href="javascript:openDrildown('FLEET_LOCATIONS');"></a></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard..assets" /></td>
						<td><a id="totalFleetAssets" href="javascript:openDrildown('FLEET_ASSETS');"></a></td>
					</tr>
					<tr>
						<th colspan="2"><spring:message	code="label.dealerDashboard.activitySummary" /></th>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.totalFleetAmount" /></td>
						<td id="totalFleetDollars"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message	code="label.dealerDashboard.totalClaimProcessed" /></td>
						<td><a id="claimProcessed"  href="javascript:openDrildown('CLAIM_PROCESSED');"></a></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.avgClaim" /></td>
						<td id="avgclaim"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.totalClaimOutstanding" /></td>
						<td><a id="outstandingClaims" href="javascript:openDrildown('OUTSTANDING_CLAIMS');"></a></td>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.claimsRequiringInfo" /></td>
						<td><a id="requiringInfo" href="javascript:openDrildown('REQUIRING_INFO');"></a></td>
					</tr>
					<tr>
						<th colspan="2"><spring:message code="label.dealerDashboard.performance"/></th>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.pmAssign" /></td>
						<td id="pmassigned"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.pmCompleted" /></td>
						<td id="pmcompleted"/>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.missedpms" /></td>
						<td><a id="missedpms" href="javascript:openDrildown('MISSED_PM');"></a></td>
					</tr>
					<tr>
						<td class="tdLable"><spring:message code="label.dealerDashboard.estimatedLostRevenue" /></td>
						<td id="estimatedRevenue"/>
					</tr>
				</table>
		</div>
		<div id="dealerServiceResponseChart" class="dashboardcontainer"></div>
		<div class="clear"></div>	
		<div id="dealerBarChart" class="dashboardcontainer"></div>
		<div id="containerDealerSpeedoMeter" class="dashboardcontainer"></div> 
		<div class="clear"></div>
	    <div class="fieldSpacerWidth floatL">&nbsp;</div>
         </div>	
</form>	
</body>
</html>