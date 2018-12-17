<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
<head>
<title><s:text name="title.invoive.inboxView" /></title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />
<script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript">

        dojo.require("twms.widget.Dialog");
        
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "invoiceSearchTable"));
        }        
        
       function exportToExcel(){
        	exportExcel("/invoice/populateCriteria","exportInvoiceToExcel.action");
        	} 
       function exportToPDF(event, dataId) {
   		var thisTabLabel = getMyTabLabel();
   		var url = "printInvoiceDetails.action?&";
   		  if(dataId.length > 0){
   		url += "id=" + dataId;
   		parent.publishEvent("/tab/open", {label: "Print Invoice Details",
				  url: url,
				  decendentOf: thisTabLabel,
				  forceNewTab: true});
   		 }
   }
       
       dojo.addOnLoad(function () {
			parent.publishEvent("/accordion/refreshinvoicesearchfolders");
	    });
  
    function handleShowSearch(event, dataId) {
        var formObj = dojo.byId("showSearchQuerySubmitForm");
        formObj.action = "showPreDefinedInvoiceSearchQuery.action";
        formObj.submit();
    }
    
    var extraParams = {
			<s:if test="inboxViewId!=null && !inboxViewId.trim().equals('')">
				inboxViewId : '<s:property value="inboxViewId"/>',
			</s:if>
	    	queryId :'<s:property value="queryId" />',
	    	notATemporaryQuery : '<s:property value="notATemporaryQuery"/>',
	    	savedQueryName : '<s:property value="savedQueryName" escapeJavaScript="true"/>'
	    };
    
    function getPageUrl() {
        <s:url var="theUrl" action="showPreDefinedInvoiceSearchResults.action" escapeAmp="false">
            <s:param name="context" value="context" />
            <s:param name="folderName" value="folderName" />
            <s:param name="queryId" value="queryId" />
            <s:param name="savedQueryName" value="savedQueryName" />
            <s:param name="notATemporaryQuery" value="notATemporaryQuery" />
        </s:url>
        return '<s:property value="%{#theUrl}" escapeHtml="false"/>';
    }
   function closeTabAfterFinishing() {
       var tabDetails = getTabDetailsForIframe();
       var tab = getTabHavingId(tabDetails.tabId);
       parent.publishEvent("/tab/close", {tab:tab});
   } 
    
    function deleQuery(){
    	var url = 'deletePredefinedSearchQuery.action?queryId=<s:property value="queryId"/>';			
		var param ='<s:property value="queryId"/>';		
		twms.ajax.fireHtmlRequest(url, param,
				function(data){
			parent.publishEvent("/accordion/refreshinvoicesearchfolders");
			closeTabAfterFinishing();
			});
	}
</script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="../../../i18N_javascript_vars.jsp"%>
</head>
<u:body>
    <s:hidden name="invoiceSearchCriteria" value="invoiceSearchCriteria" />
    <s:set name="invoiceSearchCriteria" value="invoiceSearchCriteria" />
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">

            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="invoiceSearchTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="invoiceSearchTable" />
                  <u:summaryTableButton id="printInvoiceDetails" label="label.common.print" onclick="exportToPDF" align="right"
                cssClass="download_to_excel_button" summaryTableId="invoiceTable" />
            <u:summaryTableButton id="searchButton" label="button.view.showSearchQuery" onclick="handleShowSearch" summaryTableId="invoiceSearchTable"
                cssClass="show_search_query_button" />
            <s:if test="savedQueryName!=null">
                <u:summaryTableButton id="deleteQueryButton" label="button.common.delete" onclick="deleQuery" summaryTableId="inventorySearchTable"
                    cssClass="show_search_query_button" />
            </s:if>
        </div>

        <form name="showSearchQuerySubmitForm" id="showSearchQuerySubmitForm">
            <s:hidden id="folder" name="folderName" />
            <s:hidden id="context" name="context" value="InvoiceSearch" />
            <s:hidden id="queryId" name="queryId" />
            <s:hidden name="notATemporaryQuery" />
            <s:hidden name="savedQueryName" />
        </form>

        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="invoiceSearchTable"
            bodyUrl="preDefinedInvoiceSearchSummaryBody.action" extraParamsVar="extraParams" folderName="Invoice Search" 
           detailUrl=""  parentSplitContainerId="" populateCriteriaDataOn="/invoice/populateCriteria">
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
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>