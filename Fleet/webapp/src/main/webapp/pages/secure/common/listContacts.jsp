<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
<head>
<title><s:text name="title.customer.contactInboxView" />
</title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />
<script type="text/javascript">
    dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dojox.layout.ContentPane");
</script>
<script type="text/javascript">
    dojo.require("twms.widget.Dialog");

    function refreshIt() {
        publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("contactTable"));
    }

    function exportToExcel() {
        exportExcel("/claim/populateCriteria", "exportContactsToExcel.action");
    }

</script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="../../../i18N_javascript_vars.jsp"%>
	
</head>
<u:body>

    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">

            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="contactTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="contactTable" />
        </div>

            <u:stylePicker fileName="SummaryTableButton.css" />
            <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="contactTable" bodyUrl="contactListingTableBody"
                folderName="${folderName}" previewPaneId="preview" detailUrl="" parentSplitContainerId=""
                populateCriteriaDataOn="/claim/populateCriteria">
                <c:forEach items="${tableHeadData}" var="column">
                    <s:if test="imageColumn ">
                        <script type="text/javascript" src="scripts/tst_commonExt/ImageRenderer.js"></script>
                        <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                            rendererClass="tavant.twms.summaryTableExt.ImageRenderer" labelColumn="${column.labelColumn}" hidden="${column.hidden}"
                            disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}" />
                    </s:if>
                    <s:else>
                        <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                            labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}"
                            disableSorting="${column.disableSorting}" />
                    </s:else>
                </c:forEach>
                <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
            </u:summaryTable>

    </div>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
</u:body>
</html>