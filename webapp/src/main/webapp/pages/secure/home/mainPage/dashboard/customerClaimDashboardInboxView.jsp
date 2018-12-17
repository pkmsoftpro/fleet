<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<html>
	<head>
	    <title><s:text name="Customer Claim Dashboard List"/></title>
	    <s:head theme="twms"/>
	    <u:stylePicker fileName="SummaryTable.css"/>
	    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
	    <script type="text/javascript">
	    	dojo.require("dijit.layout.LayoutContainer");
	        dojo.require("dojox.layout.ContentPane");
	        dojo.require("twms.widget.Dialog");
	        
	        function exportToExcel(){
	        	  var folderName='${folderName}';
	              exportExcel("/customerClaimDashboards/populateCriteria","listCustomerClaimDashboardsToExcel.action");
	        }
	        
	       	var extraParams = {
		   		"hasAllChecked" : '${hasAllChecked}', 
		   		"paidMonth" : '${paidMonth}',
		   		"callType" : '${callType}' ,
		   		"inboxViewId" : '${inboxViewId}'
		   	};
	        
	        function refreshIt() { 
	            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("customerClaimDashboardTable"));
	        }  
	        
	        function getPageUrl(){
	    		var folderName=document.getElementById("folder").value;
	    		var hasAllChecked=document.getElementById("hasAllChecked").value;
	    		var paidMonth=document.getElementById("paidMonth").value;
	    		var callType=document.getElementById("callType").value;
	    		return "listCustomerClaimDashboards.action?folderName="+folderName+"&hasAllChecked="+hasAllChecked+"&paidMonth="+paidMonth+"&callType="+callType;
	    	}
	        
     	</script>
	    <u:stylePicker fileName="base.css"/>
	    <u:stylePicker fileName="yui/reset.css" common="true"/>
	    <u:stylePicker fileName="layout.css" common="true"/>
	    <%@include file="/i18N_javascript_vars.jsp"%>
	    <input type="hidden" id='folder' value='${folderName}'/>
	    <input type="hidden" id='hasAllChecked' value='${hasAllChecked}'/>
	    <input type="hidden" id='paidMonth' value='${paidMonth}'/>
	    <input type="hidden" id='callType' value='${callType}'/>
	    <s:hidden id="context" name="context" value="CustomerDashboardClaimSearch" />
	</head>
	<u:body >
	    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
	        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
	          <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="customerClaimDashboardTable" />
	       	  <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right" cssClass="download_to_excel_button" summaryTableId="fleetLocationsListing" />
	       	  <%@ include file="../../../common/spring/inboxViewForm.jsp"%>
	        </div>
	        <u:stylePicker fileName="SummaryTableButton.css" />
	       	<u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="customerClaimDashboardTable"
                        bodyUrl="customerClaimDashboardsBody" folderName="${folderName}"
                        detailUrl="customerClaimDashboardDetail" parentSplitContainerId="split" populateCriteriaDataOn="/customerClaimDashboards/populateCriteria" extraParamsVar="extraParams">
		            <c:forEach items="${tableHeadData}" var="column">
		               <c:choose>
		               		<c:when test="${column.id=='serialNumber' || column.id=='quoteNumber' || column.id=='serviceRequestNumber' || column.id=='claimNumber' || column.id=='customerLocationName'}">
		               			<script type="text/javascript" src="../scripts/tst_commonExt/HyperlinkRenderer.js"></script>
		               			<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}" rendererClass="tavant.twms.summaryTableExt.HyperlinkRenderer"/>
		           	   		</c:when>
		           	   		<c:otherwise>
		           	   			<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
		           	   		</c:otherwise>
		           	   </c:choose>
		           </c:forEach>        
	            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        	</u:summaryTable>
	    </div>
	    <jsp:include flush="true" page="../../../common/ExcelDowloadDialog.jsp"></jsp:include>
	    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
	</u:body>
</html>