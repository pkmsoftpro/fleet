<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<html>
<head>
<title></title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />
<script type="text/javascript">        
        dojo.require("dojox.layout.ContentPane");
    </script>
<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript" src="scripts/labels.js"></script>
<script type="text/javascript">
        function exportToExcel(){
            exportExcel("/fleetInventorySearch/populateCriteria","exportInvSearchToExcel.action");
           }
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("fleetInventorySearchConfigTable"));
        }
        
		dojo.addOnLoad(function () {
			parent.publishEvent("/accordion/refreshfleetinventorysearchfolders");
	    });
		var extraParams = {
		        <s:if test="inboxViewId!=null && !inboxViewId.trim().equals('')">
				inboxViewId : '<s:property value="inboxViewId"/>',
			</s:if>
	    	domainPredicateId : <s:property value="domainPredicateId"/>
	    };
		function getPageUrl() {
	    	return '../dynamicFleetInventorySearchResult.action?domainPredicateId=<s:property value="domainPredicateId"/>&'+
	    			'folderName=Inventory Search&'+
	    			'context=<s:property value="context"/>&'+
	    			'savedQueryId=<s:property value="savedQueryId"/>';
	    }
		function handleShowSearch(event, dataId) {
			var id=document.getElementById("domainPredicateId").value;
			var url = "../detail_view_search_expression.action";
			url += "?id=" + id;
			var contextName=document.getElementById("contextName").value;
			url += "&context="+contextName;
			var savedQueryId=document.getElementById("savedQueryId").value;
			url += "&savedQueryId="+savedQueryId;
			var folderName=document.getElementById("folderName").value;
			url += "&folderName="+folderName;
			var isCreateLabelForInventory=document.getElementById("isCreateLabelForInventory").value;
		    url += "&isCreateLabelForInventory="+isCreateLabelForInventory; 
            /**todo-get rid of this hard coding.*/
			parent.publishEvent("/tab/reload", {label: "Edit Expression",
												 url: url,decendentOf:"Home",
												tab: getTabHavingId(getTabDetailsForIframe().tabId)});
		}
		
		 var applyActionUrl;
	        var removeActionUrl;

	        dojo.addOnLoad(function() {
	        		removeActionUrl = "remove_labels_on_FleetInventory.action?";
	        		applyActionUrl = "apply_labels_on_FleetInventory.action?";
	        		checkActionUrl="check_labels_on_FleetInventory.action?"
	        });
	        
    </script>
<style type="text/css">
#labels_div {
	background: #F3FBFE;
	opacity: 1.0;
}
</style>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="/i18N_javascript_vars.jsp"%>
</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
        <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="fleetInventorySearchConfigTable"/>
         <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel"
               align="right" cssClass="download_to_excel_button" summaryTableId="fleetInventorySearchConfigTable"/>
            <s:if test="isCreateLabelForInventory=='true'">
                <u:summaryTableButton id="labelButton" label="button.common.addLabels" onclick="showLabels" summaryTableId="fleetInventorySearchConfigTable"
                    cssClass="show_search_query_button" />
            </s:if>
            <u:summaryTableButton id="searchButton" label="button.view.showSearchQuery" onclick="handleShowSearch" summaryTableId="fleetInventorySearchConfigTable"cssClass="show_search_query_button" />
            
            <%-- <%@ include file="../common/inboxViewForm.jsp"%> --%>
        </div>
          <s:hidden id="context" name="context"/>
        <s:hidden id="contextName" name="contextName" />
        <s:hidden id="savedQueryId" name="savedQueryId" />
        <s:hidden id="domainPredicateId" name="domainPredicateId" />
        <s:hidden id="folderName" value="Inventory Search" />
        <s:hidden id="isCreateLabelForInventory" name="isCreateLabelForInventory"/> 
        <div dojoType="dijit.layout.SplitContainer" layoutAlign="client" orientation="vertical" sizerWidth="4" activeSizing="false" id="split" persist="false">
            <u:stylePicker fileName="SummaryTableButton.css" />
            <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="fleetInventorySearchConfigTable"
                bodyUrl="fleetInventorySearchBody.action" extraParamsVar="extraParams" folderName="Inventory Search" detailUrl="equipmentDetailsInfo.action" multiSelect="true"
                parentSplitContainerId="" populateCriteriaDataOn="/fleetInventorySearch/populateCriteria">
                <s:iterator value="tableHeadData">
                    <s:if test="imageColumn ">
                        <script type="text/javascript" src="scripts/tst_commonExt/ImageRenderer.js"></script>
                        <u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}"
                            rendererClass="tavant.twms.summaryTableExt.ImageRenderer" labelColumn="%{labelColumn}" hidden="%{hidden}"
                            disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}" />
                    </s:if>
                    <s:else>
                        <u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}" labelColumn="%{labelColumn}"
                            hidden="%{hidden}" disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}" />
                    </s:else>
                </s:iterator>
                <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script>
            </u:summaryTable>
        </div>
    </div>
     <s:hidden name="labelType" value="%{@tavant.twms.domain.common.Label@FLEET_INVENTORY}" />
     <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
     <jsp:include flush="true" page="../common/labelsDialog.jsp"></jsp:include>
</u:body>
</html>
