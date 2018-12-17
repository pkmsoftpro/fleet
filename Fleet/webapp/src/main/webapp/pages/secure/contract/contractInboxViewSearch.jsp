<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<html>
<head>
<title><s:text name="title.managePolicy.contractInboxView" /></title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />
<script type="text/javascript">        
        dojo.require("dojox.layout.ContentPane");
    </script>
<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript">
        function exportToExcel(){
            exportExcel("/contractSearch/populateCriteria","exportSRSearchToExcel.action");
           }
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("contractConfigTable"));
        }
        
		dojo.addOnLoad(function () {
			parent.publishEvent("/accordion/refreshcontractsearchfolders");
	    });
		var extraParams = {
		        <s:if test="inboxViewId!=null && !inboxViewId.trim().equals('')">
				inboxViewId : '<s:property value="inboxViewId"/>',
			</s:if>
	    	domainPredicateId : <s:property value="domainPredicateId"/>
	    };
		function getPageUrl() {
	    	return '../dynamicContractSearchResult.action?domainPredicateId=<s:property value="domainPredicateId"/>&'+
	    			'folderName=Contracts Search&'+
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
			parent.publishEvent("/tab/reload", {label: "Edit Expression",
												 url: url,decendentOf:"Home",
												tab: getTabHavingId(getTabDetailsForIframe().tabId)});
		}
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
        <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="contractConfigTable"/>
         <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel"
               align="right" cssClass="download_to_excel_button" summaryTableId="contractConfigTable"/>
               <u:summaryTableButton id="searchButton" label="button.view.showSearchQuery" onclick="handleShowSearch" summaryTableId="contractConfigTable"cssClass="show_search_query_button" />
               
            
                <%@ include file="../common/inboxViewForm.jsp"%>
        </div>
            <s:hidden id="context" name="context"/>
        <s:hidden id="contextName" name="contextName" />
        <s:hidden id="savedQueryId" name="savedQueryId" />
        <s:hidden id="domainPredicateId" name="domainPredicateId" />
        <s:hidden id="folderName" value="Contracts Search" />
        <div dojoType="dijit.layout.SplitContainer" layoutAlign="client" orientation="vertical" sizerWidth="4" activeSizing="false" id="split" persist="false">
            <u:stylePicker fileName="SummaryTableButton.css" />
            <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="contractConfigTable"
                bodyUrl="contractSearchBody.action" extraParamsVar="extraParams" folderName="Contracts Search" detailUrl="contract_detail"
                parentSplitContainerId="" populateCriteriaDataOn="/contractSearch/populateCriteria">
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
     <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>
