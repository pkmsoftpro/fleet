<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>Dealer Ship Summary</title>
		<s:head theme="twms"/>
		<u:stylePicker fileName="SummaryTable.css"/>
		<u:stylePicker fileName="base.css"/>
    	<u:stylePicker fileName="yui/reset.css" common="true"/>
    	<u:stylePicker fileName="layout.css" common="true"/>
		
		<script type="text/javascript">
        	dojo.require("dijit.layout.LayoutContainer");
        	dojo.require("dojox.layout.ContentPane");
            dojo.require("twms.widget.Dialog");
        	function refreshIt() {
                publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("dealerShipTable"));
            }  
            function exportToExcel() {
                var folderName='${folderName}';
                exportExcel("/claim/populateCriteria","exportPriceConditionToExcel.action");
            }
            
    	</script>
    	
    	<script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    	<%@include file="/i18N_javascript_vars.jsp"%>
    	
	</head>
	
	<u:body >
	    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
	        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
	            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
	                summaryTableId="dealerShipTable" />
	            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
	                cssClass="download_to_excel_button" summaryTableId="dealerShipTable" />
	        </div>
	        <u:stylePicker fileName="SummaryTableButton.css" />
	        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="dealerShipTable"
	                        bodyUrl="dealershipbody" folderName="${folderName}"
	                        detailUrl="dealershipshow" parentSplitContainerId="split"
	                        populateCriteriaDataOn="/claim/populateCriteria">
	            <c:forEach items="${tableHeadData}" var="column">
	                  <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" 
			                  	idColumn="${column.idColumn}" 
			                  	labelColumn="${column.labelColumn}" 
			                  	hidden="${column.hidden}" 
			                  	disableFiltering="${column.disableFiltering}" 
			                  	disableSorting="${column.disableSorting}"/>
	            </c:forEach>
	            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
	        </u:summaryTable>
	    </div>
	    <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
	</u:body>
</html>