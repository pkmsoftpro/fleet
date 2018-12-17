<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
   <u:stylePicker fileName="ui-ext/actionResult/actionResult.css"/>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />
<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript">
	dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dojox.layout.ContentPane");
    dojo.require("twms.widget.Dialog");
    function refreshIt() {
        publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("alarmCodeTable"));
    }
    <authz:ifPermitted resource="manageErrorCodes">
    function createAlarmCode(evt) {
        parent.publishEvent("/tab/open", {
            label : i18N.create_alarm_code,
            decendentOf : getMyTabLabel(),
            url : "../create_alarm_code.action",
            forceNewTab : true
        });
    }
   </authz:ifPermitted>
</script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="/i18N_javascript_vars.jsp"%>
</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
      	<u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="alarmCodeTable" />
			<authz:ifPermitted resource="manageErrorCodes">
				<u:summaryTableButton id="createAlarmCodeButton"
					label="label.alarmcode.createAlarmCode" onclick="createAlarmCode"
					summaryTableId="alarmCodeTable" cssClass="create_warehouse_button" />
			</authz:ifPermitted>
		</div>    
                <u:stylePicker fileName="SummaryTableButton.css" />
	
		<%-- We don't need folder name info. Hence just setting some junk value here --%> 
        
        <u:stylePicker fileName="SummaryTableButton.css" /> 
        
        <u:summaryTable
		eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler"
		id="alarmCodeTable" bodyUrl="get_alarm_code_detail.action"
		folderName="ALARMCODE" previewUrl="view_alarm_code_preview.action"
		detailUrl="../view_alarm_code.action" previewPaneId="preview"
		parentSplitContainerId=""
		populateCriteriaDataOn="/alarmCode/populateCriteria">
		
		<s:iterator value="tableHeadData">
			<u:summaryTableColumn id="%{id}" label="%{title}"
				width="%{widthPercent}" idColumn="%{idColumn}"
				labelColumn="%{labelColumn}" hidden="%{hidden}" />
		</s:iterator>
		<script type="text/javascript"
			src="scripts/SummaryTableTagEventHandler.js"></script>
	</u:summaryTable>
	
	<div dojoType="dojox.layout.ContentPane" id="preview"></div>
	</div>
</u:body>
</html>