<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
<title><s:text name="title.serviceRequest.serialNumberRequestHistory" /></title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />

<script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript">

        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");

        var extraParams = {
    		"serialNumber" : "${param.serialNumber}"
    	};

        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("serviceRequestTable"));
        }  
        
        function exportToExcel() {
        	exportExcel("/serviceRequest/populateCriteria","exportRequestHistoryDataToExcel.action");
        }
    </script>
<u:stylePicker fileName="base.css " />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="/i18N_javascript_vars.jsp"%>

</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="serviceRequestTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="serviceRequestTable" />
        </div>

        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="serviceRequestTable"
            bodyUrl="serialNumberServiceRequestBody.action" folderName="${folderName}" detailUrl="serviceDetail.action" parentSplitContainerId=""
            extraParamsVar="extraParams" populateCriteriaDataOn="/serviceRequest/populateCriteria">
            <c:forEach items="${tableHeadData}" var="column">
                <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                    labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}"
                    disableSorting="${column.disableSorting}" />
            </c:forEach>
            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
    </div>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>