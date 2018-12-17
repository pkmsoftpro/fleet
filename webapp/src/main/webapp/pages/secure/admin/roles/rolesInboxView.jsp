<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="authz" uri="authz" %>

<html>
<head>
<title><s:text name="title.roles.manageRoles"/></title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />

<script type="text/javascript" src="scripts/domainUtility.js"></script>
<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>

<script type="text/javascript">
dojo.require("dojox.layout.ContentPane");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("rolesTable"));
        }                                
        function exportToExcel() {
        	exportExcel("/notification/populateCriteria","export_roles_to_excel.action");
        }                
	    
	    function addRole() {
	        var thisTabLabel = getMyTabLabel();			
            parent.publishEvent("/tab/open", {label: "<s:text name='title.roles.createRole'/>",
            								  url: "../createRole.action",
            								  decendentOf: thisTabLabel,
            								  forceNewTab: true});
        }
	    
</script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="/i18N_javascript_vars.jsp"%>
</head>
<u:body>
	<div dojoType="dijit.layout.LayoutContainer"
		style="width: 100%; height: 100%">
	<div dojoType="dijit.layout.ContentPane" layoutAlign="top"
		class="buttonContainer">
	
	<u:summaryTableButton id="addRoleButton" label="button.roles.createRole" 
	onclick="addRole" summaryTableId="rolesTable" cssClass="create_claim_button"/>
	
	<u:summaryTableButton id="refreshButton" label="button.common.refresh" 
		onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="rolesTable" /> 
	<u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel"
		onclick="exportToExcel" align="right" cssClass="download_to_excel_button" 
		summaryTableId="rolesTable" />
	</div>

	<div dojoType="dijit.layout.SplitContainer" layoutAlign="client"
		orientation="vertical" sizerWidth="4" activeSizing="false" id="split"
		persist="false"><u:stylePicker fileName="SummaryTableButton.css" />
	<u:summaryTable
		eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler"
		id="rolesTable" bodyUrl="rolesBody.action"
		folderName="%{folderName}" previewUrl="rolesPreview.action"
		detailUrl="../rolesDetail.action" 
		previewPaneId="preview" parentSplitContainerId="split"
		populateCriteriaDataOn="/notification/populateCriteria">
		<s:iterator value="tableHeadData">          
            	<u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}" labelColumn="%{labelColumn}" hidden="%{hidden}"/>          
       	</s:iterator>
		<script type="text/javascript"
			src="scripts/SummaryTableTagEventHandler.js"></script>
	</u:summaryTable>
	
	<!-- <div dojoType="dojox.layout.ContentPane" id="preview"></div> -->
	</div>
	</div>
	<jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>