<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<html>
<head>
    <title><s:text name="title.listOfValues"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
    
    <script type="text/javascript">
		
		dojo.require("dojox.layout.ContentPane");

       
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "lovTypeTable"));
        }
       
		function exportToExcel(){
         exportExcel("/lovType/populateCriteria","export_lov_type_to_excel.action");
        }

    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <%@include file="/i18N_javascript_vars.jsp"%>
  </head>
  <u:body>
  <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
       
        <u:summaryTableButton id="refreshButton" label="button.common.refresh"
                    onclick="refreshIt" align="right" cssClass="refresh_button"
                    summaryTableId="lovTypeTable"/>
        <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel"
                    onclick="exportToExcel" align="right" cssClass="download_to_excel_button"
                    summaryTableId="lovTypeTable"/>
    </div>
    <div dojoType="dijit.layout.SplitContainer" layoutAlign="client"
         orientation="vertical" sizerWidth="4" activeSizing="false" id="split"
         persist="false">
        <%-- We don't need folder name info. Hence just setting some junk value
        here --%>
        <u:stylePicker fileName="SummaryTableButton.css" /> <u:summaryTable eventHandlerClass="twms.lovInboxView.EventHandler" id="lovTypeTable"
                          bodyUrl="get_lov_type_body.action"
                          folderName="LOV_TYPE"
                          detailUrl="../list_lov.action"
                          parentSplitContainerId="split"
                          populateCriteriaDataOn="/lovType/populateCriteria">
            <s:iterator value="tableHeadData">
                <u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}"
                            idColumn="%{idColumn}" labelColumn="%{labelColumn}"
                            hidden="%{hidden}" disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}"/>
            </s:iterator>
        <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script></u:summaryTable>
    </div>
  </div>
  <script type="text/javascript">
	dojo.declare("twms.lovInboxView.EventHandler", tavant.twms.summaryTable.BasicTwmsEventHandler, {
		_getDetailUrl : function (folder, id) {
	        var url = twms.lovInboxView.EventHandler.superclass._getDetailUrl.call(this, folder, id);
	        return url ? url + "&lovTypeName=" + id : null;
		}
	});
  </script>
   <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
  </u:body>
</html>