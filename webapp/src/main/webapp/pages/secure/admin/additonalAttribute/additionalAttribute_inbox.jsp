<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<html>
<title>::<s:text name="title.common.warranty" />::</title>
<s:head theme="twms" />

<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>

<script type="text/javascript">
dojo.require("dojox.layout.ContentPane");
function refreshIt() {
	publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("attributeListTable"));
}

<authz:ifPermitted resource="additionalAttributes">   
function createAttribute(event, dataId) {
	var thisTabLabel = getMyTabLabel();
	parent.publishEvent("/tab/open", 
						{label:i18N.create_attribute, 
						 url: "../attributes_detail.action", 
						 decendentOf: thisTabLabel ,
						 forceNewTab: true
						 });
}
</authz:ifPermitted>
function exportToExcel(){
 exportExcel("/attributes/populateCriteria","exportattributesListToExcel.action");
}

</script>
<u:stylePicker fileName="base.css"/>
<u:stylePicker fileName="yui/reset.css" common="true"/>
<u:stylePicker fileName="layout.css" common="true"/>
<u:stylePicker fileName="SummaryTable.css"/>
<%@include file="/i18N_javascript_vars.jsp"%>
<u:body>
<div dojoType="dijit.layout.LayoutContainer" layoutChildPriority="top-bottom"
	style="width: 100%; height: 100%">
	<div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">		
		<u:summaryTableButton id="refreshButton"
			label="button.common.refresh" onclick="refreshIt"
			align="right" cssClass="refresh_button" summaryTableId="attributeListTable" />
    <authz:ifPermitted resource="additionalAttributes">
		<u:summaryTableButton id="createattributesButton"
			label="button.manageAttributes.create"
			onclick="createAttribute" summaryTableId="attributeListTable"
			cssClass="new_warranty_registration_button" />
	</authz:ifPermitted>
        <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel"
            align="right" cssClass="download_to_excel_button" summaryTableId="attributeListTable"/>
	</div>
	<div dojoType="dijit.layout.SplitContainer" layoutAlign="client"
		orientation="vertical" sizerWidth="4" activeSizing="false" id="split"
		persist="false">
		<u:stylePicker fileName="SummaryTableButton.css" /> <u:summaryTable id="attributeListTable" eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler"
			bodyUrl="attributes_table_body.action" folderName="%{folderName}"
			previewUrl="attributes_preview.action"
			detailUrl="../attributes_detail.action" previewPaneId="preview"
			parentSplitContainerId="split"
            populateCriteriaDataOn="/attributes/populateCriteria">
			<s:iterator value="tableHeadData">
				<u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}"
					idColumn="%{idColumn}" labelColumn="%{labelColumn}"
					hidden="%{hidden}" disableFiltering="%{disableFiltering}"/>
			</s:iterator>
            <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
	</div>
</div>
  <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>
