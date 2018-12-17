<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%--
  @author Jhulfikar Ali
--%>

<html>
<head>
    <title><s:text name="title.callTypes"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>

    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>

    <script type="text/javascript">
	    var extraParams = {};

	    
	    function refreshIt() {
	        publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("callTypeTable"));
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
    	<u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" 
    		align="right" cssClass="refresh_button" summaryTableId="callTypeTable"/>
    </div>
    <div dojoType="dijit.layout.SplitContainer" layoutAlign="client" orientation="vertical" sizerWidth="4" activeSizing="false" id="split" persist="false">
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="callTypeTable" 
                        bodyUrl="callTypesBody.action?selectedBusinessUnit=%{selectedBusinessUnit}" folderName="Manage Call Type"
                        detailUrl="../callTypeDetail" parentSplitContainerId=""
                        extraParamsVar="extraParams" populateCriteriaDataOn="/processorAvailable/populateCriteria">
            <s:iterator value="tableHeadData">
               	<u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}" 
               		labelColumn="%{labelColumn}" hidden="%{hidden}" 
               		disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}" />
            </s:iterator>
        <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script></u:summaryTable>
    </div>
  </div>
  <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
  </u:body>
</html>
